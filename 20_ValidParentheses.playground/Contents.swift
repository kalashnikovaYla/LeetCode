
/*
 Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
 An input string is valid if:
 Open brackets must be closed by the same type of brackets.
 Open brackets must be closed in the correct order.
 Every close bracket has a corresponding open bracket of the same type.
  

 Example 1:

 Input: s = "()"
 Output: true
 
 Example 2:

 Input: s = "()[]{}"
 Output: true
 
 Example 3:

 Input: s = "(]"
 Output: false

 */

func isValid(_ s: String) -> Bool {
    
    var stack: [Character] = []
    
    for bracket in s {
        switch bracket {
        case "(": stack.append(")")
        case "{": stack.append("}")
        case "[": stack.append("]")
        default:
            guard bracket == stack.popLast() else { return false }
        }
    }
    return stack.isEmpty
}
