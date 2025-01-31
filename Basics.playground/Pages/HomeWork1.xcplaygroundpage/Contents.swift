//: [Previous](@previous)

import Foundation


// Ex1
func sumNestedDictionary(dict: [String: [String: Int]]) -> Int {
    var total = 0
    for (_ , innnerDict) in dict {
        for (_ , value) in innnerDict {
            total += value
        }
    }
    return total
}
let resultSum = sumNestedDictionary(dict: ["Math": ["Score": 9], "English": ["Score": 9], "Literature": ["Score": 7]])
print(resultSum)


// Ex2
print("--------------")
func getValue(forKey: String, dict: [String: Int]) {
    guard let value = dict[forKey] else {
        print("Key not found!")
        return
    }
    print("With Key = \(forKey) => Value = \(value)")
}
getValue(forKey: "Literature", dict: ["Math": 9, "English": 9])


// Ex3
print("--------------")
func validateUser(dict: [String: Any]) -> String {
    // dict[] = is a value optional
    guard (dict["username"] != nil),
          (dict["password"] != nil),
          let age = dict["age"] as? Int,
          age > 18 else {
        return "Error"
    }
    return "Oke"
}
let resultValidateUser = validateUser(dict: ["username": "DHT", "password": "123", "age": 21])
print(resultValidateUser)


// Ex4
print("--------------")
func isSubSet2(setA: Set<Int>, setB: Set<Int>) -> Bool {
    for element in setA {
        guard setB.contains(element) else {
            return false
        }
    }
    return true
}

func isSubSet(setA: Set<Int>, setB: Set<Int>) -> Bool {
    return setA.isSubset(of: setB)
}
let resultIsSubSet = isSubSet(setA: [1, 3, 5], setB: [4, 6, 1, 3, 5])
let resultIsSubSet2 = isSubSet2(setA: [1, 3, 5, 8], setB: [4, 6, 1, 3, 5])
print(resultIsSubSet2)


// Ex5
print("--------------")
func groupByValue(dict: [String: Int]) -> [Int: [String]] {
    var result: [Int: [String]] = [:]
    for (key, value) in dict {
        if result[value] != nil {
            result[value]?.append(key)
        } else {
            result[value] = [key]
        }
    }
    return result
}
let resultGroupValue = groupByValue(dict: ["a": 1, "b": 2, "c": 1, "d": 2, "e": 3])
print(resultGroupValue)


// Ex6
print("--------------")
func smallestSubset(set: Set<Int>, target: Int) -> Set<Int>? {
    let sortedArr = set.sorted(by: >)  // Sắp xếp các phần tử theo thứ tự giảm dần.
    var bestSubset: Set<Int>? = nil
    var minCount = Int.max // Biến để theo dõi số lượng phần tử ít nhất.
    print(minCount)
    
    func findSubset(curSubset: Set<Int>, curIndex: Int, curSum: Int) {
        // Điều kiện dừng: nếu tổng >= target, hoặc đã duyệt hết các phần tử
        if curSum >= target {
            if curSubset.count < minCount {  // Nếu tập con có ít phần tử hơn tập con tốt nhất hiện tại
                bestSubset = curSubset
                minCount = curSubset.count
            }
            return
        }
        if curIndex >= sortedArr.count {
            return
        }

        // Đệ quy bỏ qua phần tử hiện tại
        findSubset(curSubset: curSubset, curIndex: curIndex + 1, curSum: curSum)
        
        // Đệ quy thêm phần tử hiện tại vào tập con
        findSubset(curSubset: curSubset.union([sortedArr[curIndex]]), curIndex: curIndex + 1, curSum: curSum + sortedArr[curIndex])
    }
    
    findSubset(curSubset: Set<Int>(), curIndex: 0, curSum: 0)
    return bestSubset
}

let testSet: Set<Int> = [1, 2, 3, 4, 5]
let target = 7
if let result = smallestSubset(set: testSet, target: target) {
    print(result)  // Output: [5, 2] hoặc [4, 3]
} else {
    print("Không tìm thấy tập hợp con thỏa mãn.")
}


// Ex7
print("--------------")
func removeInvalidKeys(dict: [String: Int]) -> [String: Int] {
    var result: [String: Int] = [:]
    for (key, value) in dict {
        guard (key.count >= 3), (key.count <= 10) else {
            continue
        }
        result[key] = value
    }
    return result
}
let resultRemoveInvalidKeys = removeInvalidKeys(dict: ["Math": 9, "as": 7, "asdasdj": 12])
print(resultRemoveInvalidKeys)




// Summary //


// Constants and Variables:
let constantName:String = "Duong Hoang Thanh"
// constantName = "Hoang Thanh" : Values cannot change after being assigned
var variableName:Int = 123
variableName = 1306


// Operator:
let sum = 10 + 5
let isEqual = 5 == 5

let isLoggedIn = true
let isPermission = false
let canAccess = isLoggedIn && isPermission


// Overview 18/12/2024
// Array:
var numbers = [1, 2]
let check = numbers.isEmpty // return bool
let count = numbers.count // return Int,
let first = numbers.first
let last = numbers.last
numbers.append(2) // add a new element at the end of the array
numbers.append(contentsOf: [3, 4])
numbers.insert(100, at: 3) // insert a new element at the specified position
numbers.contains(2)
numbers.sort(by: >)
numbers.sorted(by: >)
numbers.reverse()
let numbersNew = numbers.map({ $0*2 })
numbers.filter({ $0>2 })
numbers.reduce(0, +)


// Set:
var sets: Set<Int> = [1, 2, 3]
var sets2: Set<Int> = [3, 4, 5]
sets.insert(123)
sets.update(with: 6)

var sets3 = sets.union(sets2) // return a new set with the elements of both set
var sets4 = sets.intersection(sets2) // return a new set with the elements that are common to both set


// Dictionary:
var dicts: [String: Any] = ["username": "DHT", "password": 123, "age": 21]
dicts.removeValue(forKey: "age")
let checkDict = dicts.contains(where: {(key, value) in return key.count > 2})
print(checkDict)
let newDict = dicts.mapValues({
    (value) in return "value: \(value)"
})
print(newDict)


// Overview Homework
func sumNestedDictionary2(dict: [String: [String: Int]]) -> Int {
    var sum = 0
    for item in dict {
        for (key, value) in item.value {
            sum += value
        }
    }
    
    return sum
}

var sum123 = sumNestedDictionary2(dict: ["Swift4": ["Thanh": 9, "Hau": 8, "Son": 10], "Objective-c": ["Thanh": 7, "Hau": 6, "Son": 5]])
print(sum123)

//
func getValue2(forKey: String, dict: [String: Int]) -> String {
    guard let value = dict["\(forKey)"] else { return "Error!" }
    return String(value)
}
var valueDict = getValue2(forKey: "chanh", dict: ["thanh": 12, "chanh": 23])

func validateUser2(dict: [String: Any]) -> String {
    guard (dict["username"] != nil),
          (dict["password"] != nil),
          let age = dict["age"],
          age as! Int > 18
    else {
        return "Error"
    }
    
    return "Success!"
}
validateUser2(dict: ["username": "DHT", "password": "123", "age": 12])

//
func isSubset2(setA: Set<Int>, setB: Set<Int>) -> Bool {
    return setA.isSubset(of: setB)
}
isSubset2(setA: [1, 5, 6], setB: [1, 5, 6, 2, 7])

//
func groupByValue2(arr: [[String: Int]]) -> [Int: [String]] {
    var result: [Int: [String]] = [:]
    for item in arr {
        for (key, value) in item {
            if var keyResult = result[value] {
                result[value]?.append(key)
            } else {
                result[value] = [key]
            }
        }
    }
    return result
}

var result123 = groupByValue2(arr: [["thanh": 1, "chanh": 1, "Tinh": 2, "Sang": 3, "Duyen": 2], ["Toan": 10, "Van": 9, "Anh": 9]])
print(result123)

//
func findSmallestSubset(numbers: [Int], target: Int) -> [Int]? {
    // Bước 1: Sắp xếp mảng theo thứ tự giảm dần
    let sortedNumbers = numbers.sorted(by: >)
    
    // Biến lưu kết quả tốt nhất (ít phần tử nhất)
    var bestSubset: [Int]? = nil
    
    // Hàm đệ quy để tìm tập hợp con
    func backtrack(currentSubset: [Int], currentIndex: Int, currentSum: Int) {
        // Nếu tổng hiện tại >= target
        if currentSum >= target {
            // Cập nhật kết quả nếu tốt hơn
            if bestSubset == nil || currentSubset.count < bestSubset!.count {
                bestSubset = currentSubset
            }
            return
        }
        
        // Duyệt qua các phần tử còn lại trong mảng
        for i in currentIndex..<sortedNumbers.count {
            // Thêm phần tử vào tập hợp con hiện tại
            let nextNumber = sortedNumbers[i]
            backtrack(
                currentSubset: currentSubset + [nextNumber],
                currentIndex: i + 1,
                currentSum: currentSum + nextNumber
            )
        }
    }
    
    // Bắt đầu đệ quy
    backtrack(currentSubset: [], currentIndex: 0, currentSum: 0)
    
    return bestSubset
}

// Ví dụ sử dụng
let numbers3 = [1, 2, 3, 4]
let target3 = 5
if let result = findSmallestSubset(numbers: numbers3, target: target3) {
    print("Kết quả: \(result)")
} else {
    print("Không tìm thấy tập hợp con nào thoả mãn.")
}

print("======")

//
func removeInvalidKeys2(dict: [String: Int]) -> [String: Int] {
    var result: [String: Int] = [:]
    
    for (key, value) in dict {
        guard key.count > 3, key.count < 10 else {
            continue
        }
        result[key] = value
    }

    return result
}
removeInvalidKeys2(dict: ["thanh": 9, "NT": 0, "Chanh": 12])



