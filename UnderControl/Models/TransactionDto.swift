//
//  TransactionDto.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

class TransactionDto: Codable {
    let id: Int?
    var type: Bool
    var category: CategoryDto? = nil
    
    enum CodingKeys: String, CodingKey {
        case id = "movimiento_id"
        case type = "tipo"
        case category = "categoria"
    }
    
    init(id: Int?, type: Bool, category: CategoryDto? = nil) {
        self.id = id
        self.type = type
        self.category = category
    }
}
