//
//  CategoryDto.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

struct CategoryDto: Codable, Hashable {
    let id: Int?
    var name: String
    var type: Bool
    let userId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "categoria_id"
        case name = "nombre"
        case type = "tipo"
        case userId = "usuario_id"
    }
    
    init(id: Int?, name: String, type: Bool, userId: Int?) {
        self.id = id
        self.name = name
        self.type = type
        self.userId = userId
    }
}
