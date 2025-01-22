//: [Previous](@previous)

import Foundation

@objc protocol P {
    @objc optional func show()
    @objc optional func show2()
    func display()
}

class A: P {
    func display() {
        
    }
    
    
}



// Ex3:
protocol Reviewable {
    func addReview(rating: Int, comment: String)
    func getAllReviews() -> [(rating: Int, comment: String)]
    func calculateAverageRating() -> Double
}

class Review: Reviewable {
    var reviews: [(rating: Int, comment: String)] = []
    func addReview(rating: Int, comment: String) {
        guard rating >= 0 && rating <= 5 else {
            print("Rating must be between 1 and 5.")
            return
        }
        reviews.append((rating, comment))
    }
    
    func getAllReviews() -> [(rating: Int, comment: String)] {
        return reviews
    }
    
    func calculateAverageRating() -> Double {
        guard !reviews.isEmpty else {
            return 0.0
        }
        let totalRating = reviews.reduce(0 , {$0 + $1.rating})
        return Double(totalRating) / Double(reviews.count)
    }
}

class ProductReview: Review {
    private var productName: String
    
    init(productName: String) {
        self.productName = productName
        super.init()
    }
    
    func getProductName() -> String {
        return productName
    }
}

class ServiceReview: Review {
    private var serviceName: String
    
    init(serviceName: String) {
        self.serviceName = serviceName
        super.init()
    }
    
    func getServiceName() -> String {
        return serviceName
    }
}

class PlaceReview: Review {
    private var placeName: String
    
    init(placeName: String) {
        self.placeName = placeName
        super.init()
    }
    
    func getPlaceName() -> String {
        return placeName
    }
}

class ReviewManager {
    private var reviews: [Reviewable] = []
    
    func addReview(_ reviewable: Reviewable) {
        reviews.append(reviewable)
    }
    
    func calculateOverallAverageRating() -> Double {
        guard !reviews.isEmpty else {
            return 0.0
        }
        let totalRating = reviews.reduce(0, {
            total, review in
            return total + review.calculateAverageRating()
        })
        return totalRating / Double(reviews.count)
    }
}

let productReview = ProductReview(productName: "Iphone")
productReview.addReview(rating: 7, comment: "kha on")
productReview.addReview(rating: 5, comment: "good")
productReview.addReview(rating: 5, comment: "good")
print(productReview.getAllReviews())
print("Product average rating: \(productReview.calculateAverageRating())")

let serviceReview = ServiceReview(serviceName: "Customer support")
serviceReview.addReview(rating: 3, comment: "not good")
serviceReview.addReview(rating: 2, comment: "not good")
serviceReview.addReview(rating: 1, comment: "not good")
print("Service average rating: \(serviceReview.calculateAverageRating())")

let reviewManager = ReviewManager()
reviewManager.addReview(productReview)
reviewManager.addReview(serviceReview)
let result = reviewManager.calculateOverallAverageRating()
print(result)



// Ex2 + Ex4:
protocol Product {
    func getPrice() -> Double
    func getDescription() -> String
    func applyDiscount(percentage: Double)
}

class PhysicalProduct: Product {
    var name: String
    var price: Double
    var weight: Double
    
    init(name: String, price: Double, weight: Double) {
        self.name = name
        self.price = price
        self.weight = weight
    }
    
    func getPrice() -> Double {
        return price * weight
    }
    
    func applyDiscount(percentage: Double) {
        price -= price * (percentage/100)
        print("Product \(name) has been added discount.")
    }
    
    func getDescription() -> String {
        return "Physical name: \(name) - price: \(price) - weight: \(weight)"
    }
}

class DigitalProduct: Product {
    var name: String
    var price: Double
    var fileSize: Double
    
    init(name: String, price: Double, fileSize: Double) {
        self.name = name
        self.price = price
        self.fileSize = fileSize
    }
    
    func getPrice() -> Double {
        return price * fileSize
    }
    
    func applyDiscount(percentage: Double) {
        price -= price * (percentage/100)
        print("Product \(name) has been added discount.")
    }

    
    func getDescription() -> String {
        return "Digital Product: \(name), Price: \(price), File Size: \(fileSize) MB"
    }
}

class SubscriptionProduct: Product {
    var name: String
    var pricePerMonth: Double
    var duration: Int
    
    init(name: String, pricePerMonth: Double, duration: Int) {
        self.name = name
        self.pricePerMonth = pricePerMonth
        self.duration = duration
    }
    
    func applyDiscount(percentage: Double) {
        pricePerMonth -= pricePerMonth * (percentage/100)
        print("Product \(name) has been added discount.")
    }
    
    func getPrice() -> Double {
        return pricePerMonth * Double(duration)
    }
    
    func getDescription() -> String {
        return "Subscription Product: \(name), Price Per Month: \(pricePerMonth), Duration: \(duration) months, Total Price: \(getPrice())"
    }
}

class ShoppingCart {
    private var products: [Product] = []
    
    func addProduct(product: Product) {
        products.append(product)
        print("Added to cart.")
    }
    
    func removeProduct(at index: Int) {
        if index >= 0 && index < products.count {
            let removedProduct = products.remove(at: index)
            print("Removed product from cart: \(removedProduct)")
        } else {
            print("Index invalid.")
        }
    }
    
    func calculateTotalPrice() -> Double {
        return products.reduce(0, { (x, y) in
            return x + y.getPrice() })
    }
    
    func showCartDetails() {
        if products.isEmpty {
            print("The cart is empty.")
        } else {
            print("Cart details: ")
            for (index, product) in products.enumerated() {
                print("\(index) _ \(product.getDescription())")
            }
        }
    }
}

var physicalProduct = PhysicalProduct(name: "PhysicalProduct", price: 100, weight: 10)
physicalProduct.applyDiscount(percentage: 50)

var shoppingCart = ShoppingCart()
shoppingCart.addProduct(product: physicalProduct)
print(shoppingCart.calculateTotalPrice())



// Ex1:
protocol Bookable {
    func book()
    func cancel()
}

extension Bookable {
    func commonBookLogic(isBooked: inout Bool, itemName: String) {
        if !isBooked {
            isBooked = true
            print("\(itemName) has been booked.")
        } else {
            print("\(itemName) is already booked.")
        }
    }
    
    func commonCancelLogic(isBooked: inout Bool, itemName: String) {
        if isBooked {
            isBooked = false
            print("\(itemName) has been canceled.")
        } else {
            print("\(itemName) was not booked.")
        }
    }
}

class Flight: Bookable {
    var flightNumber: String
    var isBooked: Bool = false
    
    init(flightNumber: String) {
        self.flightNumber = flightNumber
    }
    
    func book() {
        commonBookLogic(isBooked: &isBooked, itemName: flightNumber)
    }
    
    func cancel() {
        commonCancelLogic(isBooked: &isBooked, itemName: flightNumber)
    }
}

class Hotel: Bookable {
    var hotelName: String
    var isBooked: Bool = false
    
    init(hotelName: String) {
        self.hotelName = hotelName
    }
    
    func book() {
        commonBookLogic(isBooked: &isBooked, itemName: hotelName)
    }
    
    func cancel() {
        commonCancelLogic(isBooked: &isBooked, itemName: hotelName)
    }
}

class CarRental: Bookable {
    var carName: String
    var isBooked: Bool = false
    
    init(carName: String) {
        self.carName = carName
    }
    
    func book() {
        commonBookLogic(isBooked: &isBooked, itemName: carName)
    }
    
    func cancel() {
        commonCancelLogic(isBooked: &isBooked, itemName: carName)
    }
}



