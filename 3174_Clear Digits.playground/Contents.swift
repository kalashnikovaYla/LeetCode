 
/*
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
