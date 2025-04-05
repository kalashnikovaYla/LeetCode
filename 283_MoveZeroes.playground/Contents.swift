/*
 Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.

 Note that you must do this in-place without making a copy of the array.

  

 Example 1:

 Input: nums = [0,1,0,3,12]
 Output: [1,3,12,0,0]
 
 Example 2:

 Input: nums = [0]
 Output: [0]
 */


func moveZeroes(_ nums: inout [Int]) {
    var movedIndex = 0
    for num in nums {
        if num != 0 {
            nums[movedIndex] = num
            movedIndex += 1
        }
    }
    
    for i in movedIndex..<nums.count {
        nums[i] = 0
    }
}

var num = [0,1,0,3,12]
moveZeroes(&num)
