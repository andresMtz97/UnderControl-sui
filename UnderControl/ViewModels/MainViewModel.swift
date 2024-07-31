//
//  MainViewModel.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var currentUser: UserDto? = nil
    @Published var isSignedIn = false
    
    func updateUser() {
        if let user = DataProvider.user {
            currentUser = user
            isSignedIn = true
//            print(currentUser?.token)
        }
    }
}
