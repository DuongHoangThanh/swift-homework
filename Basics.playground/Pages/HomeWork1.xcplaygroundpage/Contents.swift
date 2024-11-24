import UIKit

// Ex 1:
print("---------------")
var dictNested: [String: [String: Int]]
func sumNestedDictionary(dict: [String: [String: Int]]) -> Int {
    var sum = 0
    //    #Solution 1
    //    for i in dict {
    //        for k in i.value {
    //            sum += k.value
    //        }
    //    }
    
    for (_ , innerDict) in dict {
        for (_ , value) in innerDict {
            sum += value
        }
    }
    
    return sum
}
dictNested = ["Math": ["score": 9], "English": ["score": 9], "Literature": ["score": 7]]
let sum = sumNestedDictionary(dict: dictNested)
print(sum)


// Ex 2:
print("---------------")
func getValue(forKey: String, dict: [String: Int]) {
    guard let value = dict[forKey] else {
        print("Key not found")
        return
    }
    print(value)
}
let dict1 = ["Math": 9, "English": 7, "Literature": 6]
getValue(forKey: "Math", dict: dict1)


// Ex3
print("---------------")
func validateUser(dict: [String: Any]) -> String {
    guard let username = dict["username"],
          let password = dict["password"],
          let age = dict["age"] as? Int, // age is still of type Any
          age >= 18
    else {
        return "The user is not valid or age is less than 18"
    }
    return "Username: \(username) - Password: \(password) - Age: \(age)"
}
let dict2: [String: Any] = ["username": "HT", "password": "123", "age": 21]
print(validateUser(dict: dict2))

// Ex4
print("---------------")
func isSubset2(setA: Set<Int>, setB: Set<Int>) -> Bool {
    for element in setA {
        if !setB.contains(element) {
            false
        }
    }
    return true
}
let setA: Set<Int> = [1, 2, 4, 6, 7, 9]
let setB: Set<Int> = [2, 4, 6]
let result = isSubset2(setA: setA, setB: setB)
print(result)


// Ex5
print("---------------")
var arrayDict = [
    ["a": 1, "b": 2, "c": 3],
    ["d": 2, "e": 1, "f": 1]
]
func groupByValue(arr: [[String: Int]]) -> [Int: [String]] {
    var result: [Int: [String]] = [:]
    
    for dict in arr {
        for (key, value) in dict {
            if result[value] != nil {
                result[value]?.append(key)
            } else {
                result[value] = [key]
            }
        }
    }
    
    return result
}
print(groupByValue(arr: arrayDict))



// Ex6
print("---------------")
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
print("---------------")
func removeInvalidKeys(dict: [String: Int]) -> [String: Int] {
    var result: [String: Int] = [:]
    for (key, value) in dict {
        guard key.count >= 3, key.count <= 10 else {
            continue
        }
        result[key] = value
    }
    
    return result
}
 
print(removeInvalidKeys(dict: ["hkasdf": 123, "as": 213, "dsd": 22]))
