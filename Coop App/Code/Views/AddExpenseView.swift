//
//  AddExpenseView.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import CoreData
import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var itemName = ""
    @State private var category = ExpenseCategory.foodBeverage
    @State private var amountText = ""

    private var amount: Double? {
        Double(amountText)
    }

    private var isValid: Bool {
        !itemName.trimmingCharacters(in: .whitespaces).isEmpty && (amount ?? 0) > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Category") {
                    Picker("Category", selection: $category) {
                        ForEach(ExpenseCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
                Section("Item Name") {
                    TextField("e.g. Lunch", text: $itemName)
                }
                Section("Amount") {
                    TextField("0.00", text: $amountText)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add budget item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        guard let amount else { return }
                        viewModel.addExpense(
                            itemName: itemName.trimmingCharacters(in: .whitespaces),
                            category: category.rawValue,
                            amount: amount
                        )
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
}

#Preview {
    AddExpenseView(viewModel: ExpenseViewModel(context: PersistenceController.preview.container.viewContext))
}
