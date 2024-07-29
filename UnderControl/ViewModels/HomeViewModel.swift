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
    
    //@Published var Movements: [MovementDto]? = nil
    
    private let sm = UnderControlServiceManager()
    
    init() {
        print("initHomeViewModel")
        //print(DataProvider.user?.token)
//        loadingMovements = true
//        getMovements()
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
                DataProvider.accounts = accounts
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.loadingAccounts = false
            }
        }
    }
    
    func getIncomeCategories() {
        sm.getIncomeCategories { result in
            switch result {
            case .success(let categories):
                DataProvider.incomeCategories = categories
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.loadingIncomeCat = false
            }
        }
    }
    
    func getExpenseCategories() {
        sm.getExpenseCategories { result in
            switch result {
            case .success(let categories):
                DataProvider.expenseCategories = categories
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.loadingExpenseCat = false
            }
        }
    }
    
//    func getMovements() {
//        sm.getMovements { result in
//            switch result {
//            case .success(let movements):
//                print(movements)
//                DataProvider.movements = movements
//                print("movements \(DataProvider.incomeCategories?.count)")
//                DispatchQueue.main.async {
//                    print(DataProvider.movements?.count)
//                    self.loadingMovements = false
//                }
//            case .failure(let error):
//                print(error)
//            }
//            
//        }
//    }
}

