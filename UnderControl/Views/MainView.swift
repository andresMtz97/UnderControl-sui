//
//  MainView.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        if vm.isSignedIn, vm.currentUser != nil {
            HomeView().environmentObject(vm)
        } else {
            SignInView().environmentObject(vm)
        }
    }
}

#Preview {
    MainView()
}
