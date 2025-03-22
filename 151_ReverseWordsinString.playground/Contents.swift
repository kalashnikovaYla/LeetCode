/*
 Given an input string s, reverse the order of the words.

 A word is defined as a sequence of non-space characters. The words in s will be separated by at least one space.

 Return a string of the words in reverse order concatenated by a single space.

 Note that s may contain leading or trailing spaces or multiple spaces between two words. The returned string should only have a single space separating the words. Do not include any extra spaces.

  

 Example 1:

 Input: s = "the sky is blue"
 Output: "blue is sky the"

 Example 2:

 Input: s = "  hello world  "
 Output: "world hello"
 Explanation: Your reversed string should not contain leading or trailing spaces.

 Example 3:

 Input: s = "a good   example"
 Output: "example good a"
 Explanation: You need to reduce multiple spaces between two words to a single space in the reversed string.
 */

class Solution {
    func reverseWords(_ s: String) -> String {
       var chars = Array(s)
    
        reverse(chars: &chars, left: 0, right: chars.count - 1)
    

        var start = 0
        for i in 0...chars.count {
            if i == chars.count ||  chars[i] == " " {
                reverse(chars: &chars, left: start, right: i - 1)
                start = i + 1
            }
         }

        return trimSpaces(chars: chars)
    }

    func reverse(chars: inout [Character], left: Int, right: Int) {
        var l = left, h = right

        while l < h {
            chars.swapAt(l, h)
            l += 1
            h -= 1
        }
    }

    func trimSpaces(chars: [Character]) -> String {
        var n = chars.count
        var i = 0

        var result = [Character]()

        while i < n {

            while i < n && chars[i] == " " {
                i += 1
            }

            while i < n && chars[i] != " " {
                result.append(chars[i])
                i += 1
            }

            while i < n && chars[i] == " " { 
                i += 1
            }

            if i < n {
                result.append(" ")
            }
        }
        return String(result)
    }
}


func reverseWords(_ s: String) -> String { 
    let words = s.split(whereSeparator: { $0.isWhitespace })
   
    let reversedWords = words.reversed().joined(separator: " ")
    
    return reversedWords
}

// Example usage:
let input1 = "the sky is blue"
let output1 = reverseWords(input1)
print(output1) // Output: "blue is sky the"

let input2 = "  hello world  "
let output2 = reverseWords(input2)
print(output2) // Output: "world hello"
