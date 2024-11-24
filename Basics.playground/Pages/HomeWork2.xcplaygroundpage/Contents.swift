//: [Previous](@previous)

import Foundation



//func smallestSubset(set: Set<Int>, target: Int) -> Set<Int>? {
//    let sortedArr = set.sorted(by: >)
//    var best: Set<Int>? = nil
//    func findSubset(curSubset: Set<Int>, curIndex: Int, curSum: Int) {
//        // Đk dừng: nếu curSum >= target, hoặc đã duyệt qua hết các phần tử
//        guard curSum < target, curIndex < sortedArr.count else {
//            var bestSum = 0
//            if let bestSet = best {
//                for number in bestSet {
//                    bestSum += number
//                }
//            }
//            // cập nhật lại best nếu curSubset là lựa chọn tốt hơn
//            if curSum >= target, best == nil, curSubset.count < best?.count ?? 0,  (curSubset.count == best?.count && curSum < bestSum) {
//                best = curSubset
//            }
//            return
//        }
//        // đệ quy bỏ qua phần tử hiện tại để chắc chắn duyệt qua tìm tất cả các tập con có thể tìm được
//        findSubset(curSubset: curSubset, curIndex: curIndex + 1, curSum: curSum)
//        // mở rộng tập con, chuyển sang index tt để đệ quy tiếp tục, tính lại tổng
//        findSubset(curSubset: curSubset.union([sortedArr[curIndex]]), curIndex: curIndex + 1, curSum: curSum + sortedArr[curIndex])
//    }
//    findSubset(curSubset: Set<Int>(), curIndex: 0, curSum: 0)
//    return best
//}
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



