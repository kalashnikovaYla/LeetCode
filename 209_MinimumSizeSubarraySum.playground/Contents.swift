/*
 Given an array of positive integers nums and a positive integer target, return the minimal length of a subarray whose sum is greater than or equal to target. If there is no such subarray, return 0 instead.

  

 Example 1:

 Input: target = 7, nums = [2,3,1,2,4,3]
 Output: 2
 Explanation: The subarray [4,3] has the minimal length under the problem constraint.
 
 Example 2:

 Input: target = 4, nums = [1,4,4]
 Output: 1
 
 Example 3:

 Input: target = 11, nums = [1,1,1,1,1,1,1,1]
 Output: 0
 */


func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
    let n = nums.count
    var left = 0
    var sum = 0
    var minLength = Int.max
    
    for right in 0..<n {
        sum += nums[right]
        
        
        while sum >= target {
            minLength = min(minLength, right - left + 1)
            sum -= nums[left]
            left += 1  
        }
    }
    
    return minLength == Int.max ? 0 : minLength
}

