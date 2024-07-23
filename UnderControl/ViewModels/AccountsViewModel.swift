//
//  AccountsViewModel.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

class AccountsViewModel: ObservableObject {
    @Published var accounts = [AccountDto]()
    
    init() {
        print("initAccountsViewModel")
        fetchAccounts()
    }
    
    func fetchAccounts() {
        if let data = DataProvider.accounts {
            accounts = data
        }
    }
}
