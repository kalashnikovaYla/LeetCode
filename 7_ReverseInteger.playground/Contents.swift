
import Foundation

/*
 Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.

 Assume the environment does not allow you to store 64-bit integers (signed or unsigned).
 */
func reverse(_ x: Int) -> Int {
    var result = 0
    var num = x
    let isNegative = num < 0
    num = abs(num)

    while num != 0 {
        let digit = num % 10
        num /= 10
        
        if (result > Int32.max / 10) || (result == Int32.max / 10 && digit > 7) {
            return 0
        }
        
        result = result * 10 + digit
    }

    return isNegative ? -result : result
}

class Solution {
    func reverse(_ x: Int) -> Int {
        var x = x
        var result = 0
        
        while x != 0 {
            result *= 10
            result += x % 10
            x /= 10
        }
        
        return result > Int32.max || result < Int32.min ? 0 : result
    }
}
