//
//  Login.swift
//  UnderControl
//
//  Created by Desarrollo on 19/07/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    var username = ""
    var password = ""
    @Published var error: AuthenticationError? = nil
    @Published var loading = false
    //@Published var isAuthenticated: Bool = false
    
    func login(completion: @escaping () -> Void) {
        loading = true
        UnderControlServiceManager().login(username: username, password: password) { result in
            switch result {
            case .success(let user):
                DataProvider.user = user
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                }
            }
            DispatchQueue.main.async {
                completion()
                self.loading = false
            }
        }
    }
}
