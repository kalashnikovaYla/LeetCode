/*
 You are given an integer array nums and an integer k. Find the maximum subarray sum of all the subarrays of nums that meet the following conditions:

 The length of the subarray is k, and
 All the elements of the subarray are distinct.
 Return the maximum subarray sum of all the subarrays that meet the conditions. If no subarray meets the conditions, return 0.

 A subarray is a contiguous non-empty sequence of elements within an array.

 Вам дан целочисленный массив nums и целое число k. Найдите максимальную сумму подмассива всех подмассивов nums, которые удовлетворяют следующим условиям:

 Длина подмассива равна k, и
 Все элементы подмассива различны.
 Верните максимальную сумму подмассива всех подмассивов, которые удовлетворяют условиям. Если ни один подмассив не удовлетворяет условиям, верните 0.

 Подмассив — это непрерывная непустая последовательность элементов внутри массива.

 Example 1:

 Input: nums = [1,5,4,2,9,9,9], k = 3
 Output: 15
 Explanation: The subarrays of nums with length 3 are:
 - [1,5,4] which meets the requirements and has a sum of 10.
 - [5,4,2] which meets the requirements and has a sum of 11.
 - [4,2,9] which meets the requirements and has a sum of 15.
 - [2,9,9] which does not meet the requirements because the element 9 is repeated.
 - [9,9,9] which does not meet the requirements because the element 9 is repeated.
 We return 15 because it is the maximum subarray sum of all the subarrays that meet the conditions

 Example 2:

 Input: nums = [4,4,4], k = 3
 Output: 0
 Explanation: The subarrays of nums with length 3 are:
 - [4,4,4] which does not meet the requirements because the element 4 is repeated.
 We return 0 because no subarrays meet the conditions.
  

 Constraints:

 1 <= k <= nums.length <= 105
 1 <= nums[i] <= 105
 */


class Solution {
    func maximumSubarraySum(_ nums: [Int], _ k: Int) -> Int {
        var sum = 0
        var left = 0
        var mem = [Int: Int]()
        var maxSum = 0

        for right in 0..<nums.count {
            let curr = nums[right]
            let storedIdx = mem[curr] ?? -1
            while left <= storedIdx || right - left >= k {
                sum -= nums[left]
                left += 1
            }
            
            mem[curr] = right
            sum += curr
            if right - left + 1 == k {
                maxSum = max(maxSum, sum)
            }
        }
        return maxSum
    }
}

Solution().maximumSubarraySum([1,5,4,2,9,9,9], 3)
