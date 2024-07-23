//
//  CategoriesViewModel.swift
//  UnderControl
//
//  Created by Desarrollo on 23/07/24.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    @Published var incomeCategories = [CategoryDto]()
    @Published var expenseCategories = [CategoryDto]()
    
    init() {
        print("initCategoriesViewModel")
        fetchIncomeCat()
        fetchExpenseCat()
    }
    
    func fetchIncomeCat() {
        if let data = DataProvider.incomeCategories {
            incomeCategories = data
        }
    }
    
    func fetchExpenseCat() {
        if let data = DataProvider.expenseCategories {
            expenseCategories = data
        }
    }
}
