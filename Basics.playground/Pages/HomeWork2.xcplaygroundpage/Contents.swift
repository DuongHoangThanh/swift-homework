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
let arrayEx1 = [4, 7, 1, 3, 2, 5, 9, 8]
let arraySorted = arrayEx1.sorted(by: {$0 > $1})
let arrayNew = arrayEx1.map({$0*3})
print("Original: \(arrayEx1) \nSorted: \(arraySorted) \nNewArray: \(arrayNew)")
