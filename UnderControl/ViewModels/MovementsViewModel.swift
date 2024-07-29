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
    @Published var totalIncome = "0.00".toCurrency()
    @Published var totalExpense = "0.00".toCurrency()
    @Published var month = ""
    
    private let sm = UnderControlServiceManager()
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        month = dateFormatter.string(from: Date())
        print("initMovementsViewModel")
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
                print(error)
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
                        print("income : \(income)")
                    } else {
                        if let expenseValue = Double(movement.amount) {
                            expense += expenseValue
                            print("expense : \(expense)")
                        }
                    }
                }
            }
            print(income)
            print(expense)
            totalIncome = String(income).toCurrency()
            totalExpense = String(expense).toCurrency()
        }
        print(movements.count)
    }
}
 
