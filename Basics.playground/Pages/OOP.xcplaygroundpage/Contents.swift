//: [Previous](@previous)

import Foundation

class Animal {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class Cat: Animal {
    var isFly: Bool
    init(isFly: Bool, name: String, age: Int) {
        self.isFly = isFly
        super.init(name: name, age: age)
    }
}

var cat = Cat(isFly: true, name: "hello", age: 12)
print(cat.age)

protocol Vehicle {
    var speed: Int { get set }
    func start()
    func stop()
}

protocol Run {
    var speed: Int { get set }
}

class Bicycle: Vehicle, Run {
    var speed: Int = 0
    
    func start() {
        print("Start")
    }
    
    func stop() {
        print("Stop")
    }
}




