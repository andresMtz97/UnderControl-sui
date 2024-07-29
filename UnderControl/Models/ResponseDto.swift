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

/*{
 "success": false,
 "status": 200,
 "message": "Cuenta eliminada exitosamente",
 "cuentaEliminada": {
     "cuenta_id": 17,
     "nombre": "Holo",
     "saldo": "1.00",
     "usuario_id": 6,
     "countMovimientos": 0,
     "tdc": null
 }
}*/
