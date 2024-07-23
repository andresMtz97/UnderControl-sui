//
//  AccountDto.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

class AccountDto: Codable {
    let id: Int?
    var name: String
    var balance: String
    
    enum CodingKeys: String, CodingKey {
        case id = "cuenta_id"
        case name = "nombre"
        case balance = "saldo"
    }
    
    init(id: Int?, name: String, balance: String) {
        self.id = id
        self.name = name
        self.balance = balance
    }
}
