//
//  SplitSummaryView.swift
//  TipCalculator
//
//  Created by Bob on 2026-06-22.
//

import SwiftUI

struct SplitSummaryView: View {
    let calculation: TipCalculation
    @ObservedObject var historyViewModel: HistoryViewModel
    
    @Environment(\.dismiss) private var dismiss
    @State private var showingSavedAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                headerSection
                
                // Bill Breakdown
                breakdownSection
                
                // Split Details
                splitDetailsSection
                
                // Action Buttons
                actionButtons
            }
            .padding()
        }
        .navigationTitle("Split Summary")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Saved!", isPresented: $showingSavedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Calculation saved to history")
        }
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
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
    }
    
    // MARK: - Breakdown Section
    
    private var breakdownSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Bill Breakdown")
                .font(.title2)
                .fontWeight(.bold)
            
            SummaryRow(
                icon: "doc.text",
                title: "Original Bill",
                value: calculation.formattedBillAmount,
                color: .blue
            )
            
            SummaryRow(
                icon: "percent",
                title: "Tip (\(calculation.tipPercentage)%)",
                value: calculation.formattedTipAmount,
                color: .orange
            )
            
            Divider()
            
            SummaryRow(
                icon: "dollarsign.circle.fill",
                title: "Total",
                value: calculation.formattedTotalAmount,
                color: .green,
                isLarge: true
            )
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
    
    // MARK: - Split Details Section
    
    private var splitDetailsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Split Details")
                .font(.title2)
                .fontWeight(.bold)
            
            HStack {
                Image(systemName: "person.2.fill")
                    .font(.title2)
                    .foregroundColor(.purple)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Number of People")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(calculation.numberOfPeople)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            HStack {
                Image(systemName: "person.fill")
                    .font(.title2)
                    .foregroundColor(.purple)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Per Person Amount")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(calculation.formattedPerPersonAmount)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
    
    // MARK: - Action Buttons
    
    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button(action: {
                historyViewModel.saveCalculation(calculation)
                showingSavedAlert = true
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.down")
                    Text("Save to History")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
            }
            
            Button(action: {
                dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back to Calculator")
                }
                .font(.headline)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
        }
    }
}

// MARK: - Summary Row Component

struct SummaryRow: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    var isLarge: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(isLarge ? .title2 : .title3)
                .foregroundColor(color)
                .frame(width: 40)
            
            Text(title)
                .font(isLarge ? .title3 : .body)
                .fontWeight(isLarge ? .semibold : .regular)
            
            Spacer()
            
            Text(value)
                .font(isLarge ? .title2 : .title3)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
    }
}

#Preview {
    NavigationStack {
        SplitSummaryView(
            calculation: TipCalculation(
                billAmount: 100.0,
                tipPercentage: 15,
                numberOfPeople: 4
            ),
            historyViewModel: HistoryViewModel()
        )
    }
}

// Made with Bob
