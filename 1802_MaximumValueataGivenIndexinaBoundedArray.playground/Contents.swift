
/*
 You are given three positive integers: n, index, and maxSum. You want to construct an array nums (0-indexed) that satisfies the following conditions:

 nums.length == n
 nums[i] is a positive integer where 0 <= i < n.
 abs(nums[i] - nums[i+1]) <= 1 where 0 <= i < n-1.
 The sum of all the elements of nums does not exceed maxSum.
 nums[index] is maximized.
 Return nums[index] of the constructed array.

 Note that abs(x) equals x if x >= 0, and -x otherwise.

1)
 Input: n = 4, index = 2,  maxSum = 6
 Output: 2
 Explanation: nums = [1,2,2,1] is one array that satisfies all the conditions.
 There are no arrays that satisfy all the conditions and have nums[2] == 3, so 2 is the maximum nums[2].
 
 2)
 Input: n = 6, index = 1,  maxSum = 10
 Output: 3
 */


class Solution {
    func getSum(_ index: Int, _ value: Int, _ n: Int) -> Int {
        var count = 0
        
        // On index's left:
        if value > index {
            count += (value + value - index) * (index + 1) / 2
        } else {
            count += (value + 1) * value / 2 + (index - value + 1)
        }
        
        // On index's right:
        if value >= n - index {
            count += (value + value - n + 1 + index) * (n - index) / 2
        } else {
            count += (value + 1) * value / 2 + (n - index - value)
        }
        
        return count - value
    }
    
    func maxValue(_ n: Int, _ index: Int, _ maxSum: Int) -> Int {
        var left = 1
        var right = maxSum
        
        while left < right {
            let mid = (left + right + 1) / 2
            if getSum(index, mid, n) <= maxSum {
                left = mid
            } else {
                right = mid - 1
            }
        }
        
        return left
    }
}



class SecondSolution {
    var n: Int = 0
    var index: Int = 0
    
    func maxValue(_ n: Int, _ index: Int, _ maxSum: Int) -> Int {
        self.n = n
        self.index = index
        var adjustedMaxSum = maxSum - n
        var left = 0
        var right = adjustedMaxSum
        
        while left < right {
            let mid = (left + right + 1) / 2
            if check(mid) <= adjustedMaxSum {
                left = mid
            } else {
                right = mid - 1
            }
        }
        
        return left + 1
    }

    private func check(_ a: Int) -> Int {
        let leftOffset = max(a - index, 0)
        var result = (a + leftOffset) * (a - leftOffset + 1) / 2
        let rightOffset = max(a - ((n - 1) - index), 0)
        result += (a + rightOffset) * (a - rightOffset + 1) / 2
        return result - a
    }
}

