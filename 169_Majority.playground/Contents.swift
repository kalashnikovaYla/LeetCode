import UIKit

/*
 Given an array nums of size n, return the majority element.

 The majority element is the element that appears more than ⌊n / 2⌋ times. You may assume that the majority element always exists in the array.

  

 Example 1:

 Input: nums = [3,2,3]
 Output: 3
 Example 2:

 Input: nums = [2,2,1,1,1,2,2]
 Output: 2
 */

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
