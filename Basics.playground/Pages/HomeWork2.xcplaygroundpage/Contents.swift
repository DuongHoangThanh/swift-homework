//: [Previous](@previous)

import Foundation


// Ex16:

func findCommonElement2(_ data1: [[[Int?]?]?]?,  _ data2: [[[Int?]?]?]?) -> Int? {
    var elements = Set<Int>()
    
    data1?.forEach { outerData1 in
        outerData1?.forEach { innerData1 in
            innerData1?.forEach { value in
                if let validValue = value {
                    elements.insert(validValue)
                }
            }
        }
    }
    
    for outerData in data2 ?? [] {
        for innerData in outerData ?? [] {
            for value in innerData ?? [] {
                if let validValue = value, elements.contains(validValue) {
                    return validValue
                }
            }
        }
    }
    
    return nil
}
print("hello")
print(findCommonElement2([[[1, 4, 3, nil, 7, 9, 1, 3]]], [[[5, 5, 5, 5, nil, 7]]]))



func findCommonElement(_ data1: [[[Int?]?]?]?, _ data2: [[[Int?]?]?]?) -> Int? {
    
    var elementsSet = Set<Int>()
    
    data1?.forEach { outerArray in
        outerArray?.forEach { innerArray in
            innerArray?.forEach { value in
                if let inValue = value {
                    elementsSet.insert(inValue)
                }
            }
        }
    }
    
    for outerArray in data2 ?? [] {
            for innerArray in outerArray ?? [] {
                for value in innerArray ?? [] {
                    if let intValue = value, elementsSet.contains(intValue) {
                        return intValue
                    }
                }
            }
        }
    
    return nil
}
 
// Ex15:
func findFirstGreaterThan(_ data: [[[Int?]?]?]?, threshold: Int) -> Int? {
    var validArray: [Int] = []
     
    data?.forEach({ data1 in
        data1?.forEach({ data2 in
            data2?.forEach({ value in
                if let unwrappedValue = value, unwrappedValue > threshold {
                    validArray.append(unwrappedValue)
                }
            })
        })
    })
    
    return validArray.isEmpty ? nil : validArray.min()
}
print(findFirstGreaterThan([[[1, 4, nil, 3, 6, 7]]], threshold: 3))


// Ex14:
func nestedOptionalCount(_ data: [[[Int?]?]?]?, minvalue: Int) -> Int? {
    var result = 0
    
    data?.forEach({ data1 in
        data1?.forEach({ data2 in
            data2?.forEach({ value in
                if let unwrappedValue = value, unwrappedValue > minvalue {
                    result += 1
                }
            })
        })
    })
    
    return result != 0 ? result : nil
}

print(nestedOptionalCount([[[1, 2, 3, nil, nil], [4, 5, 6]], [[7, 8, 9], [10, 11, 12]]], minvalue: 4))

// Ex13:
func conditionalAverage(_ data: [String: [Int?]?]?, condition: (Int) -> Bool) -> Double? {
    var validValues: [Int] = []
    
    data?.forEach({ (key, array) in
        array?.forEach({ value in
            if let unwrappedValue = value, condition(unwrappedValue) {
                validValues.append(unwrappedValue)
            }
        })
    })
        
    return validValues.isEmpty ? nil : Double(validValues.reduce(0, +)) / Double(validValues.count)
}
func isPerfectSquare(n: Int) -> Bool {
    guard n >= 0 else {
        return false
    }
    var root = Int(Double(n).squareRoot())
    return root * root == n
}
let data: [String: [Int?]?] = [
    "group1": [1, 4, nil, 8, 9],
    "group2": nil,
    "group3": [16, 25, nil, 3, 2]
]

print(conditionalAverage(["thanh": [1, 2, 4, 9, nil]], condition: isPerfectSquare))

// Ex12:
func sortOptionalArray(_ array: [Int?]?) -> [Int?] {

    var arrrayNil: [Int?] = []
    
    guard let unwrappedArray = array else {
        return []
    }
    
    var arrangedArray = unwrappedArray.compactMap({ item in
        if item == nil {
            arrrayNil.append(item)
        }
        return item
    })
    
    arrangedArray.sort(by: >)
    
    return arrangedArray + arrrayNil
}

print(sortOptionalArray([1, 2, 3, nil, 5, 6, nil, 8, nil, 10]))


// Ex11:
func extractNonNilElements(_ data: [String: [[Int?]?]?]?) -> [Int] {
    var result: [Int] = []
    
    data?.values.forEach({ nestedArray in
        nestedArray?.forEach({ innerArray in
            innerArray?.forEach({ value in
                if let validValue = value {
                    result.append(validValue)
                }
            })
        })
    })
    
    return result
}

func extractNonNilElements2(_ data: [String: [[Int?]?]?]?) -> [Int] {
    var result: [Int] = []
    
    guard let unwrappedData = data else {
        return []
    }
     
    for (key, value) in unwrappedData {
        if let array = value?.compactMap({ $0 }) {
            for subArray in array {
                for i in subArray.compactMap({ $0 }) {
                    result.append(i)
                }
            }
        }
    }
    
    return result
}

let data2 = ["apple": [[1, 2, nil, 4], [5, 6, nil, 7]], "android": [[nil, 1, 2], [3, nil, 4]]]
print(extractNonNilElements2(data2))


// Ex10:
func sumUniqueValues(_ sets: [Set<Int?>?]) -> Int? {
    var uniqueValue = Set<Int>()
    
    for i in sets {
        if let set = i?.compactMap({ $0 }) {
            for j in set {
                uniqueValue.insert(j)
            }
        } else {
            return nil
        }
    }
    return uniqueValue.isEmpty ? nil : uniqueValue.reduce(0, +)
}

print(sumUniqueValues([[1, 5, 6, 4, 1, 1], [2, 5, 7]]) ?? 99999)


// Ex9:
func findKeysWithMaxValue(in dict: [String: Set<Int?>?]) -> [String] {
    var maxKeys: [String] = []
    var globalMax: Int? = nil
    
    for (key, optionalSet) in dict {
        if let set = optionalSet?.compactMap({ $0 }) {
            if let localMax = set.max() {
                if globalMax == nil  {
//                    maxKeys = [key]
                    maxKeys.append(key)
                    globalMax = localMax
                } else if localMax == globalMax || localMax > globalMax! {
                    maxKeys.append(key)
                }
            }
        }
    }
    return maxKeys
}

print(findKeysWithMaxValue(in: ["thanh": [7, nil, 8, 9], "chanh": [6, 7, nil, 9], "tinh": [5, 6, nil, 8]]))


// Ex8:
func averageNonNilElements(in array: [Double?]?) -> Double? {
    guard let unwrappedArray = array else {
        return nil
    }
    
    var sum = 0.0
    let filteredArray = unwrappedArray.compactMap { $0 }
    for i in filteredArray {
        sum += i
    }
    
    return sum / Double(filteredArray.count)
}
print(averageNonNilElements(in: [1, 2, 3, nil]))

func averageOfNonNilElements2(_ array: [Double?]?) -> Double? {
    var result = 0.0
    
    if let newArray = array?.compactMap({ $0 }) {
        result = (newArray.reduce(0.0, +)) / Double((newArray.count))
    }
    
    return result
}

print(averageOfNonNilElements2([1, 2, 3, nil, nil, 4, 7]))

// Ex7:
func findConsecutivePair(in array: [Int?]?) -> (Int, Int)? {
    
    guard let unwrappedArray = array else {
        return nil
    }
    
    for i in 0..<unwrappedArray.count - 1 {
        if let first = unwrappedArray[i], let second = unwrappedArray[i+1] {
            return (first, second)
        }
    }
    
    return nil
}

print(findConsecutivePair(in: [1, nil, nil, nil, 1, nil, 3, 2, nil, 2, 4]))

// Ex6:
func removeNilValues(from matrix: [[Int?]?]?) -> [[Int]]? {
    
    guard let unwrappedMatrix = matrix else {
        return nil
    }
    
    let filteredMatrix = unwrappedMatrix.compactMap { $0 }
    print(filteredMatrix)
    let cleanedMatrix = filteredMatrix.map { row in
        row.compactMap { $0 }
    }.filter { !$0.isEmpty }
    
    return cleanedMatrix.isEmpty ? [] : cleanedMatrix
}

let matrix3: [[Int?]?]? = [
    nil,
    [nil, nil],
    nil
]
print(removeNilValues(from: matrix3))


// Ex5:
func findFurthestNonNil(_ array: [Int?]?, reference: Int) -> Int? {
    var result: Int?
    guard let arrayUnwrapped = array else {
        return nil
    }
    
    for item in arrayUnwrapped {
        guard let itemUnwrapped = item else {
            continue
        }
        if let resultUnwrapped = result {
            if abs(itemUnwrapped - reference) > abs(resultUnwrapped - reference) {
                result = itemUnwrapped
            }
        } else {
            result = itemUnwrapped
        }
    }
    return result
}

print(findFurthestNonNil([nil, nil, nil, nil, nil, nil, nil], reference: 9))

// Ex4:
func filterOutEventNumers(_ numbers: [Int?]) -> [Int] {
    var result:[Int] = []
    for item in numbers {
        if let itemUnwrapped = item {
            if itemUnwrapped % 2 != 0 {
                result.append(itemUnwrapped)
            }
        }
    }
    return result
}
print(filterOutEventNumers([1, 2, 4, nil, 3, nil]))


// Ex3:
func analyzeSentence(sentence: String?) -> (wordCount: Int, averageWordLength: Double) {
    var wordCount = 0
    var sumCharacter = 0.0
    if let sentenceUnwrapped = sentence {
        var wordList = sentenceUnwrapped.split(separator: " ")
        wordCount = wordList.count
        if wordCount == 0 {
            return (0, 0)
        }
        for i in wordList {
            sumCharacter += Double(i.count)
        }
    } else {
        return (0, 0)
    }
//    var averageWord = ((sumCharacter/Double(wordCount) * 100).rounded()) / 100
    var averageWord = sumCharacter/Double(wordCount)
    return (wordCount, averageWord)
}
print(analyzeSentence(sentence: "    hoangthanh hello      "))


// Ex2:
func sumNonConsecutive2(numbers: [Int?]) -> Int {
    var result = 0
    var itemPre: Int?
    for item in numbers {
        if let itemUnwrapped = item {
            if itemUnwrapped != itemPre {
                result += itemUnwrapped
                itemPre = itemUnwrapped
            } else {
                itemPre = itemUnwrapped
            }
            
        } else {
            itemPre = item
        }
    }
    return result
}
print(sumNonConsecutive2(numbers: [1, 1, 2, nil, 2, 2, 1]))


func sumNonConsecutive(numbers: [Int?]) -> Int {
    var sum = 0
    var temp: Int?
    for i in numbers {
        if let value = i {
            if let valuePre = temp {
                if value != valuePre {
                    sum += value
                    temp = value
                }
            } else {
                sum += value
                temp = value
            }
        } else {
            temp = i
        }
    }
    
    return sum
}
print(sumNonConsecutive(numbers: [1, 1, 4, nil, 4, 1]))


// Ex1:
func findClosest2(to value: Int, in numbers: [Int?]) -> Int? {
    var closest: Int?
    var smallestDiff: Int?
    for item in numbers {
        if let num = item { // get the value of numbers (because item type is optional(Int)
            let diff = abs(num - value)
            if let smallestDiffCur = smallestDiff {
                if diff < smallestDiffCur { // get
                    smallestDiff = diff
                    closest = num
                }
            } else {
                smallestDiff = diff
                closest = num
            }
        }
    }
    return closest
}

func findClosest(to value: Int, in numbers: [Int?]) -> Int? {
    let validNumbers = numbers.compactMap{ $0 }
    guard !validNumbers.isEmpty else {
        return nil
    }
    return validNumbers.min(by: {abs($0 - value) < abs($1 - value)})
}

let numbers: [Int?] = [3, nil, 10, 4, nil]
let target = 6
if let closest = findClosest(to: target, in: numbers) {
    print("The value is closest to \(target) is \(closest)")
} else {
    print("There are no valid values in the array")
}

// OVERVIEW
print("======== Overview ========")
class Person {
    var name: String?
    var address: Address?
}

class Address {
    var city: String?
    var zipCode: Int?
}

let person = Person()
person.address = Address()
person.address = nil
person.address?.city = "Da Nang"

if let city = person.address?.city {
    print("Hello \(city)")
} else {
    print("error!")
}

class Caculator {
    func add(a: Int, b: Int) -> Int {
        return a + b
    }
}

let caculator: Caculator? = Caculator()
let result = caculator?.add(a: 1, b: 2)
print(type(of: result))

if let unwrapResult = result {
    print("Result: \(unwrapResult)")
}

class Company {
    var ceo: Person?
}

let company = Company()
company.ceo = Person()
company.ceo?.address = Address()
company.ceo?.address?.city = "Da Nang"

let optTest1: Optional<Int> = 21
print(optTest1)
print(optTest1 ?? 0)

