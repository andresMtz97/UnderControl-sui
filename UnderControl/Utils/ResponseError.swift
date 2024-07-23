//
//  ResponseError.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

enum ResponseError: LocalizedError {
    case basic
    case custom(errorMessage: String)
    
    var errorDescription: String? {
        switch self {
        case .basic: return "Basic"
        case .custom(let message): return message
        }
    }
}
