//
//  TabPageController.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import CoreData
import SwiftUI

enum AppTab: Hashable {
    case home
    case budget
    case add
    case report
    case account

    var title: String {
        switch self {
        case .home: return "Home"
        case .budget: return "Budget"
        case .add: return "Add"
        case .report: return "Report"
        case .account: return "Account"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house"
        case .budget: return "app.grid.2x2"
        case .add: return "plus"
        case .report: return "document"
        case .account: return "person.crop.circle"
        }
    }
}

struct TabPageController: View {

    @State private var selectedTab: AppTab = .home
    @EnvironmentObject private var viewModel: ExpenseViewModel

    var body: some View {
        TabView(selection: $selectedTab) {
            tabItem(.home) { HomeView() }
            tabItem(.budget) { BudgetsView() }
            tabItem(.add) { AddExpenseView(viewModel: viewModel) }
            tabItem(.report) { ReportsView() }
            tabItem(.account) { AccountsView() }
        }
        .tint(Color("primaryColor"))
        .onChange(of: viewModel.justAddedExpense) { _, justAdded in
            guard justAdded else { return }
            selectedTab = .home
        }
    }

    @ViewBuilder
    private func tabItem<Content: View>(
        _ tab: AppTab,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationStack {
            content()
        }
        .tabItem {
            Label(tab.title, systemImage: tab.systemImage)
        }
        .tag(tab)
    }
}

#Preview {
    TabPageController()
        .environmentObject(ExpenseViewModel(context: PersistenceController.preview.container.viewContext))
}
