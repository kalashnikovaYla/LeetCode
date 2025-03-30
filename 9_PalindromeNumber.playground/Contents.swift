/*
 Given an integer x, return true if x is a palindrome, and false otherwise.
 
 Example 1:
 Input: x = 121
 Output: true
 Explanation: 121 reads as 121 from left to right and from right to left.
 
 Example 2:
 Input: x = -121
 Output: false
 Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
 
 Example 3:
 Input: x = 10
 Output: false
 Explanation: Reads 01 from right to left. Therefore it is not a palindrome.

 */

func isPalindrome(_ x: Int) -> Bool {
    let string1 = String(x)
    if string1 == String(string1.reversed()) {
        return true
    }
    return false
}

isPalindrome(121)


class Solution {
    func isPalindrome(_ x: Int) -> Bool {
    var originalx = x
    var x = x
    if x < 0 {
        return false
    }
    
    if x < 10 {
        return true
    }
    var reversed = 0
    while (x > 0) {
        let temp = x % 10
        reversed = temp + (reversed * 10)
        x /= 10
    }
    return originalx == reversed
    }
}
