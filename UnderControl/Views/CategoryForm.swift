//
//  CategoryForm.swift
//  UnderControl
//
//  Created by Desarrollo on 25/07/24.
//

import SwiftUI

struct CategoryForm: View {
    @ObservedObject var vm: CategoriesViewModel
    var category: CategoryDto?
    private var isEditing: Bool
    
    private let categoryTypes = ["Expense", "Income"]
    
    init(viewModel: CategoriesViewModel, category: CategoryDto? = nil) {
        self.vm = viewModel
        self.category = category
        self.isEditing = category != nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Category info") {
                    TextField("Name", text: $vm.name)
                }
                if !isEditing {
                    Picker("Type", selection: $vm.type) {
                        ForEach(categoryTypes, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.inline)
                }
            }
            .navigationTitle(setTitle())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Save", action: {
                        if isEditing {
                            vm.updateCategory(category)
                        } else { vm.addCategory() }
                    })
                })
                
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Cancel", action: { vm.showForm = false })
                })
            }
        }
        .onAppear {
            if isEditing {
                vm.setFields(category)
            }
        }
        .alert(vm.validationErrors, isPresented: $vm.hasErrors, actions: {
            Button("OK", action: { vm.validationErrors = "" })
        })
    }
    
    func setTitle() -> String {
        if isEditing { return "Edit Category" }
        else { return "New Category" }
    }
}

#Preview {
    CategoryForm(viewModel: CategoriesViewModel())
}
