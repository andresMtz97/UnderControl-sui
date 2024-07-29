//
//  CategoriesViewModel.swift
//  UnderControl
//
//  Created by Desarrollo on 23/07/24.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    private let sm = UnderControlServiceManager()
    
    @Published var incomeCategories = [CategoryDto]()
    @Published var expenseCategories = [CategoryDto]()
    @Published var name = ""
    @Published var type = ""
    @Published var validationErrors = ""
    @Published var hasErrors = false
    @Published var showForm = false
    @Published var error: ResponseError? = nil
    @Published var loading = false
    
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
    
    func addCategory() {
        print("saving new category...")
        if validateFields(isEdit: false) {
            loading = true
            showForm = false
            sm.addCategory(category: CategoryDto(id: nil, name: name, type: type == "Income", userId: nil)) { result in
                switch result {
                case .success(let response):
                    if let category = response.data {
                        DispatchQueue.main.async {
                            if category.type {
                                DataProvider.incomeCategories?.append(category)
                                self.fetchIncomeCat()
                            } else {
                                DataProvider.expenseCategories?.append(category)
                                self.fetchExpenseCat()
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
            hasErrors = true
        }
        
    }
    
    func updateCategory(_ category: CategoryDto?) {
        if validateFields(isEdit: true), var data = category {
            loading = true
            showForm = false
            data.name = self.name
            sm.updateCategory(category: data) { result in
                switch result {
                case .success(let response):
                    if let category = response.data {
                        DispatchQueue.main.async {
                            if let index = self.incomeCategories.firstIndex(where: { $0.id == category.id }) {
                                DataProvider.incomeCategories?[index] = category
                                self.fetchIncomeCat()
                            } else if let index = self.expenseCategories.firstIndex(where: { $0.id == category.id }) {
                                DataProvider.expenseCategories?[index] = category
                                self.fetchExpenseCat()
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
        sm.deleteCategory(id: id) { result in
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
                        DataProvider.incomeCategories?.removeAll(where: { $0.id == id})
                        DataProvider.expenseCategories?.removeAll(where: { $0.id == id})
                        self.fetchIncomeCat()
                        self.fetchExpenseCat()
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
    
    private func validateFields(isEdit: Bool) -> Bool {
        if name.isEmpty {
            validationErrors += "\nThe name field is required."
        }
        if !isEdit {
            if type.isEmpty {
                validationErrors += "\nYou must choose a type."
            }
        }
        return validationErrors.isEmpty
    }
    
    func setFields(_ category: CategoryDto?) {
        if let category = category {
            name = category.name
        }
    }
    
    func resetFields() {
        name = ""
        type = ""
    }
}
