//: [Previous](@previous)

import Foundation

class NetworkManager {
    var url: String
    init(_ url: String) {
        self.url = url
    }
    
    func fetchData(completion:  (String) -> Void) {
        sleep(1)
        
        completion("Data from url: \(self.url)")
    }
}

var manager: NetworkManager? = NetworkManager("https://revme.com/login")
manager?.fetchData(completion: {
    (data) in
    print(data)
})


class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Company {
    var employee: Person? // Tham chiếu yếu tới đối tượng `Person`
}

var person1: Person? = Person(name: "Alice")
var company = Company()

company.employee = person1  // `employee` giữ tham chiếu yếu tới `person1`
person1 = nil               // Đối tượng `Person` được giải phóng
company.employee
print(company.employee)



func fetchData(completion: (String) -> Void) {
    print("Load data from Server ... ")
    sleep(1)
    var data = "Data from server"
    completion(data)
}

fetchData { (data) in
    let handled = "Handled data: \(data)"
    print(handled)
}



func makeMoney() -> () -> Int {
    var money = 0
    return {
        money += 1
        return money
    }
}

func add(a: Int, b: Int) -> Int {
    return a + b
}

var test = makeMoney()
print(type(of: test))
print(type(of: add(a: 1, b: 2)))
test()
test()


/// Example of implementation closure

/// Manual Array 1:
class MyArray {
    var array = Array<Int>()
    
    init(_ array: [Int] = Array<Int>()) {
        self.array = array
    }
    
    func sortTest(by closures: (Int, Int) -> Bool) {
        // Buble Sort implementation
        for i in 0..<array.count {
            for j in 0..<array.count - i - 1 {
                if closures(array[j + 1], array[j]) {
                    // Swap elements if closure returns true
                    let temp = array[j]
                    array[j] = array[j + 1]
                    array[j + 1] = temp
                }
            }
        }
    }
}

var arr = MyArray([1, 3, 5, 2, 4])
arr.sortTest { (a: Int, b: Int) in
    return a > b
}
print(arr.array)



/// Manual Array 2:
extension Array {
    mutating func manualSort(by areInIncreasingOrder: (Element, Element) -> Bool) {
        guard count > 1 else { return } // Nếu mảng có 0 hoặc 1 phần tử thì không cần sắp xếp
        
        for i in 0..<count - 1 {
            for j in 0..<count - i - 1 {
                // So sánh hai phần tử bằng closure
                if !areInIncreasingOrder(self[j], self[j + 1]) {
                    // Hoán đổi nếu thứ tự không đúng - sử dụng 1 trong 2 cách sau
                    //swapAt(j, j + 1)
                    
                    let temp = self[j]
                    self[j] = self[j + 1]
                    self[j + 1] = temp
                }
            }
        }
    }
    
    func manualMap<T>(_ transform: (Element) -> T) -> [T] {
        var result = [T]()
        for element in self {
            result.append(transform(element))
        }
        return result
    }
    
    func manualCompactMap<T>(_ transform: (Element) -> T?) -> [T] {
        var result = [T]()
        for element in self {
            if let value = transform(element) {
                result.append(value)
            }
        }
        return result
    }
    
    func manualFilter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result = [Element]()
        for element in self {
            if isIncluded(element) {
                result.append(element)
            }
        }
        return result
    }
    
    func manualReduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var result = initialResult
        for element in self {
            result = nextPartialResult(result, element)
        }
        return result
    }
    
    func manualForEach(_ body: (Element) -> Void) {
        for element in self {
            body(element)
        }
    }
    
}

extension Array where Element: Comparable {
    func manualMin() -> Element? {
        guard !isEmpty else { return nil }
        var minimum = self[0]
        for element in self {
            if element < minimum {
                minimum = element
            }
        }
        return minimum
    }
    
    func manualMax() -> Element? {
        guard !isEmpty else { return nil }
        var maximum = self[0]
        for element in self {
            if element > maximum {
                maximum = element
            }
        }
        return maximum
    }
}

extension Array where Element: Equatable {
    func manualContains(_ element: Element) -> Bool {
        for item in self {
            if item == element {
                return true
            }
        }
        return false
    }
}



