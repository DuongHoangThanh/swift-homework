//: [Previous](@previous)

import Foundation

// Ex1:
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

// Ex1.2
func findClosest2(to value: Int, in numbers: [Int?]) -> Int? {
    var closest: Int?
    var smallestDiff: Int?
    
    for item in numbers {
        if let num = item { // use optional binding to get value from numbes
            let diff = abs(num - value)
            if let smallestDiffcur = smallestDiff { // use optional binding to extract the value
                if diff < smallestDiffcur {
                    closest = num
                    smallestDiff = diff
                }
            } else {
                closest = num
                smallestDiff = diff
            }
        }
    }
    
    return closest
}

