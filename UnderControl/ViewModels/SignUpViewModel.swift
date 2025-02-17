//
//  SignUpViewModel.swift
//  UnderControl
//
//  Created by Desarrollo on 30/07/24.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var username = ""
    @Published var password = ""
    @Published var loading = false
    @Published var validationErrors = ""
    @Published var hasErrors = false
    @Published var error: ResponseError? = nil
    @Published var success = ""
    
    private let sm = UnderControlServiceManager()
    
    func createUser() {
        if validateForm() {
            loading = true
            sm.addUser(user: UserDto(id: nil, name: firstName, lastname: lastName, username: username, password: password, token: nil)) { result in
                switch result {
                case .success(let message):
                    DispatchQueue.main.async {
                        self.loading = false
                        self.success = message
                    }
                case .failure(let e):
                    DispatchQueue.main.async {
                        self.error = e
                        self.loading = false
                    }
                }
            }
        } else {
            hasErrors = true
        }
    }
    
    
    func validateForm() -> Bool {
        if firstName.isEmpty {
            validationErrors += "\nThe first name field is required."
        }
        if lastName.isEmpty {
            validationErrors += "\nThe last name field is required."
        }
        if username.isEmpty {
            validationErrors += "\nThe username field is required."
        }
        if password.isEmpty {
            validationErrors += "\nThe password field is required."
        }
        return validationErrors.isEmpty
    }
}
