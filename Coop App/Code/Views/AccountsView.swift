//
//  AccountsView.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import SwiftUI

struct AccountsView: View {
    var body: some View {
        
        Image("profile")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .cornerRadius(100)
        
        Text("John Doe")
            .appFont(.productSansBold, size: 16)
        
    }
}

#Preview {
    AccountsView()
}
