//
//  AccountsView.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import SwiftUI

struct AccountsView: View {
    @EnvironmentObject var main: MainViewModel
    @StateObject var vm = AccountsViewModel()
    @State private var showForm = false
    @State private var selection: AccountDto? = nil
    
    var body: some View {
        NavigationStack {

            ZStack {
                List(vm.accounts, id: \.id, selection: $selection) { account in
                    AccountItem(account: account)
                        .tag(account)
                        .swipeActions {
                            Button("Delete", action: {
                                if let id = account.id {
                                    vm.delete(id)
                                }
                            }).tint(.red)
                        }
                }
                if vm.loading {
                    UCProgressView()
                }
            }
            .onChange(of: selection, perform: { _ in
                if selection != nil {
                    vm.showForm = true
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { vm.showForm.toggle() }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $vm.showForm, onDismiss: {
                selection = nil
                vm.resetFields()
            }, content: {
                AccountForm(viewModel: vm, account: selection)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            })
            .alert(isPresented: .constant(vm.error != nil), error: vm.error, actions: {
                Button("OK", action: { vm.error = nil })
            })
        }
    }
}

#Preview {
    AccountsView()
}
