//
//  CoreError.swift
//  GScent
//
//  Created by AdibUser on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

enum ErrorType: String {
    case notReachable
    case badUrl
    case invalidRequestFormat
    case serverError
    
    var title: String {
        return UIStrings.genericErrorTitle
    }
    
    var message: String {
        switch self {
        case .badUrl:
            return UIStrings.badURLErrorMessage
        case .invalidRequestFormat:
            return UIStrings.badURLErrorMessage
        default:
            return UIStrings.genericErrorMessage
        }
    }
    
    var description: String {
        switch self {
        case .badUrl:
            return UIStrings.badURLErrorMessage
        case .invalidRequestFormat:
            return UIStrings.badURLErrorMessage
        default:
            return UIStrings.genericErrorMessage
        }
    }
}

class CoreError {
    var title: String
    private var errorType: ErrorType?
    private var errorMessage: String?
    private var errorDescription: String?
    
    init(error: Error) {
        title = UIStrings.genericErrorTitle
        errorMessage = error.localizedDescription
        errorDescription = error.localizedDescription
    }
    
    init(title: String = UIStrings.genericErrorTitle, message: String?, desciption: String?) {
        self.title = title
        errorMessage = message
        errorDescription = desciption
    }
    
    init(type: ErrorType) {
        title = type.title
        errorMessage = type.message
        errorDescription = type.description
        errorType = type
    }
    
    var message: String {
        return errorMessage ?? UIStrings.genericErrorMessage
    }
    
    var description: String {
        return errorDescription ?? UIStrings.genericErrorMessage
    }
}

extension CoreError: Error { }

