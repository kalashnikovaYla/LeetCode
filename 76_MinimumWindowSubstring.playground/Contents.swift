/*
 Given two strings s and t of lengths m and n respectively, return the minimum window substring of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".

 The testcases will be generated such that the answer is unique.

  

 Example 1:

 Input: s = "ADOBECODEBANC", t = "ABC"
 Output: "BANC"
 Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
 Example 2:

 Input: s = "a", t = "a"
 Output: "a"
 Explanation: The entire string s is the minimum window.
 Example 3:

 Input: s = "a", t = "aa"
 Output: ""
 Explanation: Both 'a's from t must be included in the window.
 Since the largest window of s only has one 'a', return empty string.

 */

class Solution {
    func minWindow(_ s: String, _ t: String) -> String {
        let sArray = Array(s)
        let tArray = Array(t)
        
        var dictT = [Character: Int]()
        for char in tArray {
            dictT[char, default: 0] += 1
        }
        
        let required = dictT.count
        
        var left = 0
        var right = 0
        var formed = 0
        var windowCounts = [Character: Int]()
        
        var minLength = Int.max
        var minLeft = 0
        var minRight = 0
        
        while right < sArray.count {
            let char = sArray[right]
            print(char)
            windowCounts[char, default: 0] += 1
            
            if let count = dictT[char], count == windowCounts[char] {
                formed += 1
            }
            
            while left <= right && formed == required {
                let startChar = sArray[left]
                let endChar = sArray[right]
                
                if minLength > right - left + 1 {
                    minLength = right - left + 1
                    minLeft = left
                    minRight = right
                }
                
                windowCounts[startChar, default: 0] -= 1
                if let count = dictT[startChar], windowCounts[startChar]! < count {
                    formed -= 1
                }
                left += 1
            }
            
            right += 1
        }
        
        return minLength == Int.max ? "" : String(sArray[minLeft...minRight])
    }
}
