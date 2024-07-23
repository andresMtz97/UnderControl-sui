//
//  AccountItem.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import SwiftUI

struct AccountItem: View {
    var account: AccountDto
    
    var body: some View {
        Text(account.name)
    }
}

#Preview {
    AccountItem(account: AccountDto(id: 1, name: "BBVA", balance: "0.0"))
}
