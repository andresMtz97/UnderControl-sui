//
//  SignUpView.swift
//  UnderControl
//
//  Created by DISMOV on 21/03/24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var vm = SignUpViewModel()
    
    var body: some View {
        VStack {
            Header("Sign up")
            Form {
                TextField("First name", text: $vm.firstName)
                TextField("Last name", text: $vm.lastName)
                TextField("Username", text: $vm.username)
                SecureField("Password", text: $vm.password)
                Button(action: {}, label: {
                    Text("Sign Up")
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(4)
                })
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.accentColor)
                .cornerRadius(10)
            }
            
        }
        .navigationTitle("Sign Up")
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
