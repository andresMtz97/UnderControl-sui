//
//  MovementsView.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import SwiftUI

struct MovementsView: View {
    @EnvironmentObject var session: MainViewModel
    @StateObject var vm = MovementsViewModel()
    
    @State var transaction = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Welcome, \(DataProvider.user?.name ?? "")")
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Section("") {
                        VStack {
                            Text("\(vm.month) Summary")
                                .font(.title)
                                .bold()
                            HStack {
                                Text("Total Income:")
                                Text(vm.totalIncome)
                            }
                            HStack {
                                Text("Total Expense:")
                                Text(vm.totalExpense)
                            }
                        }
                        .font(.system(size: 20))
                        .foregroundStyle(Color.white)
                        .frame(width: 250, height: 125)
                        .background(content: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color("violet_500"))
                        })
                    }
                    HStack {
                        Button(action: { onBtnTapped(true) }, label: {
                            Label("Transaction", systemImage: "plus")
                        })
                        .padding()
                        .background(Color("violet_700"))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        
                        Button(action: { onBtnTapped(false) }, label: {
                            Label("Transfer", systemImage: "plus")
                        })
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)

                    }
                    Section("Transactions") {
                        List(vm.movements, id: \.id) { movement in
                            MovementItem(movement: movement)
                        }
                    }
                    .padding(.top)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button("Sign out", systemImage: "rectangle.portrait.and.arrow.right", action: {
                            session.currentUser = nil
                            session.isSignedIn = false
                        })
                    })
                }
                .sheet(isPresented: $vm.showForm, onDismiss: {
                    vm.resetForm()
                }) {
                    MovementForm(viewModel: vm, transaction: transaction)
                        .presentationDragIndicator(.visible)
                }
                .alert(isPresented: .constant(vm.error != nil), error: vm.error, actions: {
                    Button("OK", action: { vm.error = nil })
                })
                if vm.loading {
                    UCProgressView()
                }
            }
        }
    }
    
    func onBtnTapped(_ transaction: Bool) {
        self.transaction = transaction
        vm.showForm = true
    }
}

#Preview {
    MovementsView()
}
