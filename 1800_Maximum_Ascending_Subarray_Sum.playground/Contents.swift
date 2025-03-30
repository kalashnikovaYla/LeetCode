
/*
 Given an array of positive integers nums, return the maximum possible sum of an strictly increasing subarray in nums.

 A subarray is defined as a contiguous sequence of numbers in an array.

  

 Example 1:

 Input: nums = [10,20,30,5,10,50]
 Output: 65
 Explanation: [5,10,50] is the ascending subarray with the maximum sum of 65.

 Example 2:

 Input: nums = [10,20,30,40,50]
 Output: 150
 Explanation: [10,20,30,40,50] is the ascending subarray with the maximum sum of 150.

 Example 3:

 Input: nums = [12,17,15,13,10,11,12]
 Output: 33
 Explanation: [10,11,12] is the ascending subarray with the maximum sum of 33.
 */
func maxAscendingSum(_ nums: [Int]) -> Int {
    var maxSum = nums.first ?? 0
    var currerntSum = nums.first ?? 0
    var low = 0
    var hight = 1
   
    while hight < nums.count {
        if nums[hight - 1] < nums[hight] {
            currerntSum += nums[hight]
            hight += 1
            if currerntSum > maxSum {
                maxSum = currerntSum
            }
        } else {
            low = hight
            hight = low + 1
            currerntSum = nums[low]
        }
    }
    return maxSum
}

maxAscendingSum([12, 17, 15, 13, 10, 11, 12])
