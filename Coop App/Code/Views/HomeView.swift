//
//  HomeView.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: ExpenseViewModel
    
    @State var selectedMonth: String = "January"
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack(spacing: 10) {
                
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                
                Text("Welcome back, John Doe 👋🏽")
                    .appFont(.productSansBold, size: 16)
                
                Spacer()
                
                Button(action: {
                    // Go to notifications
                }, label: {
                    Image(systemName: "bell.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color("primaryColor"))
                    
                })
                
            }
            .padding(.horizontal)
            
            VStack(spacing: 10) {
                
                HStack {
                    Text("\(String(format: "%.2f", viewModel.remainingBalance))")
                        .appFont(.productSansBold, size: 30)
                        .foregroundStyle(.white)
                    Text("Ksh.")
                        .appFont(.productSansRegular, size: 16)
                        .foregroundStyle(.white)
                }
                
                Text("remaining on your monthly budget")
                    .appFont(.productSansRegular, size: 16)
                    .foregroundStyle(.white)
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(LinearGradient(colors: [Color("primaryColor"), Color("secondaryColor")], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(20)
            .padding(.horizontal)
            
            VStack(spacing: 10) {
                HStack {
                    
                    VStack(alignment: .leading) {
                        Text("Total spend this month")
                            .appFont(.productSansRegular, size: 16)
                            .foregroundStyle(.secondary)
                        
                        Text("Ksh. \(String(format: "%.2f", viewModel.totalMonthSpend))")
                            .appFont(.productSansBold, size: 16)
                            .foregroundStyle(.primary)
                        
                    }
                    
                    Spacer()
                    
                    Picker("Month", selection: $selectedMonth) {
                        ForEach(MonthsOfYear.allCases) { month in
                            Text(month.rawValue)
                                .tag(month)
                        }
                    }
                    .foregroundStyle(.primary)
                }
                .padding()
                
                categoriesSection
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color("backgroundColor"))
            .cornerRadius(20)
            .padding(.horizontal)
            
            Spacer()
        }
    }
    
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Spending Categories")
                .appFont(.productSansBold, size: 16)
            
            ForEach(viewModel.spendingByCategory) { item in
                HStack {
                    Text(item.category)
                        .appFont(.productSansBold, size: 12)
                    Spacer()
                    Text(item.total, format: .currency(code: "KES"))
                        .foregroundStyle(.secondary)
                        .appFont(.productSansRegular, size: 12)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
    
}

enum MonthsOfYear: String, CaseIterable, Identifiable {
    case january = "January"
    case february = "February"
    case march = "March"
    case april = "April"
    case may = "May"
    case june = "June"
    case july = "July"
    case august = "August"
    case september = "September"
    case october = "October"
    case november = "November"
    case december = "December"
    
    var id: String { rawValue }
}

#Preview {
    HomeView()
        .environmentObject(ExpenseViewModel(context: PersistenceController.preview.container.viewContext))
}
