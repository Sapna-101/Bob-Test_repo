//
//  TipCalculatorView.swift
//  TipCalculator
//
//  Created by Bob on 2026-06-22.
//

import SwiftUI

struct TipCalculatorView: View {
    @StateObject private var viewModel = TipCalculatorViewModel()
    @StateObject private var historyViewModel = HistoryViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Bill Amount Section
                    billAmountSection
                    
                    // Tip Percentage Section
                    tipPercentageSection
                    
                    // Number of People Section
                    numberOfPeopleSection
                    
                    // Results Section
                    resultsSection
                    
                    // Navigation Buttons
                    navigationButtons
                }
                .padding()
            }
            .navigationTitle("Tip Calculator")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: HistoryView(viewModel: historyViewModel)) {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                }
            }
        }
    }
    
    // MARK: - Bill Amount Section
    
    private var billAmountSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Bill Amount")
                .font(.headline)
            
            TextField("0.00", text: $viewModel.billAmountText)
                .keyboardType(.decimalPad)
                .font(.system(size: 48, weight: .bold))
                .multilineTextAlignment(.center)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .overlay(
                    HStack {
                        Text("$")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.leading, 20)
                )
        }
    }
    
    // MARK: - Tip Percentage Section
    
    private var tipPercentageSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tip Percentage")
                .font(.headline)
            
            Picker("Tip", selection: $viewModel.tipPercentage) {
                ForEach(viewModel.tipOptions, id: \.self) { percentage in
                    Text("\(percentage)%").tag(percentage)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    // MARK: - Number of People Section
    
    private var numberOfPeopleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Number of People")
                .font(.headline)
            
            HStack {
                Text("\(viewModel.numberOfPeople)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                
                Stepper("", value: $viewModel.numberOfPeople, in: 1...20)
                    .labelsHidden()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
    
    // MARK: - Results Section
    
    private var resultsSection: some View {
        VStack(spacing: 16) {
            Divider()
            
            ResultRow(
                title: "Tip Amount",
                amount: viewModel.formatCurrency(viewModel.calculateTipAmount()),
                color: .blue
            )
            
            ResultRow(
                title: "Total Amount",
                amount: viewModel.formatCurrency(viewModel.calculateTotalAmount()),
                color: .green
            )
            
            ResultRow(
                title: "Per Person",
                amount: viewModel.formatCurrency(viewModel.calculatePerPersonAmount()),
                color: .purple,
                isLarge: true
            )
        }
    }
    
    // MARK: - Navigation Buttons
    
    private var navigationButtons: some View {
        VStack(spacing: 12) {
            NavigationLink(destination: SplitSummaryView(
                calculation: viewModel.createCalculation(),
                historyViewModel: historyViewModel
            )) {
                Text("View Split Summary")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isValidBill ? Color.blue : Color.gray)
                    .cornerRadius(12)
            }
            .disabled(!viewModel.isValidBill)
            
            Button(action: {
                viewModel.reset()
            }) {
                Text("Reset")
                    .font(.headline)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
            }
        }
    }
}

// MARK: - Result Row Component

struct ResultRow: View {
    let title: String
    let amount: String
    let color: Color
    var isLarge: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .font(isLarge ? .title3 : .body)
                .fontWeight(isLarge ? .semibold : .regular)
            
            Spacer()
            
            Text(amount)
                .font(isLarge ? .title : .title3)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    TipCalculatorView()
}

// Made with Bob
