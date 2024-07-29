//
//  AccountForm.swift
//  UnderControl
//
//  Created by Desarrollo on 23/07/24.
//

import SwiftUI

struct AccountForm: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: AccountsViewModel
    var account: AccountDto? = nil
    private var isEditing: Bool = false
    
    init(viewModel vm: AccountsViewModel, account: AccountDto? = nil) {
        self.vm = vm
        self.account = account
        self.isEditing = account != nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Account Info") {
                    TextField("Name", text: $vm.name)
                    TextField("Balance", text: $vm.balance)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle(setTitle())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Save", action: {
                        if isEditing {
                            vm.updateAccount(account)
                        } else { vm.addAccount() }
                    })
                })
                
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Cancel", action: { vm.showForm = false })
                })
            }
        }
        .onAppear {
            if isEditing {
                vm.setFields(account)
            }
        }
        .alert(vm.validationErrors, isPresented: $vm.hasErrors, actions: {
            Button("OK", action: { vm.validationErrors = "" })
        })
        
    }
    
    func setTitle() -> String {
        if isEditing { return "Edit Account" }
        else { return "New Account" }
    }
}

#Preview {
    AccountForm(viewModel: AccountsViewModel())
}
