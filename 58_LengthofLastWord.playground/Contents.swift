/*
 Given a string s consisting of words and spaces, return the length of the last word in the string.
 A word is a maximal substring consisting of non-space characters only.

 Example 1:

 Input: s = "Hello World"
 Output: 5
 Explanation: The last word is "World" with length 5.
 
 Example 2:

 Input: s = "   fly me   to   the moon  "
 Output: 4
 Explanation: The last word is "moon" with length 4.
 
 Example 3:

 Input: s = "luffy is still joyboy"
 Output: 6
 Explanation: The last word is "joyboy" with length 6.
 */

import Foundation

func lengthOfLastWord(_ s: String) -> Int {
    
    if let lastWord = s.components(separatedBy: " ").filter({ $0 != "" }).last {
        return lastWord.count
    } else {
        return 0
    }
}


class Solution {
    func lengthOfLastWord(_ s: String) -> Int {
        var wordStarted = false
        var index = 0
        for i in stride(from: s.count - 1, through: 0, by: -1) {
            if s[s.index(s.startIndex, offsetBy: i)] == " " {
                if wordStarted {
                    return index
                }
                continue
            } else {
                wordStarted = true
                index += 1
               
            }
        }
        return index
    }
}


Solution().lengthOfLastWord("Hello World")
