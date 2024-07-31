//
//  MovementsViewModel.swift
//  UnderControl
//
//  Created by Desarrollo on 23/07/24.
//

import Foundation

class MovementsViewModel: ObservableObject {
    @Published var movements = [MovementDto]()
    @Published var loading = false
    @Published var showForm = false
    @Published var totalIncome = "0.00".toCurrency()
    @Published var totalExpense = "0.00".toCurrency()
    @Published var month = ""
    @Published var error: ResponseError? = nil
    @Published var validationErrors = ""
    @Published var hasErrors = false
    
    //Form variables
    @Published var description = ""
    @Published var amount = ""
    @Published var date = Date()
    @Published var originAccount = -1
    @Published var type = ""
    @Published var str = ""
    @Published var category: Int = -1
    @Published var inCatSelection: Int = -1
    @Published var exCatSelection: Int = -1
    @Published var destinationAccount = -1
    
    //Form arrays for pickers
    @Published var originAccounts: [AccountDto] = DataProvider.accounts ?? []
    @Published var incomeCat: [CategoryDto] = DataProvider.incomeCategories ?? []
    @Published var expenseCat: [CategoryDto] = DataProvider.expenseCategories ?? []
    @Published var destinationAccounts: [AccountDto] = []
    
    let dateFormatter = DateFormatter()
    
    private let sm = UnderControlServiceManager()
    
    init() {
        dateFormatter.dateFormat = "MMMM"
        month = dateFormatter.string(from: Date())
        getMovements()
    }
    
    func getMovements() {
        loading = true
        sm.getMovements { result in
            switch result {
            case .success(let movements):
                DataProvider.movements = movements
                DispatchQueue.main.async {
                    self.fetchMovements()
                    self.loading = false
                }
            case .failure(let error):
                self.error = error
            }
            
        }
    }
    
    func fetchMovements() {
        if let data = DataProvider.movements {
            movements = data
            var income: Double = 0
            var expense: Double = 0
            for movement in movements {
                if let transaction = movement.transaction {
                    if transaction.type {
                        if let incomeValue = Double(movement.amount) {
                            income += incomeValue
                        }
                    } else {
                        if let expenseValue = Double(movement.amount) {
                            expense += expenseValue
                        }
                    }
                }
            }
            totalIncome = String(income).toCurrency()
            totalExpense = String(expense).toCurrency()
        }
    }
    
    func setCategories() {
        category = -1
        if type == "Income" {
            incomeCat = DataProvider.incomeCategories ?? []
        } else if type == "Expense" {
            expenseCat = DataProvider.expenseCategories ?? []
        }
    }
    
    func setDestinationAccounts() {
        destinationAccounts = originAccounts.filter{ $0.id != originAccount }
    }
    
    func resetForm() {
        description = ""
        amount = ""
        date = Date()
        originAccount = -1
        type = ""
        category = -1
        destinationAccount = -1
    }
    
    func addMovement(_ transaction: Bool) {
        if validateForm(transaction: transaction) {
            loading = true
            showForm = false
            var transactionDto: TransactionDto? = nil
            var transferDto: TransferDto? = nil
            if transaction {
                transactionDto = TransactionDto(id: nil, type: type == "Income", categoryId: category)
            } else {
                transferDto = TransferDto(id: nil, accountId: destinationAccount)
            }
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let movement = MovementDto(
                id: nil,
                amount: amount,
                date: dateFormatter.string(from: date),
                description: description,
                accountId: originAccount,
                transaction: transactionDto,
                transfer: transferDto
            )
            sm.addMovement(movement: movement) { result in
                switch result {
                case .success(let response):
                    if let success = response.success, !success, let msg = response.message {
                        DispatchQueue.main.async {
                            self.error = .custom(errorMessage: msg)
                            self.loading = false
                        }
                    }
                    if let moveDto = response.data {
                        DispatchQueue.main.async {
                            DataProvider.movements?.insert(moveDto, at: 0)
                            self.fetchMovements()
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
    
    func validateForm(transaction: Bool) -> Bool {
        if description.isEmpty {
            validationErrors += "\nThe description field is required."
        }
        if Double(amount) == nil {
            validationErrors += "\nThe amount field must be a decimal number."
        }
        if originAccount == -1 {
            validationErrors += "\nYou have to choose an Origin Account."
        }
        
        if transaction {
            if type.isEmpty {
                validationErrors += "\nYou have to choose a type."
            }
            if category == -1 {
                validationErrors += "\nYou have to choose a category."
            }
        } else {
            if destinationAccount == -1 {
                validationErrors += "\nYou have to choose a destination account."
            }
        }
        
        return validationErrors.isEmpty
    }
}
