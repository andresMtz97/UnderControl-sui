//
//  TransactionDto.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

struct TransactionDto: Codable {
    let id: Int?
    var type: Bool
    var categoryId: Int?
    var category: CategoryDto? = nil
    
    enum CodingKeys: String, CodingKey {
        case id = "movimiento_id"
        case type = "tipo"
        case category = "categoria"
        case categoryId = "categoria_id"
    }
    
//    init(id: Int?, type: Bool, category: CategoryDto? = nil) {
//        self.id = id
//        self.type = type
//        self.category = category
//    }
}
