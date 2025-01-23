//: [Previous](@previous)

import Foundation


// Ex4:
class Event {
    var handler: (() -> Void)?
    
    func setHandler(_ handler: @escaping () -> Void ) {
        self.handler = handler
    }
    
    func trigger() {
        handler?()
    }
}

let event = Event()
event.setHandler {
    print("Event has been activated.")
}
event.trigger()


// Ex3:
struct Person {
    var name: String
    var age: Int
    
    mutating func configure(_ configuration: (inout Person) -> Void) {
        configuration(&self)
    }
}

var person = Person(name: "John", age: 23)
print("Before configure: \(person)")


/// C2:
//func closures(person: inout Person) {
//    person.name = "DHT"
//    person.age = 22
//}
//person.configure(closures)

person.configure { p in
    p.name = "DHT"
    p.age = 22
}

print("After configure: \(person)")


// Ex2:
func primesUpTo(_ n: Int) -> [Int] {
    
    guard n >= 2 else { return [] }
    
    let isPrime: (Int) -> Bool = { number in
        guard number > 1 else { return false}
        if number == 2 || number == 3 {
            return true
        }
        for i in 2...Int(Double(number).squareRoot()) {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
        
    return (2...n).filter(isPrime)
}

let result = primesUpTo(30)
print(result)



// Ex1:
func filterAndTransform(array: [Int], closures1: (Int) -> (Bool), closures2: (Int) -> (Int)) -> [Int]  {
    let filteredArray = array.filter(closures1)
    
    let transformedArray = filteredArray.map(closures2)
    
    return transformedArray
}

let array = [1, 5, 6, 7, 3, 8, 4, 7]

let isEven: (Int) -> Bool = { $0 % 2 == 0 }

let square: (Int) -> Int = { $0 * $0}

let newArray = filterAndTransform(array: array, closures1: isEven, closures2: square)
print(newArray)
