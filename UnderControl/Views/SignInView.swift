//
//  SignInView.swift
//  UnderControl
//
//  Created by DISMOV on 21/03/24.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var vm = LoginViewModel()
    @EnvironmentObject var main: MainViewModel
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    //Header
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 400, height: 150)
                    
                    //Body
                    Form {
                        TextField("Username", text: $vm.username)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                        SecureField("Password", text: $vm.password)
                        Button(action: {
                            vm.login() { main.updateUser() }
                        }, label: {
                            Text("Sign In")
                                .bold()
                                .padding(4)
                        })
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .disabled(vm.loading)
                    }
                    .alert(isPresented: .constant(vm.error != nil), error: vm.error, actions: {
                        Button("OK", action: { vm.error = nil })
                    })
                    
                    //Footer
                    VStack {
                        NavigationLink("Create Account", destination: SignUpView())
                    }
                    .padding()
                }
                //.navigationTitle("Sign In")
                
                if vm.loading {
                    UCProgressView()
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
