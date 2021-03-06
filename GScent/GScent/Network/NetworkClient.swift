//
//  NetworkClient.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

typealias Headers = [String: Any]
typealias NetworkCompletionBlock = (_ response: Any?, _ headers: Headers?, _ error: CoreError?) -> Void
typealias Parameters = [String: String]
typealias JSONDictionary = [AnyHashable: Any]
typealias JSONArray = [Any]

protocol NetworkClientAdaptable {
    func sendRequest(withRequestBody requestBody: String?,
                     requestHeaders: Headers,
                     queryParameters: Parameters,
                     completionHandler: @escaping NetworkCompletionBlock)
}


class NetworkClient: NetworkClientAdaptable {
    private let endpoint: NetworkEndpointModel
    private(set) var reachablity: ReachabilityAdapter
    
    init(endpoint: NetworkEndpointModel,
         reachablity: ReachabilityAdapter = Reachability()!) {
        self.endpoint = endpoint
        self.reachablity = reachablity
    }
    
    // As of now, not handling any kind of network. Will use the offline file data. If time permits, implement URLSession and can use MAMP local server to have a real network connection
    func sendRequest(withRequestBody requestBody: String?,
                     requestHeaders: Headers,
                     queryParameters: Parameters,
                     completionHandler: @escaping NetworkCompletionBlock) {
        guard let _ = try? endpoint.asURLRequest() else {
            completionHandler(nil, nil, CoreError(type: .invalidRequestFormat))
            return
        }
        
        loadOfflineData(completionHandler: completionHandler)
    }
}

extension NetworkClient {
    private func loadOfflineData(completionHandler: @escaping NetworkCompletionBlock) {
        let jsonData = JSONHelper.jsonFileToDataAndHttpStatus(jsonName: endpoint.offlineFileName)
        
        var error: CoreError?
        if let statusCode = jsonData.httpStatus, !(200...299).contains(statusCode) {
            error = CoreError(type: .serverError)
            completionHandler(nil, nil, error)
            return
        }
        
        guard let data = jsonData.data else {
            completionHandler(nil, nil, CoreError(type: .serverError))
            return
        }
        
        if let parsedDictResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary {
            completionHandler(parsedDictResponse, nil, error)
            return
        }
        
        if let parsedArrayResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONArray {
            completionHandler(parsedArrayResponse, nil, error)
            return
        }
        
        completionHandler(nil, nil, error)
    }
}
