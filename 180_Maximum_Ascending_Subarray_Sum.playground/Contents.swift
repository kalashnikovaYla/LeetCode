

///Given an array of positive integers nums, return the maximum possible sum of an ascending subarray in nums. A subarray is defined as a contiguous sequence of numbers in an array. A subarray [numsl, numsl+1, ..., numsr-1, numsr] is ascending if for all i where l <= i < r, numsi  < numsi+1. Note that a subarray of size 1 is ascending.

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
