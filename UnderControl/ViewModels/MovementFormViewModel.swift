//
//  MovementFormViewModel.swift
//  UnderControl
//
//  Created by Desarrollo on 29/07/24.
//

import Foundation

class MovementFormViewModel: ObservableObject {
    //For pickers
    @Published var originAccounts: [AccountDto] = DataProvider.accounts ?? []
    @Published var incomeCategories: [CategoryDto] = []
    @Published var expenseCategories: [CategoryDto] = []
    @Published var destinationAccounts: [AccountDto] = []
    
    //Form variables
    @Published var description = ""
    @Published var amount = ""
    @Published var date = Date()
    @Published var originAccount: Int = -1
    @Published var type = ""
    @Published var str = ""
    @Published var category: Int = -1
    @Published var inCatSelection: Int = -1
    @Published var expCatSelection: Int = -1
    @Published var destinationAccount: Int = -1

    
}
