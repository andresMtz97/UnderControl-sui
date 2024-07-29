//
//  AccountsViewModel.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

class AccountsViewModel: ObservableObject {
    private let sm = UnderControlServiceManager()

    @Published var accounts = [AccountDto]()
    @Published var loading = false
    @Published var name = ""
    @Published var balance = ""
    @Published var validationErrors = ""
    @Published var hasErrors = false
    @Published var showForm = false
    @Published var error: ResponseError? = nil
    
    init() {
        print("initAccountsViewModel")
        fetchAccounts()
    }
    
    func fetchAccounts() {
        print("fetching accounts")
        if let data = DataProvider.accounts {
            accounts = data
        }
    }
    
    func addAccount() {
        print("saving new account...")
        if validateFields() {
            loading = true
            showForm = false
            sm.addAccount(account: AccountDto(id: nil, name: name, balance: balance)) { result in
                switch result {
                case .success(let response):
                    if let account = response.data {
                        DispatchQueue.main.async {
                            DataProvider.accounts?.append(account)
                            self.fetchAccounts()
                            self.loading = false
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.error = error
                        self.loading = false
                    }
                    
                }
            }
        } else {
            hasErrors = true
        }
        
    }
    
    func updateAccount(_ account: AccountDto?) {
        loading = true
        if validateFields(), var data = account {
            showForm = false
            data.name = self.name
            data.balance = self.balance
            sm.updateAccount(account: data) { result in
                print(result)
                switch result {
                case .success(let response):
                    if let account = response.data {
                        DispatchQueue.main.async {
                            if let index = self.accounts.firstIndex(where: { $0.id == account.id }) {                                
                                DataProvider.accounts?[index] = account
                                self.fetchAccounts()
                            }
                            self.loading = false
                            
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.error = error
                        self.loading = false
                    }
                    
                }

            }
        } else {
            print("has errors")
            hasErrors = true
        }
    }
    
    func delete(_ id: Int) {
        loading = true
        sm.deleteAccount(id: id) { result in
            switch result {
            case .success(let response):
                if let success = response.success, !success, let msg = response.message {
                    DispatchQueue.main.async {
                        self.error = .custom(errorMessage: msg)
                        self.loading = false
                    }
                }
                else {
                    DispatchQueue.main.async {
                        DataProvider.accounts?.removeAll(where: { $0.id == id})
                        self.fetchAccounts()
                        self.loading = false
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                    self.loading = false
                }
            }
        }
    }
    
    private func validateFields() -> Bool {
        if name.isEmpty {
            validationErrors += "\nThe name field is required."
        }
        if Double(balance) == nil {
            validationErrors += "\nThe balance field must be a decimal number."
        }
        return validationErrors.isEmpty
    }
    
    func resetFields() {
        name = ""
        balance = ""
    }
    
    func setFields(_ account: AccountDto?) {
        if let account = account {
            name = account.name
            balance = account.balance
        }
    }
}
