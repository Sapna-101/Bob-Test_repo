//
//  TipCalculatorViewModel.swift
//  TipCalculator
//
//  Created by Bob on 2026-06-22.
//

import Foundation

class TipCalculatorViewModel: ObservableObject {
    // Published properties for UI binding
    @Published var billAmountText: String = ""
    @Published var tipPercentage: Int = 15
    @Published var numberOfPeople: Int = 1
    
    // Available tip percentages
    let tipOptions = [10, 15, 20, 25]
    
    // Computed properties
    var billAmount: Double {
        Double(billAmountText) ?? 0.0
    }
    
    var isValidBill: Bool {
        billAmount > 0
    }
    
    // Create calculation from current values
    func createCalculation() -> TipCalculation {
        return TipCalculation(
            billAmount: billAmount,
            tipPercentage: tipPercentage,
            numberOfPeople: numberOfPeople
        )
    }
    
    // Calculate tip amount
    func calculateTipAmount() -> Double {
        billAmount * Double(tipPercentage) / 100.0
    }
    
    // Calculate total amount
    func calculateTotalAmount() -> Double {
        billAmount + calculateTipAmount()
    }
    
    // Calculate per person amount
    func calculatePerPersonAmount() -> Double {
        guard numberOfPeople > 0 else { return 0 }
        return calculateTotalAmount() / Double(numberOfPeople)
    }
    
    // Format currency
    func formatCurrency(_ amount: Double) -> String {
        String(format: "$%.2f", amount)
    }
    
    // Reset calculator
    func reset() {
        billAmountText = ""
        tipPercentage = 15
        numberOfPeople = 1
    }
    
    // Validate and prepare for navigation
    func canProceedToSummary() -> Bool {
        return isValidBill
    }
}

// Made with Bob
