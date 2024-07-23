//
//  AccountsView.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import SwiftUI

struct AccountsView: View {
    @StateObject var vm = AccountsViewModel()
    var body: some View {
        NavigationStack {
            List(vm.accounts, id: \.id) { account in
                AccountItem(account: account)
            }
        }
    }
}

#Preview {
    AccountsView()
}
