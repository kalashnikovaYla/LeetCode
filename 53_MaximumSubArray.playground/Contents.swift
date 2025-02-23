

func maxSubArray(_ nums: [Int]) -> Int {
    var maxSum = Int.min
    var currentSum = 0
    
    for num in nums {
        currentSum += num
        maxSum = max(maxSum, currentSum)
        
        if currentSum < 0 {
            currentSum = 0
        }
    }
    
    return maxSum
    
}
