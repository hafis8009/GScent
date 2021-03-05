//
//  NetworkEndpointModel.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

struct NetworkEndpointModel {
    let baseUrl: String
    let path: String
    let offlineFileName: String
}

extension NetworkEndpointModel: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseUrl)?.appendingPathComponent(path) else {
            throw CoreError(type: .badUrl)
        }
        return URLRequest(url: url)
    }
}
