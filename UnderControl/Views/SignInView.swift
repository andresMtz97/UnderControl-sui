//
//  SignInView.swift
//  UnderControl
//
//  Created by DISMOV on 21/03/24.
//

import SwiftUI

struct SignInView: View {
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            VStack{
                //Header
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 400, height: 150)
                
                //Body
                Form {
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                    Button(action: {
                        
                    }, label: {
                        Text("Sign In")
                            .bold()
                            .padding(4)
                    })
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.accentColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                }
                
                //Footer
                VStack {
                    NavigationLink("Create Account", destination: SignUpView())
                }
                .padding()
            }
            .navigationTitle("Sign In")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
