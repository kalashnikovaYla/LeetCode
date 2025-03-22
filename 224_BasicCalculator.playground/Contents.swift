/*
 Given a string s representing a valid expression, implement a basic calculator to evaluate it, and return the result of the evaluation.

 Note: You are not allowed to use any built-in function which evaluates strings as mathematical expressions, such as eval().

  

 Example 1:

 Input: s = "1 + 1"
 Output: 2
 Example 2:

 Input: s = " 2-1 + 2 "
 Output: 3
 Example 3:

 Input: s = "(1+(4+5+2)-3)+(6+8)"
 Output: 23
 */

func calculate(_ s: String) -> Int {
    var total = 0
    var num = 0
    var sign = 1
    var stack = [sign]
    
    for c in s {
        switch c {
        case "+", "-":
            total += num * sign
            sign = stack.last! * (c == "+" ? 1 : -1)
            num = 0
        case "(":
            stack.append(sign)
        case ")":
            stack.removeLast()
        case " ":
            break
        default:
            num = num * 10 + c.wholeNumberValue!
        }
    }
    
    return total + num * sign
}


class Solution {
    func calculate(_ s: String) -> Int {
        var stack = [Int]()
        var num = 0
        var sign = 1
        var result = 0
        
        for char in s {
            if let digit = Int(String(char)) {
                 
                num = num * 10 + digit
            } else if char == "+" {
                 
                result += sign * num
                num = 0
                sign = 1
            } else if char == "-" {
                
                result += sign * num
                num = 0
                sign = -1
            } else if char == "(" {
                stack.append(result)
                stack.append(sign)
                 
                result = 0
                sign = 1
            } else if char == ")" {
                 
                result += sign * num
                 
                result *= stack.removeLast()
                result += stack.removeLast()
                
                num = 0
            }
        }
     
        result += sign * num
        return result
    }
}
