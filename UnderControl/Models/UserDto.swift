//
//  User.swift
//  UnderControl
//
//  Created by Desarrollo on 19/07/24.
//

import Foundation

struct UserDto: Codable {
    let id: Int?
    var name: String
    var lastname: String
    let username: String?
    let password: String?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "usuario_id"
        case name = "nombre"
        case lastname = "ap_paterno"
        case username
        case password
        case token
    }

}
