//
//  PersistenceController.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import CoreData

// MARK: - Access persistence App Wide

struct PersistenceController {
    
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoopApp", managedObjectModel: Self.model)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Unresolved Core Data error: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    private static let model: NSManagedObjectModel = {
        let expenseEntity = NSEntityDescription()
        expenseEntity.name = "ExpenseEntity"
        expenseEntity.managedObjectClassName = "ExpenseEntity"

        let id = NSAttributeDescription()
        id.name = "id"
        id.attributeType = .UUIDAttributeType
        id.isOptional = false

        let itemName = NSAttributeDescription()
        itemName.name = "itemName"
        itemName.attributeType = .stringAttributeType
        itemName.isOptional = false

        let category = NSAttributeDescription()
        category.name = "category"
        category.attributeType = .stringAttributeType
        category.isOptional = false

        let amount = NSAttributeDescription()
        amount.name = "amount"
        amount.attributeType = .doubleAttributeType
        amount.isOptional = false
        amount.defaultValue = 0.0

        let date = NSAttributeDescription()
        date.name = "date"
        date.attributeType = .dateAttributeType
        date.isOptional = false

        expenseEntity.properties = [id, itemName, category, amount, date]

        let model = NSManagedObjectModel()
        model.entities = [expenseEntity]
        return model
    }()
}

extension PersistenceController {
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext

        let sample = ExpenseEntity(context: context)
        sample.id = UUID()
        sample.itemName = "Lunch"
        sample.category = ExpenseCategory.foodBeverage.rawValue
        sample.amount = 450
        sample.date = Date()

        try? context.save()
        return controller
    }()
}
