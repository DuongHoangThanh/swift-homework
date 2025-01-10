//: [Previous](@previous)

import Foundation


// Ex3:
class ShoppingCart {
    lazy var items: [String: Double] = {
        print("Fetching items from server...")
        return [
            "Iphone 15": 2000,
            "SamSung GFlip3": 1500
        ]
    }()
    
    var totalPrice: Double {
        return items.values.reduce(0, +)
    }
    
    private var priceHistory: [Double] = []
    
    var observedTotalPrice: Double = 0 {
        didSet {
            print("Total price update: \(observedTotalPrice)")
            priceHistory.append(observedTotalPrice)
        }
    }
    
    func addItem(name: String, price: Double) {
        items[name] = price
        updateTotalPrice()
    }
    
    func removeItem(name: String) {
        if  items.removeValue(forKey: name) != nil {
            updateTotalPrice()
        } else {
            print("Item '\(name)' not found!")
        }
    }
    
    private func updateTotalPrice() {
        observedTotalPrice = totalPrice
    }
    
    func showPriceHistory() {
        print("Price history: \(priceHistory)")
    }
}

let cart = ShoppingCart()
print("Items in cart: \(cart.items)")
print("Total price: \(cart.totalPrice)")



// Ex2:
class BankAccount2 {
    var balance : Double
    var isOverdrawn: Bool {
        return balance < 0
    }
    
    nonisolated(unsafe) static var totalAccounts: Int = 0
    
    init(balance: Double) {
        self.balance = balance
        BankAccount2.totalAccounts += 1
    }
    
    func deposit(amount: Double) {
        balance += amount
        print("Deposit \(amount). New balance: \(balance)")
    }
    
    func withdraw(amount: Double) {
        if amount > balance {
            print("Insuffucient funds! Withdrawal failed.")
        } else {
            balance -= amount
            print("Withdrew \(amount). New balance: \(balance)")
        }
    }
    
    deinit {
        BankAccount2.totalAccounts -= 1
    }
}

var thanhAccount2: BankAccount2? = BankAccount2(balance: 50)
print(thanhAccount2?.balance)
print(thanhAccount2?.isOverdrawn)
thanhAccount2?.withdraw(amount: 20)
thanhAccount2 = nil
print(thanhAccount2?.balance)


// Ex1:
class BankAccount1 {
    var balance: Int = 0 {
        didSet {
            if balance < 0 {
                balance = oldValue
                print("Balance cannot be negative")
            }
        }
    }
}

var thanhAccount = BankAccount1()
thanhAccount.balance = -2
