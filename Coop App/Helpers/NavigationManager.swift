//
//  NavigationManager.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import SwiftUI
import Combine

class NavigationManager: ObservableObject {
    
    @Published var viewStack: [AnyView] = []
    @Published var isSheetPresented: Bool = false
    @Published var sheetContent: AnyView? = nil
    
    // Push a new view onto the stack
    func push<Content: View>(_ view: Content) {
        viewStack.append(AnyView(view))
    }
    
    // Pop the top view from the stack
    func pop() {
        if !viewStack.isEmpty {
            viewStack.removeLast()
        }
    }
    
    // Pop to the root view
    func popToRoot() {
        viewStack.removeAll()
    }
    
    // Present a modal sheet
    func presentSheet<Content: View>(_ view: Content) {
        sheetContent = AnyView(view)
        isSheetPresented = true
    }
    
    // Dismiss the modal sheet
    func dismissSheet() {
        isSheetPresented = false
        sheetContent = nil
    }
    
}
