/*
 For two strings s and t, we say "t divides s" if and only if s = t + t + t + ... + t + t (i.e., t is concatenated with itself one or more times).

 Given two strings str1 and str2, return the largest string x such that x divides both str1 and str2.

  

 Example 1:

 Input: str1 = "ABCABC", str2 = "ABC"
 Output: "ABC"
 Example 2:

 Input: str1 = "ABABAB", str2 = "ABAB"
 Output: "AB"
 Example 3:

 Input: str1 = "LEET", str2 = "CODE"
 Output: ""
 */


func gcdOfStrings(_ str1: String, _ str2: String) -> String {
    func gcd(_ a: Int, _ b: Int) -> Int {
        return b == 0 ? a : gcd(b, a % b)
    }
    
    let len1 = str1.count
    let len2 = str2.count
    let gcdLength = gcd(len1, len2)
    
    
    let candidate = String(str1.prefix(gcdLength))
   
    if (str1 == String(repeating: candidate, count: len1 / gcdLength)) &&
        (str2 == String(repeating: candidate, count: len2 / gcdLength)) {
        return candidate
    }
    
    return ""
}
gcdOfStrings("ABABABAB", "ABAB")

class Solution {
    func gcdOfStrings(_ str1: String, _ str2: String) -> String {
         
        guard str1 + str2 == str2 + str1 else { return "" }

        var divisorLength = min(str1.count, str2.count)

        while divisorLength > 0 {
            if str1.count % divisorLength == 0,
               str2.count % divisorLength == 0 {
                break
            }
            divisorLength -= 1
        }

        return String(str1.prefix(divisorLength))
    }
}

Solution().gcdOfStrings("ABABABAB", "ABAB")
