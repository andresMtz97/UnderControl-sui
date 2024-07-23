//
//  AuthenticationError.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

enum AuthenticationError: LocalizedError {
    case invalidCredentials
    case custom(errorMessage: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials: return "Invalid credentials.\n Try again."
        case .custom(let message): return message
        }
    }
    
//    var failureReason: String? {
//        "failureReason"
//    }
//    
//    var helpAnchor: String? {
//        "helpAnchor"
//    }
//    
//    var recoverySuggestion: String? {
//        "recoverySuggestion"
//    }
}
