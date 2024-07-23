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
    
    private let sm = UnderControlServiceManager()
    
    init() {
        print("initMovementsViewModel")
        loading = true
        getMovements()
    }
    
    func getMovements() {
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
        }
        print(movements.count)
    }
}
