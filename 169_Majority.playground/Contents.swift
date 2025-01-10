import UIKit


func majorityElement(_ nums: [Int]) -> Int {
   
    var dictionary: [Int:Int] = [:]
    for num in nums {
        if let value = dictionary[num] {
            dictionary[num] = value + 1
        } else {
            dictionary[num] = 1
        }
    }
    
    for (key,value) in dictionary {
        if value > nums.count/2 {
            return key
        }
    }
    return 0
}

majorityElement([2,2,1,1,1,2,2])


func findMajorityElement(_ nums: [Int]) -> Int {
    var candidate: Int = 0
    var count: Int = 0
    
    for num in nums {
        if count == 0 {
            candidate = num
        }
        count += (num == candidate) ? 1 : -1
    }
    
    return candidate
}

findMajorityElement([2,2,1,1,1,2,2])
