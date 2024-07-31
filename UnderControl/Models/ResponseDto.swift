//
//  ResponseDto.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

struct ResponseDto<T: Codable>: Codable {
    let success: Bool?
    let status: Int?
    let message: String?
    let errors: [ValidationError]?
    let data: T?
}

struct ValidationError: Codable {
    let field: String
    let messages: [String]
}
