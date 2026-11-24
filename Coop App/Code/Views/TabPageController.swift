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
    case spacer
    case report
    case account

    var title: String {
        switch self {
        case .home: return "Home"
        case .budget: return "Budget"
        case .spacer: return ""
        case .report: return "Report"
        case .account: return "Account"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house"
        case .budget: return "app.grid.2x2"
        case .spacer: return ""
        case .report: return "document"
        case .account: return "person.crop.circle"
        }
    }
}

struct TabPageController: View {

    @State private var selectedTab: AppTab = .home
    @State private var isPresentingAddExpense = false
    @State private var isPresentingAddSuccess = false
    @EnvironmentObject private var viewModel: ExpenseViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                tabItem(.home) { HomeView() }
                tabItem(.budget) { BudgetsView() }
                spacerTabItem
                tabItem(.report) { ReportsView() }
                tabItem(.account) { AccountsView() }
            }
            .tint(Color("primaryColor"))

            addButton
                .offset(y: 10)
        }
        .fullScreenCover(isPresented: $isPresentingAddExpense) {
            AddExpenseView(viewModel: viewModel)
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            guard newValue == .spacer else { return }
            selectedTab = oldValue
        }
        .onChange(of: viewModel.justAddedExpense) { _, justAdded in
            guard justAdded else { return }
            isPresentingAddExpense = false
            isPresentingAddSuccess = true
            viewModel.justAddedExpense = false
        }
        .alert("Expense Added", isPresented: $isPresentingAddSuccess) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Your expense has been recorded successfully.")
        }
    }

    /// Reserves an empty slot in the tab bar so the real tabs make room for
    /// the floating add button instead of sitting under it. Selecting it is
    /// bounced back to the previous tab (see the `selectedTab` onChange).
    private var spacerTabItem: some View {
        Color.clear
            .tabItem { EmptyView() }
            .tag(AppTab.spacer)
    }

    private var addButton: some View {
        Button {
            isPresentingAddExpense = true
        } label: {
            Image("add_button")
                .resizable()
                .frame(width: 56, height: 56)
                .shadow(color: .black.opacity(0.25), radius: 4, y: 2)
        }
        .buttonStyle(.plain)
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
