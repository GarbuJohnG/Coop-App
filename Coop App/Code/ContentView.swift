//
//  ContentView.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationStateManager = NavigationManager()
    
    var body: some View {
        
        NavigationView {
            VStack {
                if let currentView = navigationStateManager.viewStack.last {
                    currentView
                } else {
                    TabPageController()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $navigationStateManager.isSheetPresented, content: {
                navigationStateManager.sheetContent
            })
        }
        .environmentObject(navigationStateManager)
        
    }
}

#Preview {
    ContentView()
}
