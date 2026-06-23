BookStore iOS App

A modern, feature-rich iOS bookstore application built with SwiftUI, offering a seamless book browsing and shopping experience.

## 🎯 Overview

BookStore is a native iOS application that allows users to browse books, view detailed information, manage a shopping cart, and complete purchases. The app features a clean, intuitive interface with smooth animations and a responsive design.

## ✨ Features

- **Browse Books**: View featured books and explore the complete catalog
- **Search Functionality**: Search books by title or author
- **Book Details**: View comprehensive information including ratings, reviews, and descriptions
- **Shopping Cart**: Add books to cart with quantity selection
- **Cart Management**: Update quantities, remove items, and view order summary
- **Persistent Cart**: Cart data persists across app sessions using UserDefaults
- **Order Checkout**: Complete purchases with tax calculation
- **Responsive UI**: Adaptive layouts for different screen sizes

## 🏗️ Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern with SwiftUI's declarative approach.

### Project Structure

```
BookStore/
├── Models/
│   ├── Book.swift              # Book data model with mock data
│   └── CartItem.swift          # Shopping cart item model
├── ViewModels/
│   ├── BookViewModel.swift     # Manages book data and search
- **Dependencies**: None (pure SwiftUI)

## 📂 Project Structure

```
BookStore/
├── BookStoreApp.swift          # App entry point
├── Models/
│   ├── Book.swift              # Book model with 10 mock books
│   └── CartItem.swift          # Cart item model
├── ViewModels/
│   ├── BookViewModel.swift     # Books & search logic
│   └── CartViewModel.swift     # Cart & checkout logic
├── Views/
│   ├── HomeView.swift          # Home screen
│   ├── BookDetailView.swift    # Book details screen
│   └── CartView.swift          # Shopping cart screen
└── Extensions/
    └── Color+Extensions.swift  # Hex color support
```

## 🚀 Getting Started

### Prerequisites
- Xcode 14.0 or later
- macOS Ventura or later
- iOS 16.0+ Simulator or Device

### Installation

1. **Create New Xcode Project**
   - Open Xcode
   - File → New → Project
   - Choose "App" template
   - Product Name: `BookStore`
   - Interface: SwiftUI
   - Language: Swift
   - Minimum Deployment: iOS 16.0

2. **Add Source Files**
   - Copy all `.swift` files to your project
   - Ensure all files are added to the target

3. **Build and Run**
   - Select a simulator or device
   - Press `Cmd + R` to build and run

## 📖 Mock Data

The app includes 10 pre-configured books:

### Featured Books (4)
- Swift Programming Mastery (Technology)
- The Midnight Garden (Fiction)
- Quantum Physics Explained (Science)
- Steve Jobs: The Visionary (Biography)

### All Books (6 additional)
- Ancient Civilizations (History)
- Mindful Living (Self Help)
- The Algorithm Designer (Technology)
- Echoes of Tomorrow (Fiction)
- The Art of Leadership (Self Help)
- Climate Change: Our Future (Science)

## 🎨 Design Features

### Color Scheme
- Each book has a unique cover color (10 distinct colors)
- Blue accent color for prices and CTAs
- System colors for text hierarchy

### UI Components
- **Featured Cards**: 160x240pt with overlay text
- **Grid Cards**: Flexible 2-column layout
- **Book Covers**: 200x280pt with shadow effects
- **Cart Badge**: Red circle with item count
- **Rating Stars**: 5-star visual rating system

## 🛒 Shopping Cart Features

### Cart Management
- Add books with quantity selection (1-10)
- Update quantities with +/- buttons
- Swipe left to delete items
- Automatic cart persistence

### Order Summary
- Subtotal calculation
- 10% tax calculation
- Total amount display
- Formatted currency ($XX.XX)

### Checkout Flow
1. Review cart items
2. View order summary
3. Tap "Checkout" button
4. See confirmation alert
5. Cart automatically clears
6. Return to browsing

## 🔧 Technical Details

### Data Persistence
```swift
// Cart data saved to UserDefaults
private let cartKey = "bookstore_cart"

// Automatic save on:
- Add to cart
- Update quantity
- Remove item
- Place order
```

### Search Implementation
```swift
// Real-time filtering
var filteredBooks: [Book] {
    if searchText.isEmpty {
        return allBooks
    } else {
        return allBooks.filter { book in
            book.title.localizedCaseInsensitiveContains(searchText) ||
            book.author.localizedCaseInsensitiveContains(searchText)
        }
    }
}
```

### Navigation Flow
```
HomeView (Root)
├── BookDetailView (Push)
└── CartView (Sheet/Push)
```

## 📱 Screens

### 1. Home Screen
- Large navigation title "BookStore"
- Cart icon with badge (item count)
- Search bar
- Featured books horizontal scroll
- All books 2-column grid
- Tap any book → Book Detail

### 2. Book Detail Screen
- Large book cover (200x280)
- Title, author, rating
- Genre tag
- Price
- Description section
- Quantity selector (1-10)
- Add to Cart button
- Success feedback (green checkmark)

### 3. Cart Screen
- "My Cart" title
- Empty state with "Browse Books" button
- Cart items list
- Swipe to delete
- Quantity stepper per item
- Order summary card
- Checkout button
- Order confirmation alert

## 🎯 Key Highlights

✅ **No Placeholders**: Every function fully implemented  
✅ **No TODOs**: Complete working code  
✅ **No External Dependencies**: Pure SwiftUI  
✅ **No Backend**: Static mock data only  
✅ **MVVM Architecture**: Clean separation of concerns  
✅ **Persistent Cart**: Survives app restarts  
✅ **Real-time Search**: Instant filtering  
✅ **Responsive UI**: Adapts to different screen sizes  

## 📝 Code Quality

- **SwiftUI Best Practices**: Modern declarative syntax
- **MVVM Pattern**: Clear separation of business logic
- **Computed Properties**: Efficient data transformation
- **@Published Properties**: Reactive UI updates
- **@EnvironmentObject**: Shared state management
- **Codable Protocol**: Easy JSON serialization

## 🧪 Testing

### Manual Testing Checklist
- [ ] Browse featured and all books
- [ ] Search for books by title
- [ ] Search for books by author
- [ ] View book details
- [ ] Adjust quantity (1-10)
- [ ] Add book to cart
- [ ] View cart badge update
- [ ] Open cart
- [ ] Update quantities in cart
- [ ] Swipe to delete items
- [ ] View order summary calculations
- [ ] Complete checkout
- [ ] Verify cart clears
- [ ] Close and reopen app
- [ ] Verify cart persistence

## 🔮 Future Enhancements

Potential features for future versions:
- User authentication
- Backend API integration
- Payment processing
- Order history
- Book reviews and ratings
- Wishlist functionality
- Push notifications
- Dark mode optimization
- iPad support with adaptive layouts
- Accessibility improvements

## 📄 License

This is a sample project for educational purposes.

## 👨‍💻 Author

Created as a complete SwiftUI eCommerce demonstration app.

---

**Built using SwiftUI**
