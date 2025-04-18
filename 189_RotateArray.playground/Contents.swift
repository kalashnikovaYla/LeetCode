

/*
 Given an integer array nums, rotate the array to the right by k steps, where k is non-negative.

  

 Example 1:

 Input: nums = [1,2,3,4,5,6,7], k = 3
 Output: [5,6,7,1,2,3,4]
 Explanation:
 rotate 1 steps to the right: [7,1,2,3,4,5,6]
 rotate 2 steps to the right: [6,7,1,2,3,4,5]
 rotate 3 steps to the right: [5,6,7,1,2,3,4]
 
 
 Example 2:

 Input: nums = [-1,-100,3,99], k = 2
 Output: [3,99,-1,-100]
 Explanation:
 rotate 1 steps to the right: [99,-1,-100,3]
 rotate 2 steps to the right: [3,99,-1,-100]
 */

class Solution {
    func rotate(_ nums: inout [Int], _ k: Int) {
        var repeats = k
        while repeats > 0 {
            if let last = nums.last {
                nums.removeLast()
                nums.insert(last, at: 0)
            }
            repeats -= 1
        }
    }
}


func rotate(_ nums: inout [Int], _ k: Int) {
    let n = nums.count
    guard n > 0 else { return }
    let k = k % n
    
    if k == 0 { return }
    
    let splitIndex = n - k
    let rightPart = Array(nums[splitIndex..<n])
    nums.removeSubrange(splitIndex..<n)
    
    nums.insert(contentsOf: rightPart, at: 0)
}
var nums = [1,2,3,4,5,6,7]
rotate(&nums, 3)
