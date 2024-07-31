//
//  TransferDto.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

struct TransferDto: Codable {
    let id: Int?
    var accountId: Int
    var account: AccountDto? = nil
    
    enum CodingKeys: String, CodingKey {
        case id = "movimiento_id"
        case accountId = "cuenta_id"
        case account = "cuenta"
    }
    
}
