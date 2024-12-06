//: [Previous](@previous)

import Foundation

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

// Ex2:
func analyzeSentence(sentence: String?) -> (wordCount: Int, averageWordLength: Double) {
    
    return (0,0)
}
