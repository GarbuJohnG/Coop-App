//
//  ExpenseViewModel.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import Combine
import CoreData
import Foundation

struct CategorySpending: Identifiable {
    let category: String
    let total: Double
    var id: String { category }
}

@MainActor
final class ExpenseViewModel: ObservableObject {
    @Published private(set) var expenses: [ExpenseEntity] = []
    @Published var totalBalance: Double = 200000

    private let context: NSManagedObjectContext
    private static let totalBalanceKey = "com.coopapp.totalBalance"

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchExpenses()
    }

    func fetchExpenses() {
        let request = ExpenseEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ExpenseEntity.date, ascending: false)]
        do {
            expenses = try context.fetch(request)
        } catch {
            print("Failed to fetch expenses: \(error)")
        }
    }

    func addExpense(itemName: String, category: String, amount: Double) {
        let expense = ExpenseEntity(context: context)
        expense.id = UUID()
        expense.itemName = itemName
        expense.category = category
        expense.amount = amount
        expense.date = Date()
        save()
    }

    private func save() {
        do {
            try context.save()
            fetchExpenses()
        } catch {
            print("Failed to save expense: \(error)")
        }
    }

    var totalSpend: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    var remainingBalance: Double {
        totalBalance - totalSpend
    }

    var totalMonthSpend: Double {
        let calendar = Calendar.current
        let now = Date()
        return expenses
            .filter {
                calendar.isDate($0.date, equalTo: now, toGranularity: .month) &&
                calendar.isDate($0.date, equalTo: now, toGranularity: .year)
            }
            .reduce(0) { $0 + $1.amount }
    }

    var spendingByCategory: [CategorySpending] {
        Dictionary(grouping: expenses, by: \.category)
            .map { CategorySpending(category: $0.key, total: $0.value.reduce(0) { $0 + $1.amount }) }
            .sorted { $0.total > $1.total }
    }

    var recentTransactions: [ExpenseEntity] {
        Array(expenses.prefix(10))
    }
}
