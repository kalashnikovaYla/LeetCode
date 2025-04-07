/*
 Given a string s which consists of lowercase or uppercase letters, return the length of the longest palindrome that can be built with those letters.

 Letters are case sensitive, for example, "Aa" is not considered a palindrome.

 Дана строка s, состоящая из строчных или заглавных букв, вернуть длину самого длинного палиндрома, который можно построить с помощью этих букв.

 Буквы чувствительны к регистру, например, «Aa» не считается палиндромом.

 Example 1:

 Input: s = "abccccdd"
 Output: 7
 Explanation: One longest palindrome that can be built is "dccaccd", whose length is 7.
 
 Example 2:

 Input: s = "a"
 Output: 1
 Explanation: The longest palindrome that can be built is "a", whose length is 1.
 */


class Solution {
    func longestPalindrome(_ s: String) -> Int {
        var charCount = [Character: Int]()
        
        for char in s {
            charCount[char, default: 0] += 1
        }
        
        var length = 0
        var hasOddCount = false
        
        for count in charCount.values {
            if count % 2 == 0 {
                length += count
            } else {
                length += count - 1
                hasOddCount = true
            }
        }
        
        if hasOddCount {
            length += 1
        }
        
        return length
    }
}
