//: [Previous](@previous)

import Foundation


// Ex3.2:
class Room2 {
    var roomNumber: Int
    var type: String
    var price: Double
    var isAvailable: Bool
    
    init(roomNumber: Int, type: String, price: Double, isAvailable: Bool = true) {
        self.roomNumber = roomNumber
        self.type = type
        self.price = price
        self.isAvailable = isAvailable
    }
}

class Reservation2 {
    var guestName: String
    var room: Room2
    var checkInDate: Date
    var checkOutDate: Date
    
    init(guestName: String, room: Room2, checkInDate: Date, checkOutDate: Date) {
        self.guestName = guestName
        self.room = room
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
    }
}

class Hotel2 {
    var rooms: [Room2] = []
    var reservations: [Reservation2] = []
    
    func addRoom(room: Room2) {
        rooms.append(room)
        print("Room has been added.")
    }
    
    func makeReservation(guestName: String, roomNumber: Int, checkInDate: Date, checkOutDate: Date) {
        if let rooom = rooms.first(where: {$0.roomNumber == roomNumber}) {
            if rooom.isAvailable {
                let reservation = Reservation2(guestName: guestName, room: rooom, checkInDate: checkInDate, checkOutDate: checkOutDate)
                reservations.append(reservation)
                rooom.isAvailable = false
                print("Successful")
            } else {
                print("Room not available")
            }
        }
    }
    
    func checkRoom(roomNumber: Int) {
        if let room = rooms.first(where: {$0.roomNumber == roomNumber}) {
            if room.isAvailable {
                print("Available.")
            } else {
                print("Not available.")
            }
        } else {
            print("RoomNumber not exist.")
        }
    }
        
}



// Ex4:
class Event {
    var title: String
    var startTime: Date
    var endTime: Date
    var location: String
    
    init(title: String, startTime: Date, endTime: Date, location: String) {
        self.title = title
        self.startTime = startTime
        self.endTime = endTime
        self.location = location
    }
}

class Calendar {
    var events: [Event] = []
    
    func addEvent(event: Event) {
        if !isOverlapping(newEvent: event) {
            events.append(event)
            print("Event has been added.")
        } else {
            print("Event \(event.title) overlaps with an existing event.")
        }
    }
    
    func removeEvent(title: String) {
        if let index = events.firstIndex(where: {$0.title == title}) {
            events.remove(at: index)
            print("Event \(title) has been removed.")
        } else {
            print("Event \(title) not found.")
        }
    }
    
    func displayEvents() {
        if events.isEmpty {
            print("No events in Calendar.")
        } else {
            print("List Events: ")
            for event in events {
                print("- Event: \(event.title) from \(event.startTime) to \(event.endTime) at \(event.location).")
            }
        }
    }
    
    private func isOverlapping(newEvent: Event) -> Bool {
        for event in events {
            if (newEvent.startTime < event.endTime && newEvent.endTime > event.startTime) {
                return true
            }
        }
        return false
    }
}

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"


let calendar = Calendar()

if let eventStart = dateFormatter.date(from: "2025-02-01 10:00"),
   let eventEnd = dateFormatter.date(from: "2025-02-01 12:00") {
    let event1 = Event(title: "Team Meeting", startTime: eventStart, endTime: eventEnd, location: "Conference Room")
    calendar.addEvent(event: event1)
}

if let eventStart = dateFormatter.date(from: "2025-02-01 11:00"),
   let eventEnd = dateFormatter.date(from: "2025-02-01 13:00") {
    let event2 = Event(title: "Project Discussion", startTime: eventStart, endTime: eventEnd, location: "Room 101")
    calendar.addEvent(event: event2)
}

calendar.displayEvents()

// Ex3:
class Room {
    var roomNumber: Int
    var type: String
    var price: Double
    var isAvailable: Bool
    
    init(roomNumber: Int, type: String, price: Double, isAvailable: Bool = true) {
        self.roomNumber = roomNumber
        self.type = type
        self.price = price
        self.isAvailable = isAvailable
    }
}

class Reservation {
    var guestName: String
    var room: Room
    var checkInDate: Date
    var checkOutDate: Date
    
    init(guestName: String, room: Room, checkInDate: Date, checkOutDate: Date) {
        self.guestName = guestName
        self.room = room
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
    }
}

class Hotel {
    private var rooms: [Room] = []
    private var reservations: [Reservation] = []
    
    func addRoom(room: Room) {
        rooms.append(room)
        print("Room \(room.roomNumber) has been added to the hotel.")
    }
    
    func displayAllRooms() {
        if rooms.isEmpty {
            print("No room available in the hotel.")
        } else {
            print("Rooms in the hotel:")
            for room in rooms {
                let avaibility = room.isAvailable ? "Available" : "Not Available"
                print("- Room \(room.roomNumber): \(room.type), $\(room.price)/night - \(avaibility)")
            }
        }
    }
    
    func makeReservation(guestName: String, roomNumber: Int, checkInDate: Date, checkOutDate: Date) {
        if let room = rooms.first(where: {$0.roomNumber == roomNumber}) {
            if room.isAvailable {
                let reservation = Reservation(guestName: guestName, room: room, checkInDate: checkInDate, checkOutDate: checkOutDate)
                reservations.append(reservation)
                room.isAvailable = false
                print("Reservation made for \(guestName) in Room \(roomNumber) from \(checkInDate) to \(checkOutDate).")
            } else {
                print("Room \(roomNumber) is not available.")
            }
        } else {
            print("Room \(roomNumber) dose not exist.")
        }
    }
    
    func checkRoomAvailability(roomNumber: Int) {
        if let room = rooms.first(where: {$0.roomNumber == roomNumber}) {
            if room.isAvailable {
                print("Room \(roomNumber) is available.")
            } else {
                print("Room \(roomNumber) is not available.")
            }
        } else {
            print("Room \(roomNumber) does not exist.")
        }
    }
}

let hotel = Hotel()

let room1 = Room(roomNumber: 101, type: "Single", price: 100.0)
let room2 = Room(roomNumber: 102, type: "Double", price: 150.0)
let room3 = Room(roomNumber: 103, type: "Suite", price: 250.0)

hotel.addRoom(room: room1)
hotel.addRoom(room: room2)
hotel.addRoom(room: room3)

hotel.displayAllRooms()

if let checkInDate = dateFormatter.date(from: "2025-01-20"),
   let checkOutDate = dateFormatter.date(from: "2025-01-25") {
    hotel.makeReservation(guestName: "John Doe", roomNumber: 101, checkInDate: checkInDate, checkOutDate: checkOutDate)
}

hotel.displayAllRooms()
hotel.checkRoomAvailability(roomNumber: 101)


    

// Ex2:
class Product {
    var productID: String
    var name: String
    var price: Double
    var quantity: Int
    
    init(productID: String, name: String, price: Double, quantity: Int) {
        self.productID = productID
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

class Order {
    var orderID: String
    var customerName: String
    var items: [Product]
    
    init(orderID: String, customerName: String, items: [Product]) {
        self.orderID = orderID
        self.customerName = customerName
        self.items = items
    }
    
    func calculateTotal() -> Double {
        return items.reduce(0, {
            $0 + ($1.price * Double($1.quantity))
        })
    }
    
    func isValid() -> Bool {
        return !items.isEmpty && items.allSatisfy({$0.quantity > 0})
    }
}

class OnlineStore {
    private var products: [Product] = []
    private var orders: [Order] = []
    
    func addProduct(product: Product) {
        products.append(product)
        print("Product \(product.name) has been added to the store")
    }
    
    func displayProducts() {
        if products.isEmpty {
            print("No products available in the store.")
        } else {
            print("Products available in the store:")
            for product in products {
                print("- \(product.name) (ID: \(product.productID)) - Price: \(product.price) - Quantity: \(product.quantity)")
            }
        }
    }
    
    func placeOrder(order: Order) {
        if order.isValid() {
            orders.append(order)
            print("Order \(order.orderID) for customer \(order.customerName) has been placed successfully.")
        } else {
            print("Order \(order.orderID) is invalid and cannot be placed.")
        }
    }
    
    func displayOrders() {
        if orders.isEmpty {
            print("No orders have been placed yet.")
        } else {
            print("Orders placed: ")
            for order in orders {
                print("- Order ID: \(order.orderID) - Customer: \(order.customerName) - Total: \(order.calculateTotal())")
            }
        }
    }
}

let store = OnlineStore()

let product1 = Product(productID: "P001", name: "Laptop", price: 1500.0, quantity: 5)
let product2 = Product(productID: "P002", name: "Smartphone", price: 800.0, quantity: 10)
let product3 = Product(productID: "P003", name: "Headphones", price: 200.0, quantity: 15)

store.addProduct(product: product1)
store.addProduct(product: product2)
store.addProduct(product: product3)

store.displayProducts()

let order1 = Order(orderID: "O001", customerName: "Alice", items: [
    Product(productID: "P001", name: "Laptop", price: 1500.0, quantity: 1),
    Product(productID: "P003", name: "Headphones", price: 200.0, quantity: 2)
])

let order2 = Order(orderID: "O002", customerName: "Bob", items: [
    Product(productID: "P002", name: "Smartphone", price: 800.0, quantity: 0)])

store.placeOrder(order: order1)
store.placeOrder(order: order2)

store.displayOrders()



// Ex1:
class Book {
    var title: String
    var author: String
    var ISBN: String
    var isAvailable: Bool
    
    init(title: String, author: String, ISBN: String, isAvailable: Bool = true) {
        self.title = title
        self.author = author
        self.ISBN = ISBN
        self.isAvailable = isAvailable
    }
    
}

class Library {
    private var books: [Book] = []
    
    func addBook(book: Book) {
        books.append(book)
        print("Book \(book.title) has been added.")
    }
    
    func removeBook(ISBN: String) {
        if let index = books.firstIndex(where: {$0.ISBN == ISBN}) {
            books.remove(at: index)
            print("Book ISBN: \(ISBN) has been removed.")
        } else {
            print("No book found with ISBN \(ISBN).")
        }
    }
    
    func displayBooks() {
        if books.isEmpty {
            print("No books available in library.")
        } else {
            print("Books in library:")
            for book in books {
                let availability = book.isAvailable ? "Available" : "Not Available"
                print("- \(book.title) by \(book.author) (ISBN: \(book.ISBN)) - \(availability)")
            }
        }
    }
    
    func borrowBook(ISBN: String) {
        if let book = books.first(where: {$0.ISBN == ISBN}) {
            if book.isAvailable {
                book.isAvailable = false
                print("You have borrowed \(book.title)")
            } else {
                print("The book \(book.title) is currently not available.")
            }
        } else {
            print("Not book found with ISBN \(ISBN)")
        }
    }
    
    func returnBook(ISBN: String) {
        if let book = books.first(where: {$0.ISBN == ISBN}) {
            if !book.isAvailable {
                book.isAvailable = true
                print("You have returned \(book.title). Thank you!")
            } else {
                print("The book \(book.title) was not borrowed.")
            }
        } else {
            print("No book found with ISBN \(ISBN)")
        }
    }
}

let library = Library()

let book1 = Book(title: "1984", author: "George Orwell", ISBN: "1234567890")
let book2 = Book(title: "To Kill a Mockingbird", author: "Harper Lee", ISBN: "0987654321")
let book3 = Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", ISBN: "1122334455")

library.addBook(book: book1)
library.addBook(book: book2)
library.addBook(book: book3)

library.displayBooks()

library.borrowBook(ISBN: "1234567890")
library.borrowBook(ISBN: "1234567890")
library.returnBook(ISBN: "1234567890")
library.returnBook(ISBN: "1234567890")
library.displayBooks()
