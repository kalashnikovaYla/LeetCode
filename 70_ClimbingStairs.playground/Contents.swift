/*
 You are climbing a staircase. It takes n steps to reach the top. Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?


 Example 1:

 Input: n = 2
 Output: 2
 Explanation: There are two ways to climb to the top.
 1. 1 step + 1 step
 2. 2 steps
 
 Example 2:

 Input: n = 3
 Output: 3
 Explanation: There are three ways to climb to the top.
 1. 1 step + 1 step + 1 step
 2. 1 step + 2 steps
 3. 2 steps + 1 step
 
 */


func climbStairs(_ n: Int) -> Int {
    if n == 0 || n == 1 {
        return 1
    }
    var stepOne = 1
    var stepTwo = 1
    var result = 0
    
    for _ in 2...n {
        result = stepOne + stepTwo
        stepTwo = stepOne
        stepOne = result
    }
    return result
}


class Solution {
    var memo = [Int: Int]()
    func climbStairs(_ n: Int) -> Int {
        if n == 1 {
            return 1
        } else if n == 2 {
            return 2
        }

        if let result = memo[n] {
            return result
        }
        memo[n] = climbStairs(n-2) + climbStairs(n-1)
        return memo[n]!
    }
}
Solution().climbStairs(45)
