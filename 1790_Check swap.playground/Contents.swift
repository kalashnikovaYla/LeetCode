 
/*
 You are given two strings s1 and s2 of equal length. A string swap is an operation where you choose two indices in a string (not necessarily different) and swap the characters at these indices.

 Return true if it is possible to make both strings equal by performing at most one string swap on exactly one of the strings. Otherwise, return false.

  

 Example 1:

 Input: s1 = "bank", s2 = "kanb"
 Output: true
 Explanation: For example, swap the first character with the last character of s2 to make "bank".

 Example 2:

 Input: s1 = "attack", s2 = "defend"
 Output: false
 Explanation: It is impossible to make them equal with one string swap.

 Example 3:

 Input: s1 = "kelb", s2 = "kelb"
 Output: true
 Explanation: The two strings are already equal, so no string swap operation is required.
  
 */
 
func areAlmostEqual(_ s1: String, _ s2: String) -> Bool {
    if s1 == s2 { return true }
    
    var s1 = Array(s1)
    var s2 = Array(s2)
    var mismatches = [Int]()
    
    
    for i in 0..<s2.count {
        if s1[i] != s2[i] {
            mismatches.append(i)
            if mismatches.count > 2 {
                return false
            }
        }
    }
    
    if mismatches.count == 2 {
        let temp = s2[mismatches[0]]
        s2[mismatches[0]] = s2[mismatches[1]]
        s2[mismatches[1]] = temp
        
    }
    return s2 == s1
}
areAlmostEqual("qgqeg", "gqgeq")
