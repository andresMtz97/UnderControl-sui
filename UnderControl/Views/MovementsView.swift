//
//  MovementsView.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import SwiftUI

struct MovementsView: View {
    @StateObject var vm = MovementsViewModel()
    var body: some View {
        NavigationStack {
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
            Section("Transactions") {
                if vm.loading {
                    UCProgressView()
                }
                List(vm.movements, id: \.id) { movement in
                    MovementItem(movement: movement)
                }
            }
            .padding(.top)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("Sign out", systemImage: "rectangle.portrait.and.arrow.right", action: {
                    
                })
            })
        }
    }
}

#Preview {
    MovementsView()
}
