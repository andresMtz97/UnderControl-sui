//
//  ResponseDto.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

class ResponseDto<T: Codable>: Codable {
    let success: Bool?
    let status: Int?
    let message: String?
    let errors: [ValidationError]?
    let data: T?
}

class ValidationError: Codable {
    let field: String
    let messages: [String]
}
