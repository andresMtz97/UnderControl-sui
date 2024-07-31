//
//  SignUpView.swift
//  UnderControl
//
//  Created by DISMOV on 21/03/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = SignUpViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Header("Sign up")
                Form {
                    TextField("First name", text: $vm.firstName)
                    TextField("Last name", text: $vm.lastName)
                    TextField("Username", text: $vm.username)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $vm.password)
                    Button(action: {
                        vm.createUser()
                    }, label: {
                        Text("Sign Up")
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(4)
                    })
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("violet_700"))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                }
                .frame(width: 400)
                
            }
            if vm.loading {
                UCProgressView()
            }
        }
        .alert(vm.validationErrors, isPresented: $vm.hasErrors, actions: {
            Button("OK", action: { vm.validationErrors = "" })
        })
        .alert(isPresented: .constant(vm.error != nil), error: vm.error, actions: {
            Button("OK", action: { vm.error = nil })
        })
        .alert(vm.success, isPresented: .constant(!vm.success.isEmpty)) {
            Button("OK") {
                vm.success = ""
                dismiss()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
