//: [Previous](@previous)

import Foundation


// Ex6:
class Movie {
    var title: String
    var ageRestriction: Int
    
    init(title: String, ageRestriction: Int) {
        self.title = title
        self.ageRestriction = ageRestriction
    }
}

class CinemaRoom {
    var roomNumber: Int
    var capacity: Int
    private var bookedSeats: Int
    
    init(roomNumber: Int, capacity: Int) {
        self.roomNumber = roomNumber
        self.capacity = capacity
        self.bookedSeats = 0
    }
    
    func hasAvailableSeats() -> Bool {
        return bookedSeats < capacity
    }
    
    func bookSeat() throws {
        guard hasAvailableSeats() else {
            throw CinemaError.roomFull
        }
        bookedSeats += 1
    }
    
    func availableSeats() -> Int {
        return capacity - bookedSeats
    }
}

class ShowTime {
    var movie: Movie
    var room: CinemaRoom
    var time: Date
    
    init(movie: Movie, room: CinemaRoom, time: Date) {
        self.movie = movie
        self.room = room
        self.time = time
    }
}

class Cinema {
    private var movies: [Movie] = []
    private var rooms: [CinemaRoom] = []
    private var showTimes: [ShowTime] = []
    
    func addMovie(movie: Movie) {
        movies.append(movie)
        print("Movie \(movie.title) has been added.")
    }
    
    func addRoom(room: CinemaRoom) {
        rooms.append(room)
        print("Room \(room.roomNumber) has been added.")
    }
    
    func addShowTime(showTime: ShowTime) {
        showTimes.append(showTime)
        print("Show time for \(showTime.movie.title) at \(showTime.time) in room \(showTime.room.roomNumber) has been added.")
    }
    
    func displayMovies() {
        if movies.isEmpty {
            print("No movies available.")
        } else {
            print("Movies currently showing:")
            for movie in movies {
                print("- \(movie.title) (Age restriction: \(movie.ageRestriction)+)")
            }
        }
    }
    
    func displayShowTimes() {
        if showTimes.isEmpty {
            print("No showtimes available.")
        } else {
            print("Showtimes: ")
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            for showTime in showTimes {
                print("- \(showTime.movie.title) at \(formatter.string(from: showTime.time)) in room \(showTime.room.roomNumber)")
            }
        }
    }
    
    func bookTicket(movieTitle: String, time: Date, customerAge: Int) throws {
        guard let showTime = showTimes.first(where: {$0.movie.title == movieTitle && $0.time == time}) else {
            throw CinemaError.showTimeNotFound
        }
        
        guard customerAge >= showTime.movie.ageRestriction else {
            throw CinemaError.ageRestrictionViolation
        }
        
        try showTime.room.bookSeat()
        print("Ticket booked for \(movieTitle) at \(time) in room \(showTime.room.roomNumber).")
        
    }
}

enum CinemaError: Error {
    case roomFull
    case ageRestrictionViolation
    case showTimeNotFound
}

let cinema = Cinema()

let movie1 = Movie(title: "Avengers: Endgame", ageRestriction: 13)
let movie2 = Movie(title: "The Lion King", ageRestriction: 0)
let movie3 = Movie(title: "Joker", ageRestriction: 18)

cinema.addMovie(movie: movie1)
cinema.addMovie(movie: movie2)
cinema.addMovie(movie: movie3)

let room1 = CinemaRoom(roomNumber: 1, capacity: 100)
let room2 = CinemaRoom(roomNumber: 2, capacity: 50)

cinema.addRoom(room: room1)
cinema.addRoom(room: room2)

let showTime1 = ShowTime(movie: movie1, room: room1, time: Date())
let showTime2 = ShowTime(movie: movie2, room: room2, time: Date().addingTimeInterval(3600))

cinema.addShowTime(showTime: showTime1)
cinema.addShowTime(showTime: showTime2)

// Hiển thị danh sách phim và lịch chiếu
cinema.displayMovies()
cinema.displayShowTimes()

// Thử nghiệm đặt vé
do {
    try cinema.bookTicket(movieTitle: "Avengers: Endgame", time: showTime1.time, customerAge: 15)
    try cinema.bookTicket(movieTitle: "Joker", time: showTime2.time, customerAge: 17) // Sẽ gây lỗi do không đủ tuổi
} catch CinemaError.roomFull {
    print("Cannot book ticket: Room is full.")
} catch CinemaError.ageRestrictionViolation {
    print("Cannot book ticket: Age restriction not met.")
} catch CinemaError.showTimeNotFound {
    print("Cannot book ticket: Showtime not found.")
} catch {
    print("An unexpected error occurred: \(error).")
}


// Ex5:
class AccountDebit {
    var accountNumber: String
    var accountHolder: String
    private(set) var balance: Double
    
    init(accountNumber: String, accountHolder: String, balance: Double) {
        self.accountNumber = accountNumber
        self.accountHolder = accountHolder
        self.balance = balance
    }
    
    func deposit(amount: Double) {
        guard amount > 0 else {
            print("Invalid deposit amount")
            return
        }
        balance += amount
        print("\(amount) has been deposited into account \(accountNumber). New balance: \(balance)")
    }
    
    func withdraw(amount: Double) -> Bool {
        guard amount > 0 else {
            print("Invalid withdraw amount")
            return false
        }
        
        guard amount <= balance else {
            print("Insufficient balance in account \(accountNumber)")
            return false
        }
        
        balance -= amount
        print("\(amount) has been withdrawn from account \(accountNumber). New balance: \(balance)")
        
        return true
    }
}

class Bank {
    private var accounts: [AccountDebit] = []
    
    func addAccount(account: AccountDebit) {
        accounts.append(account)
        print("Account \(account.accountNumber) has been added.")
    }
    
    func removeAccount(byId accountNumber: String) {
        if let index = accounts.firstIndex(where: {$0.accountNumber == accountNumber}) {
            accounts.remove(at: index)
            print("Successfully removed AccountNumber: \(accountNumber)")
        } else {
            print("Id not found ")
        }
    }
    
    func findAccount(byAccountNumber accountNumber: String) -> AccountDebit? {
        return accounts.first(where: {$0.accountNumber == accountNumber})
    }
    
    func transfer(from senderAccountNumber: String, to receiverAccountNumber: String, amount: Double) {
        guard let sender = findAccount(byAccountNumber: senderAccountNumber) else {
            print("Sender account \(senderAccountNumber) not found.")
            return
        }
        
        guard let receiver = findAccount(byAccountNumber: receiverAccountNumber) else {
            print("Receiver account \(receiverAccountNumber) not found.")
            return
        }
        
        if sender.withdraw(amount: amount) {
            receiver.deposit(amount: amount)
            print("Successfully transferred \(amount) from account \(senderAccountNumber) to account \(receiverAccountNumber).")
        }
    }
    
    func displayAllAccounts() {
        if accounts.isEmpty {
            print("No accounts in the system.")
        } else {
            print("List of Accounts:")
            for account in accounts {
                print("Account Number: \(account.accountNumber), Holder: \(account.accountHolder), Balance: \(account.balance)")
            }
        }
    }
}

let bank = Bank()

let account1 = AccountDebit(accountNumber: "123456", accountHolder: "Nguyen Van A", balance: 1000)
let account2 = AccountDebit(accountNumber: "654321", accountHolder: "Tran Thi B", balance: 2000)
let account3 = AccountDebit(accountNumber: "111222", accountHolder: "Le Van C", balance: 1500)
let account4 = AccountDebit(accountNumber: "102022", accountHolder: "Hoang Thanh", balance: 9999)

bank.addAccount(account: account1)
bank.addAccount(account: account2)
bank.addAccount(account: account3)
bank.addAccount(account: account4)

print("\nInitial list of accounts:")
bank.displayAllAccounts()
bank.removeAccount(byId: "1020022")

print("\nPerforming a transfer:")
bank.transfer(from: "123456", to: "654321", amount: 500)

print("\nList of accounts after transfer:")
bank.displayAllAccounts()


// Ex4:
class Employee {
    var id: Int
    var name: String
    var dateOfBirth: Int
    var position: String
    
    init(id: Int, name: String, dateOfBirth: Int, position: String) {
        self.id = id
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.position = position
    }
    
    func displayInfo() {
        print("ID: \(id), Name: \(name), Age: \(dateOfBirth), Position: \(position)")
    }
}

class EmployeeManager {
    var employees: [Employee] = []
    
    func addEmployee(employee: Employee) {
        employees.append(employee)
        print("Employee \(employee.name) has been added.")
    }
    
    func removeEmployee(byId id: Int) {
        if let index = employees.firstIndex(where: {$0.id == id}) {
            let removedEmployee = employees.remove(at: index)
            print("Employee \(removedEmployee.name) has been removed")
        } else {
            print("Employee with ID \(id) not found")
        }
    }
    
    func displayAllEmployees() {
        if employees.isEmpty {
            print("No employees in this system")
        } else {
            print("List of employees:")
            for employee in employees {
                employee.displayInfo()
            }
        }
    }
    
}

let manager = EmployeeManager()

let employee1 = Employee(id: 1, name: "Nguyen Van A", dateOfBirth: 30, position: "Developer")
let employee2 = Employee(id: 2, name: "Tran Thi B", dateOfBirth: 25, position: "Designer")
let employee3 = Employee(id: 3, name: "Le Van C", dateOfBirth: 28, position: "Tester")

manager.addEmployee(employee: employee1)
manager.addEmployee(employee: employee2)
manager.addEmployee(employee: employee3)

print("\nAfter adding employees:")
manager.displayAllEmployees()

manager.removeEmployee(byId: 5)

print("\nAfter removing an employee:")
manager.displayAllEmployees()


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
cart.addItem(name: "Iphone 16", price: 1200)



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
class BankAccount {
    var balance: Int = 0 {
        didSet {
            if balance < 0 {
                balance = oldValue
                print("Error")
            }
        }
    }
    
    init(balance: Int) {
        self.balance = balance
    }
    
    func deposit(amount: Int) {
        if amount > 0 {
            balance += amount
        } else {
            print("Error! \nAmount < 0")
        }
    }
    
    func withDraw(amount: Int) {
        balance -= amount
    }
}

var accountEx1User1 = BankAccount(balance: 1200)
accountEx1User1.deposit(amount: 300)
print(accountEx1User1.balance)
accountEx1User1.withDraw(amount: 2000)
print(accountEx1User1.balance)
