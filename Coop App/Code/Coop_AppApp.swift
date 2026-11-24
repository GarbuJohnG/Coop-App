//
//  Coop_AppApp.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import CoreData
import SwiftUI

@main
struct Coop_AppApp: App {
    private let persistenceController = PersistenceController.shared
    @StateObject private var viewModel: ExpenseViewModel

    init() {
        let controller = PersistenceController.shared
        _viewModel = StateObject(wrappedValue: ExpenseViewModel(context: controller.container.viewContext))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel)
        }
    }
}
