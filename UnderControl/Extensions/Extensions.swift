//
//  Extensions.swift
//  UnderControl
//
//  Created by Desarrollo on 23/07/24.
//

import Foundation

extension String {
    func toCurrency() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        
        return ""
    }
}
