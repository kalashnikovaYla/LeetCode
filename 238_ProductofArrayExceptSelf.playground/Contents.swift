/*
 Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].

 The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

 You must write an algorithm that runs in O(n) time and without using the division operation.

  

 Example 1:

 Input: nums = [1,2,3,4]
 Output: [24,12,8,6]
 Example 2:

 Input: nums = [-1,1,0,-3,3]
 Output: [0,0,9,0,0]
 */


class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var prefix = Array(repeating: 1, count: nums.count)
        var suffix = Array(repeating: 1, count: nums.count)
        var result = Array(repeating: 0, count: nums.count)

        for i in 1 ..< nums.count {
            prefix[i] = prefix[i - 1] * nums[i-1]
        }

        for i in (0 ..< nums.count - 1).reversed() {
            suffix[i] = suffix[i + 1] * nums[i + 1]
        }

        for i in 0 ..< nums.count {
            result[i] = suffix[i] * prefix[i]
        }

        return result
    }
}

/*
Input: nums = [1,2,3,4]
Output: [24,12,8,6]

(получить массив перемноженных чисел массива)
  2*3*4 = 24
1 * 3*4 = 12
1*2 * 4 = 8
1*2*3   = 6
(перемножить два массива по индексно)
1  1  2 6
24 12 4 1
24 12 8 6
*/
