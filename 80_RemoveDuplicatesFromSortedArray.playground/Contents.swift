import UIKit

func removeDuplicates(_ nums: inout [Int]) -> Int {
    var dictionary = [Int: Int]()
    var index = 0
    
    while index < nums.count {
        let key = nums[index]
        
        if let value = dictionary[key] {
            if (dictionary[key] ?? 0) > 1 {
                nums.remove(at: index)
            } else {
                dictionary[key] = value + 1
                index += 1
            }
        } else {
            dictionary[key] = 1
            index += 1
        }
        
    }
    
    return nums.count
}

var array = [1,2,3,3,3,4,4,5,5,5]
//removeDuplicates(&array)
 

func removeDuplicate(_ nums: inout [Int]) -> Int {
    var currentElement: Int?
    var currentCount = 0
    var index = 0
    
    while index < nums.count {

        if currentElement != nums[index] {
            currentElement = nums[index]
            currentCount = 0
        } else {
            if currentCount < 1 {
                currentCount += 1
            } else {
                nums.remove(at: index)
                continue
            }
        }
        index += 1
    }

    return nums.count
}

removeDuplicate(&array)
 
