//
//  Movement.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

struct MovementDto: Codable {
    let id: Int?
    var amount: String
    var date: String
    var description: String
    var accountId: Int?
    var account: AccountDto?
    var transaction: TransactionDto?
    var transfer: TransferDto?
    
    enum CodingKeys: String, CodingKey {
        case id = "movimiento_id"
        case amount = "monto"
        case date = "fecha"
        case description = "descripcion"
        case accountId = "cuenta_id"
        case transaction = "transaccion"
        case transfer = "transferencia"
        case account = "cuenta"
    }
}
