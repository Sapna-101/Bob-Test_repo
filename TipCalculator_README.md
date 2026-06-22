# TipCalculator - iOS SwiftUI App

A simple, elegant tip calculator app built with SwiftUI following strict MVVM architecture.

![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0-green.svg)

## 📱 Features

### Screen 1: Tip Calculator
- ✅ Bill amount input with numeric keyboard
- ✅ Segmented picker for tip percentage (10%, 15%, 20%, 25%)
- ✅ Stepper for number of people (1-20)
- ✅ Live calculation results:
  - Tip amount
  - Total amount
  - Per person amount
- ✅ Navigate to Split Summary
- ✅ Reset functionality
- ✅ Access to History

### Screen 2: Split Summary
- ✅ Full breakdown of calculation
- ✅ Visual display with icons
- ✅ Save to history option
- ✅ Back to calculator navigation
- ✅ Success alert on save

### Screen 3: History
- ✅ List of saved calculations
- ✅ Swipe to delete individual items
- ✅ Clear all option with confirmation
- ✅ Empty state view
- ✅ Detailed view for each calculation
- ✅ Persistent storage with UserDefaults

## 🏗️ Architecture

### Strict MVVM Pattern

```
TipCalculator/
├── TipCalculatorApp.swift          # App entry point
│
├── Models/                         # Data models
│   └── TipCalculation.swift        # Calculation model with computed properties
│
├── ViewModels/                     # Business logic
│   ├── TipCalculatorViewModel.swift # Calculator logic
│   └── HistoryViewModel.swift      # History & persistence logic
│
└── Views/                          # UI layer
    ├── TipCalculatorView.swift     # Main calculator screen
    ├── SplitSummaryView.swift      # Summary screen
    └── HistoryView.swift           # History screen
```

## 📊 Data Model

### TipCalculation
```swift
struct TipCalculation: Identifiable, Codable {
    let id: UUID
    let billAmount: Double
    let tipPercentage: Int
    let numberOfPeople: Int
    let date: Date
    
    // Computed properties
    var tipAmount: Double
    var totalAmount: Double
    var perPersonAmount: Double
    
    // Formatted strings
    var formattedBillAmount: String
    var formattedTipAmount: String
    var formattedTotalAmount: String
    var formattedPerPersonAmount: String
    var formattedDate: String
}
```

## 🎯 ViewModels

### TipCalculatorViewModel
**Responsibilities:**
- Manage calculator input state
- Perform tip calculations
- Validate input
- Create calculation objects

**Published Properties:**
- `billAmountText: String`
- `tipPercentage: Int`
- `numberOfPeople: Int`

**Methods:**
- `createCalculation() -> TipCalculation`
- `calculateTipAmount() -> Double`
- `calculateTotalAmount() -> Double`
- `calculatePerPersonAmount() -> Double`
- `reset()`

### HistoryViewModel
**Responsibilities:**
- Manage calculation history
- Save/load from UserDefaults
- Delete calculations
- Clear all history

**Published Properties:**
- `calculations: [TipCalculation]`

**Methods:**
- `saveCalculation(_ calculation: TipCalculation)`
- `deleteCalculation(at offsets: IndexSet)`
- `clearAll()`

## 🎨 Views

### TipCalculatorView
- Main calculator interface
- NavigationStack root
- Toolbar with history button
- Live calculation display
- Input validation

### SplitSummaryView
- Detailed breakdown display
- Save to history action
- Back navigation
- Success alert

### HistoryView
- List of saved calculations
- Swipe-to-delete
- Clear all with confirmation
- Empty state
- Navigation to detail view

## 💾 Data Persistence

### UserDefaults
- Key: `"tipCalculationHistory"`
- Format: JSON encoded array
- Automatic save on changes
- Load on app launch

### Implementation
```swift
// Save
if let encoded = try? JSONEncoder().encode(calculations) {
    userDefaults.set(encoded, forKey: historyKey)
}

// Load
if let data = userDefaults.data(forKey: historyKey),
   let decoded = try? JSONDecoder().decode([TipCalculation].self, from: data) {
    calculations = decoded
}
```

## 🚀 Getting Started

### Requirements
- Xcode 14.0+
- iOS 16.0+
- Swift 5.9+

### Installation

1. **Create Xcode Project**
   ```
   - Open Xcode
   - File → New → Project
   - iOS → App
   - Product Name: TipCalculator
   - Interface: SwiftUI
   - Language: Swift
   ```

2. **Add Files**
   - Copy all files from `TipCalculator/` folder
   - Drag into Xcode project
   - Ensure all files are added to target

3. **Build and Run**
   - Select simulator (iPhone 14+)
   - Press ⌘R to run

## 📖 Usage

### Calculate a Tip

1. **Enter Bill Amount**
   - Tap the bill amount field
   - Enter amount using numeric keyboard

2. **Select Tip Percentage**
   - Choose from 10%, 15%, 20%, or 25%
   - Default is 15%

3. **Set Number of People**
   - Use stepper to adjust (1-20)
   - Default is 1

4. **View Results**
   - Tip amount (blue)
   - Total amount (green)
   - Per person amount (purple)

5. **View Summary**
   - Tap "View Split Summary"
   - See detailed breakdown

6. **Save to History**
   - Tap "Save to History" in summary
   - Calculation saved with timestamp

### View History

1. **Access History**
   - Tap clock icon in toolbar
   - View all saved calculations

2. **View Details**
   - Tap any calculation
   - See full breakdown

3. **Delete Calculation**
   - Swipe left on item
   - Tap delete

4. **Clear All**
   - Tap "Clear All" in toolbar
   - Confirm deletion

## 🎯 MVVM Benefits

### Separation of Concerns
- **Model**: Pure data structures
- **ViewModel**: Business logic only
- **View**: UI presentation only

### Testability
- ViewModels can be unit tested
- No UI dependencies in logic
- Mock data easy to create

### Maintainability
- Clear responsibility boundaries
- Easy to modify individual layers
- Scalable architecture

## 🔄 Data Flow

```
User Input
    ↓
View (TipCalculatorView)
    ↓
ViewModel (TipCalculatorViewModel)
    ↓
Model (TipCalculation)
    ↓
ViewModel (HistoryViewModel)
    ↓
UserDefaults
    ↓
View Updates (@Published)
```

## 📱 Navigation Flow

```
TipCalculatorView (Root)
    ├→ SplitSummaryView
    │   └→ Back to Calculator
    │
    └→ HistoryView
        └→ HistoryDetailView
            └→ Back to History
```

## 🎨 UI Components

### Reusable Components
- `ResultRow`: Display calculation results
- `SummaryRow`: Display summary items
- `HistoryRowView`: History list item
- `DetailRow`: Detail view row

### Color Scheme
- **Blue**: Tip amount, primary actions
- **Green**: Total amount, success
- **Purple**: Per person amount
- **Orange**: Tip percentage
- **Red**: Delete actions
- **Gray**: Secondary elements

## 🧪 Testing

### Manual Testing Checklist

**Calculator Screen:**
- [ ] Enter bill amount
- [ ] Change tip percentage
- [ ] Adjust number of people
- [ ] Verify calculations are correct
- [ ] Test reset button
- [ ] Navigate to summary
- [ ] Navigate to history

**Summary Screen:**
- [ ] Verify all values displayed
- [ ] Save to history
- [ ] Check success alert
- [ ] Navigate back

**History Screen:**
- [ ] View saved calculations
- [ ] Swipe to delete
- [ ] Clear all with confirmation
- [ ] View empty state
- [ ] Tap for details

### Calculation Tests
```
Bill: $100, Tip: 15%, People: 4
Expected:
- Tip: $15.00
- Total: $115.00
- Per Person: $28.75
```

## 📊 Code Statistics

| Category | Files | Lines |
|----------|-------|-------|
| Models | 1 | ~60 |
| ViewModels | 2 | ~140 |
| Views | 3 | ~660 |
| App Entry | 1 | ~20 |
| **Total** | **7** | **~880** |

## ✨ Features Highlights

### Live Calculations
- Real-time updates as you type
- No "Calculate" button needed
- Instant feedback

### Smart Validation
- Disable summary button for invalid input
- Numeric keyboard for bill amount
- Constrained stepper range

### Persistent History
- Automatic save to UserDefaults
- Survives app restarts
- JSON encoding/decoding

### Clean UI
- Modern SwiftUI design
- SF Symbols icons
- Consistent spacing and colors
- Smooth animations

## 🔮 Future Enhancements

Potential features for future versions:
- [ ] Custom tip percentages
- [ ] Tax calculation
- [ ] Multiple currency support
- [ ] Share calculation via text/email
- [ ] Dark mode optimization
- [ ] iPad support with split view
- [ ] Export history to CSV
- [ ] Tip calculator widget
- [ ] Siri shortcuts
- [ ] iCloud sync

## 📝 Code Quality

### Best Practices
✅ Strict MVVM architecture  
✅ SwiftUI best practices  
✅ Computed properties for derived data  
✅ Proper use of @Published  
✅ NavigationStack for navigation  
✅ Reusable components  
✅ Clear naming conventions  
✅ Comprehensive comments  

### No External Dependencies
- Pure SwiftUI
- Standard library only
- No third-party packages
- Easy to maintain

## 🎓 Learning Points

This project demonstrates:
- MVVM architecture in SwiftUI
- UserDefaults persistence
- NavigationStack usage
- Codable protocol
- Computed properties
- @Published property wrappers
- List with swipe actions
- Alert dialogs
- Empty state views
- Preview providers

## 📄 License

This project is available for personal and educational use.

## 👨‍💻 Author

Created by Bob - AI Assistant  
Date: June 22, 2026

---

**Ready to calculate tips!** 🧮💰