//
//  TipCalculation.swift
//  TipCalculator
//
//  Created by Bob on 2026-06-22.
//

import Foundation

struct TipCalculation: Identifiable, Codable {
    let id: UUID
    let billAmount: Double
    let tipPercentage: Int
    let numberOfPeople: Int
    let date: Date
    
    // Computed properties
    var tipAmount: Double {
        billAmount * Double(tipPercentage) / 100.0
    }
    
    var totalAmount: Double {
        billAmount + tipAmount
    }
    
    var perPersonAmount: Double {
        guard numberOfPeople > 0 else { return 0 }
        return totalAmount / Double(numberOfPeople)
    }
    
    // Formatted strings for display
    var formattedBillAmount: String {
        String(format: "$%.2f", billAmount)
    }
    
    var formattedTipAmount: String {
        String(format: "$%.2f", tipAmount)
    }
    
    var formattedTotalAmount: String {
        String(format: "$%.2f", totalAmount)
    }
    
    var formattedPerPersonAmount: String {
        String(format: "$%.2f", perPersonAmount)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Initializer
    init(id: UUID = UUID(), billAmount: Double, tipPercentage: Int, numberOfPeople: Int, date: Date = Date()) {
        self.id = id
        self.billAmount = billAmount
        self.tipPercentage = tipPercentage
        self.numberOfPeople = numberOfPeople
        self.date = date
    }
}

// Made with Bob
