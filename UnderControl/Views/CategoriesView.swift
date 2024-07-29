//
//  CategoriesView.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var vm = CategoriesViewModel()
    @State private var selection: CategoryDto? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                List(selection: $selection) {
                    Section("Expense") {
                        ForEach(vm.expenseCategories, id: \.id) { category in
                            CategoryItem(category: category)
                                .tag(category)
                                .swipeActions {
                                    Button("Delete", action: {
                                        if let id = category.id {
                                            vm.delete(id)
                                        }
                                    }).tint(.red)
                                }
                        }
                    }
                    Section("Income") {
                        ForEach(vm.incomeCategories, id: \.id) { category in
                            CategoryItem(category: category)
                                .tag(category)
                                .swipeActions {
                                    Button("Delete", action: {
                                        if let id = category.id {
                                            vm.delete(id)
                                        }
                                    }).tint(.red)
                                }
                        }
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
                    Button("Add", action: { vm.showForm.toggle() })
                }
            }.sheet(isPresented: $vm.showForm, onDismiss: {
                selection = nil
                vm.resetFields()
            }, content: {
                CategoryForm(viewModel: vm, category: selection)
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
    CategoriesView()
}
