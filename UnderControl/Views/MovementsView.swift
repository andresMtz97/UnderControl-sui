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
            
            Section("Transactions") {
                if vm.loading {
                    UCProgressView()
                }
                List(vm.movements, id: \.id) { movement in
                    MovementItem(movement: movement)
                }
            }
        }
    }
}

#Preview {
    MovementsView()
}
