import Foundation

func missingNumber(_ nums: [Int]) -> Int {
    var max = nums.first ?? 0
    var min = nums.first ?? 0
    var set = Set(nums)
    for i in nums {
        if i < min {
            min = i
        } else if i > max {
            max = i
        }
    }
    
    for i in min...max {
        if !set.contains(i) {
            return i
        }
    }
    if !set.contains(0) {
        return 0
    }
    return max + 1
}


func missingNumber(nums: [Int]) -> Int {
    let n = nums.count
    let allNumbers: Set<Int> = Set(Array(0...n))
    
    let missingNumbers = allNumbers.subtracting(Set(nums))
    
    return missingNumbers.first!
}
