
/*
 нужно удалить все числа, если на i - 1 лежит буква, то удалить ее вместе с числом
 
 
 Example 1:
 Input: s = "abc" Output: "abc" Explanation: There is no digit in the string.

 Example 2:
 Input: s = "cb34" Output: "" Explanation: First, we apply the operation on s[2], and s becomes "c4". Then we apply the operation on s[1], and s becomes "".
 */



func clearDigits(_ s: String) -> String {
    var result = [Character]()
    for char in s {
        if char.isNumber {
            if !result.isEmpty {
                result.removeLast()
            }
        } else {
            result.append(char)
        }
    }
    return String(result)
}

clearDigits("cb34")

func clearDigits(s: inout String) {
    var index = s.startIndex
    
    while index < s.endIndex {
        
        if s[index].isNumber {
            if index > s.startIndex {
                let previousIndex = s.index(before: index)
                s.remove(at: previousIndex)
                index = previousIndex
            }
            
            s.remove(at: index)
        } else {
            index = s.index(after: index)
        }
    }
}
var s =  "cb34"
clearDigits(s: &s)
