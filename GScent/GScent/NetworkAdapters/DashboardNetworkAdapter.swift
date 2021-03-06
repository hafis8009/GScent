//
//  DashboardNetworkAdapter.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

class DashboardNetworkAdapter {
    let networkClient: NetworkClientAdaptable
    
    init(networkClient: NetworkClientAdaptable) {
        self.networkClient = networkClient
    }
    
    func getDashboardItems(completion: @escaping ([DashboardSectionModel]?, CoreError?) -> Void) {
        networkClient.sendRequest(withRequestBody: nil,
                                  requestHeaders: [:],
                                  queryParameters: [:]) { response, headers, error in
            if error == nil,
                let jsonDict = response as? JSONDictionary,
                let json = jsonDict["rows"],
                let response = try? JSONSerialization.data(withJSONObject: json, options: []) {
                do {
                    let decoder = JSONDecoder()
                    let sections = try decoder.decode([DashboardSectionModel].self, from: response)
                    completion(sections, nil)
                } catch {
                    completion(nil, CoreError(error: error))
                }
            } else {
                completion(nil, error)
            }
        }
    }
}
