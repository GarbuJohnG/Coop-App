//
//  TabPageController.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import SwiftUI
import CoreData

enum AppTab: Hashable {
    case home
    case budget
    case add
    case report
    case account
}

struct TabPageController : View {
    
    @State private var selectedTab: AppTab = .home
    @EnvironmentObject private var viewModel: ExpenseViewModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(AppTab.home)
            
            NavigationStack {
                BudgetsView()
            }
            .tabItem {
                Label("Budget", systemImage: "app.grid.2x2")
            }
            .tag(AppTab.budget)
            
            NavigationStack {
                AddExpenseView(viewModel: viewModel)
            }
            .tabItem {
                Label {
                    Text("")
                } icon: {
                    Image("add_button")
                        .resizable()
                        .frame(width: 50, height: 10)
                        .aspectRatio(contentMode: .fill)
                }
            }
            .tag(AppTab.add)
            
            NavigationStack {
                ReportsView()
            }
            .tabItem {
                Label("Report", systemImage: "document")
            }
            .tag(AppTab.report)
            
            NavigationStack {
                AccountsView()
            }
            .tabItem {
                Label("Account", systemImage: "person.crop.circle")
            }
            .tag(AppTab.account)
        }
        .tint(Color("primaryColor"))
        .onChange(of: viewModel.justAddedExpense) { _ , justAdded in
            if justAdded {
                selectedTab = .home
            }
        }
    }
}

#Preview {
    TabPageController()
        .environmentObject(ExpenseViewModel(context: PersistenceController.preview.container.viewContext))
}
