//
//  HistoryViewModel.swift
//  TipCalculator
//
//  Created by Bob on 2026-06-22.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var calculations: [TipCalculation] = []
    
    private let userDefaults = UserDefaults.standard
    private let historyKey = "tipCalculationHistory"
    
    init() {
        loadHistory()
    }
    
    // MARK: - Save to History
    
    func saveCalculation(_ calculation: TipCalculation) {
        calculations.insert(calculation, at: 0) // Add to beginning
        saveToUserDefaults()
    }
    
    // MARK: - Delete from History
    
    func deleteCalculation(at offsets: IndexSet) {
        calculations.remove(atOffsets: offsets)
        saveToUserDefaults()
    }
    
    func deleteCalculation(_ calculation: TipCalculation) {
        calculations.removeAll { $0.id == calculation.id }
        saveToUserDefaults()
    }
    
    // MARK: - Clear All
    
    func clearAll() {
        calculations.removeAll()
        saveToUserDefaults()
    }
    
    // MARK: - UserDefaults Persistence
    
    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(calculations) {
            userDefaults.set(encoded, forKey: historyKey)
        }
    }
    
    private func loadHistory() {
        guard let data = userDefaults.data(forKey: historyKey),
              let decoded = try? JSONDecoder().decode([TipCalculation].self, from: data) else {
            calculations = []
            return
        }
        calculations = decoded
    }
    
    // MARK: - Computed Properties
    
    var hasHistory: Bool {
        !calculations.isEmpty
    }
    
    var totalCalculations: Int {
        calculations.count
    }
}

// Made with Bob
