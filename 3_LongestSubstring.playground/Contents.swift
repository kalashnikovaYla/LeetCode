import Foundation

/*
 Given a string s, find the length of the longest substring without duplicate characters.

  

 Example 1:

 Input: s = "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.
 Example 2:

 Input: s = "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.
 Example 3:

 Input: s = "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
 Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */

func lengthOfLongestSubstring(_ s: String) -> Int {
    var charSet = Set<Character>()
    var left = s.startIndex
    var maxLength = 0
    
    for right in s.indices {
        while charSet.contains(s[right]) {
            charSet.remove(s[left])
            left = s.index(after: left)
        }
        charSet.insert(s[right])
        maxLength = max(maxLength, s.distance(from: left, to: s.index(after: right)))
    }
    
    return maxLength
}

func lengthOfLongestSubstring(s: String) -> Int {
    guard !s.isEmpty else { return 0 }
    var len = 0
    var chars = [Character]()
    for c in s {
        if let idx = chars.firstIndex(of: c) {
            chars.removeSubrange(0...idx)
        }
        chars.append(c)
        len = max(len, chars.count)
    }
    return len
}
