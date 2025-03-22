/*
 You are given a 0-indexed array of integers nums of length n. You are initially positioned at nums[0].

 Each element nums[i] represents the maximum length of a forward jump from index i. In other words, if you are at nums[i], you can jump to any nums[i + j] where:

 0 <= j <= nums[i] and
 i + j < n
 Return the minimum number of jumps to reach nums[n - 1]. The test cases are generated such that you can reach nums[n - 1].

  

 Example 1:

 Input: nums = [2,3,1,1,4]
 Output: 2
 Explanation: The minimum number of jumps to reach the last index is 2. Jump 1 step from index 0 to 1, then 3 steps to the last index.
 Example 2:

 Input: nums = [2,3,0,1,4]
 Output: 2
 */


func jump(_ nums: [Int]) -> Int {
    let n = nums.count
    if n <= 1 {
        return 0
    }
    
    var jumps = 0
    var currentEnd = 0
    var farthest = 0
    
    for i in 0..<n-1 {
        farthest = max(farthest, i + nums[i])
        
        
        if i == currentEnd {
            jumps += 1
            currentEnd = farthest
            
            if currentEnd >= n - 1 {
                break
            }
        }
    }
    
    return jumps
}

class Solution {
    func jump(_ nums: [Int]) -> Int {
        var maxNum = 0
        var jumps = 0
        var cursor = 0
        for i in nums.indices.dropLast() {
            maxNum = max(maxNum, i + nums[i])
            if cursor == i {
                cursor = maxNum
                jumps += 1
            }
        }
        return jumps
    }
}
