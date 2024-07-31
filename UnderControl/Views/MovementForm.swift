//
//  MovementForm.swift
//  UnderControl
//
//  Created by Desarrollo on 29/07/24.
//

import SwiftUI

struct MovementForm: View {
//    @StateObject var vm = MovementFormViewModel()
    @ObservedObject var vm: MovementsViewModel
    var transaction: Bool
    var categories = DataProvider.expenseCategories ?? []
    @State var category = -1
    
    private let types = ["", "Expense", "Income"]

    init(viewModel: MovementsViewModel, transaction: Bool) {
        self.vm = viewModel
        self.transaction = transaction
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Movement Info.") {
                    TextField("Description", text: $vm.description)
                    TextField("Amount", text: $vm.amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $vm.date, in: ...Date.now, displayedComponents: .date)
                    Picker("Origin Account", selection: $vm.originAccount) {
                        Text("").tag(-1)
                        ForEach(vm.originAccounts, id: \.id) { account in
                            Text(account.name).tag(account.id ?? 0)
                        }
                    }
                }
                
                if transaction {
                    Section("Transaction Info.") {
                        Picker("Type", selection: $vm.type) {
                            ForEach(types, id: \.self) {
                                Text($0)
                            }
                        }
                        
                        if vm.type == "Expense" {
                            Picker("Category", selection: $vm.category) {
                                Text("").tag(-1)
                                ForEach(vm.expenseCat, id: \.id) { category in
                                    Text(category.name).tag(category.id ?? 0)
                                }.tag(0)
                                
                            }
                        }
                        
                        if vm.type == "Income" {
                            Picker("Category", selection: $vm.category) {
                                Text("").tag(-1)
                                ForEach(vm.incomeCat, id: \.id) { category in
                                    Text(category.name).tag(category.id ?? 0)
                                }
                                
                            }
                        }
                        
                        
                    }
                } else {
                    Section("Transfer Info.") {
                        Picker("Destination Account", selection: $vm.destinationAccount) {
                            Text("").tag(-1)
                            ForEach(vm.destinationAccounts, id: \.id) { account in
                                Text(account.name).tag(account.id)
                            }
                        }
                    }
                }
            }
            .navigationTitle(setTitle())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Save", action: {
                        vm.addMovement(transaction)
                    })
                })
                
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Cancel", action: { vm.showForm = false })
                })
            }
            .onChange(of: vm.type) { _ in
                vm.setCategories()
            }
            .onChange(of: vm.originAccount, perform: { value in
                vm.setDestinationAccounts()
            })
        }
        .onAppear {
            vm.originAccounts = DataProvider.accounts ?? []
        }
        .alert(vm.validationErrors, isPresented: $vm.hasErrors, actions: {
            Button("OK", action: { vm.validationErrors = "" })
        })
    }
    
    func setTitle() -> String {
        if transaction { return "New Transaction" }
        else { return "New Transfer" }
    }
}

#Preview {
    MovementForm(viewModel: MovementsViewModel(), transaction: true)
}
