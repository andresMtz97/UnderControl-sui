//
//  HomeViewModel.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var loading = false
    @Published var loadingAccounts = false
    @Published var loadingIncomeCat = false
    @Published var loadingExpenseCat = false
    @Published var error: ResponseError? = nil
        
    private let sm = UnderControlServiceManager()
    
    init() {
        loadingAccounts = true
        getAccounts()
        loadingIncomeCat = true
        getIncomeCategories()
        loadingExpenseCat = true
        getExpenseCategories()

    }
    
    func getAccounts() {
        sm.getAccounts { result in
            switch result {
            case .success(let accounts):
                DispatchQueue.main.async {
                    DataProvider.accounts = accounts
                    self.loadingAccounts = false
                }
            case .failure(let error):
                self.error = error
            }
            
        }
    }
    
    func getIncomeCategories() {
        sm.getIncomeCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    DataProvider.incomeCategories = categories
                    self.loadingIncomeCat = false
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func getExpenseCategories() {
        sm.getExpenseCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    DataProvider.expenseCategories = categories
                    self.loadingExpenseCat = false
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
}

