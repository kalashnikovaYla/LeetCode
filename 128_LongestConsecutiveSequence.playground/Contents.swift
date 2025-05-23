/*
 Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.

 You must write an algorithm that runs in O(n) time.

  

 Example 1:

 Input: nums = [100,4,200,1,3,2]
 Output: 4
 Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.

 Example 2:

 Input: nums = [0,3,7,2,5,8,4,6,0,1]
 Output: 9

 Example 3:

 Input: nums = [1,0,1,2]
 Output: 3
 */

class Solution {
    func longestConsecutive(_ nums: [Int]) -> Int {
  
        let sortedNums = nums.sorted()
        var n = sortedNums.count
        var count = 1
        var maxCount = 1
        
    
        if n == 0 {
            return 0
        }
        
        
        for i in 1..<n {
            if sortedNums[i] == sortedNums[i - 1] + 1 {
                count += 1
            } else if sortedNums[i] != sortedNums[i - 1] {
                maxCount = max(maxCount, count)
                count = 1
            }
        }
        
         
        maxCount = max(maxCount, count)
        
        return maxCount
    }
}
