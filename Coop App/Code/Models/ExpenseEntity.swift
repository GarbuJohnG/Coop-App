//
//  ExpenseEntity.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import CoreData

enum ExpenseCategory: String, CaseIterable, Identifiable {
    case foodBeverage = "Food & Beverage"
    case transportFuel = "Transport & Fuel"
    case clothing = "Clothing"
    case transactionFees = "TransactionFees"

    var id: String { rawValue }
}

@objc(ExpenseEntity)
final class ExpenseEntity: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var itemName: String
    @NSManaged var category: String
    @NSManaged var amount: Double
    @NSManaged var date: Date
}

extension ExpenseEntity {
    static func fetchRequest() -> NSFetchRequest<ExpenseEntity> {
        NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    }
}
