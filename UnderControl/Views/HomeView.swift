//
//  HomeView.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    //@EnvironmentObject var main: MainViewModel
    var body: some View {
        if vm.loadingAccounts && vm.loadingIncomeCat && vm.loadingExpenseCat {
            UCProgressView()
        } else {
            TabView {
                MovementsView()
                    .tabItem { Label("Home", systemImage: "house") }
                
                AccountsView()
                    .tabItem {
                        Label("Accounts", systemImage: "person")
                    }
                
                CategoriesView()
                    .tabItem {
                        Label("Categories", systemImage: "square.grid.2x2")
                    }
            }
        }
    }
}


#Preview {
    HomeView()
}
