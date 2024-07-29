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
    var account: AccountDto
    
    enum CodingKeys: String, CodingKey {
        case id = "movimiento_id"
        case accountId = "cuenta_id"
        case account = "cuenta"
    }
    
    init(id: Int?, accountId: Int, account: AccountDto) {
        self.id = id
        self.accountId = accountId
        self.account = account
    }
}
