//
//  HistoryView.swift
//  TipCalculator
//
//  Created by Bob on 2026-06-22.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel
    @State private var showingClearAlert = false
    
    var body: some View {
        Group {
            if viewModel.hasHistory {
                historyList
            } else {
                emptyStateView
            }
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if viewModel.hasHistory {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        showingClearAlert = true
                    } label: {
                        Text("Clear All")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .alert("Clear All History?", isPresented: $showingClearAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Clear All", role: .destructive) {
                viewModel.clearAll()
            }
        } message: {
            Text("This will delete all saved calculations. This action cannot be undone.")
        }
    }
    
    // MARK: - History List
    
    private var historyList: some View {
        List {
            ForEach(viewModel.calculations) { calculation in
                NavigationLink(destination: HistoryDetailView(calculation: calculation)) {
                    HistoryRowView(calculation: calculation)
                }
            }
            .onDelete(perform: viewModel.deleteCalculation)
        }
        .listStyle(.insetGrouped)
    }
    
    // MARK: - Empty State
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 80))
                .foregroundColor(.secondary)
            
            Text("No History Yet")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Your saved calculations will appear here")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - History Row View

struct HistoryRowView: View {
    let calculation: TipCalculation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(calculation.formattedTotalAmount)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                
                Spacer()
                
                Text("\(calculation.numberOfPeople) \(calculation.numberOfPeople == 1 ? "person" : "people")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Label(calculation.formattedBillAmount, systemImage: "doc.text")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Label("\(calculation.tipPercentage)%", systemImage: "percent")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(calculation.formattedDate)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - History Detail View

struct HistoryDetailView: View {
    let calculation: TipCalculation
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Total Amount Header
                VStack(spacing: 8) {
                    Text("Total Amount")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(calculation.formattedTotalAmount)
                        .font(.system(size: 56, weight: .bold))
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Details
                VStack(alignment: .leading, spacing: 16) {
                    Text("Details")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    DetailRow(
                        icon: "doc.text",
                        title: "Bill Amount",
                        value: calculation.formattedBillAmount
                    )
                    
                    DetailRow(
                        icon: "percent",
                        title: "Tip (\(calculation.tipPercentage)%)",
                        value: calculation.formattedTipAmount
                    )
                    
                    DetailRow(
                        icon: "person.2.fill",
                        title: "Number of People",
                        value: "\(calculation.numberOfPeople)"
                    )
                    
                    DetailRow(
                        icon: "person.fill",
                        title: "Per Person",
                        value: calculation.formattedPerPersonAmount
                    )
                    
                    DetailRow(
                        icon: "calendar",
                        title: "Date",
                        value: calculation.formattedDate
                    )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle("Calculation Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Detail Row Component

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            Text(title)
                .font(.body)
            
            Spacer()
            
            Text(value)
                .font(.body)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4)
    }
}

#Preview("History with Data") {
    NavigationStack {
        HistoryView(viewModel: {
            let vm = HistoryViewModel()
            vm.saveCalculation(TipCalculation(billAmount: 100, tipPercentage: 15, numberOfPeople: 4))
            vm.saveCalculation(TipCalculation(billAmount: 50, tipPercentage: 20, numberOfPeople: 2))
            return vm
        }())
    }
}

#Preview("Empty History") {
    NavigationStack {
        HistoryView(viewModel: HistoryViewModel())
    }
}

// Made with Bob
