//
//  CategoriesView.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var vm = CategoriesViewModel()
    var body: some View {
        NavigationStack {
            Section("Expense") {
                List(vm.expenseCategories, id: \.id) { category in
                    CategoryItem(category: category)
                }
            }
            
            Section("Income") {
                List(vm.incomeCategories, id: \.id) { category in
                    CategoryItem(category: category)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add", action: {})
            }
        }
}
}

#Preview {
    CategoriesView()
}
