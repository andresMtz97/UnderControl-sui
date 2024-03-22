//
//  SignUpView.swift
//  UnderControl
//
//  Created by DISMOV on 21/03/24.
//

import SwiftUI

struct SignUpView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            
            Form {
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
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
