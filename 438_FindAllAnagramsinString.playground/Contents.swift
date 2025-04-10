/*
 Given two strings s and p, return an array of all the start indices of p's anagrams in s. You may return the answer in any order.

  

 Example 1:

 Input: s = "cbaebabacd", p = "abc"
 Output: [0,6]
 Explanation:
 The substring with start index = 0 is "cba", which is an anagram of "abc".
 The substring with start index = 6 is "bac", which is an anagram of "abc".
 
 Example 2:

 Input: s = "abab", p = "ab"
 Output: [0,1,2]
 Explanation:
 The substring with start index = 0 is "ab", which is an anagram of "ab".
 The substring with start index = 1 is "ba", which is an anagram of "ab".
 The substring with start index = 2 is "ab", which is an anagram of "ab".
 */

class Solution {
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        let sArray = Array(s)
        let pArray = Array(p)
        let sLen = sArray.count
        let pLen = pArray.count
        
        
        if pLen > sLen {
            return []
        }
        
        
        var pCount = [Int](repeating: 0, count: 26)
        var sCount = [Int](repeating: 0, count: 26)
        
         
        for char in pArray {
            pCount[Int(char.unicodeScalars.first!.value) - Int(UnicodeScalar("a").value)] += 1
        }
        
        var result = [Int]()
        
        
        for i in 0..<sLen {
             
            sCount[Int(sArray[i].unicodeScalars.first!.value) - Int(UnicodeScalar("a").value)] += 1
            
            
            if i >= pLen {
                sCount[Int(sArray[i - pLen].unicodeScalars.first!.value) - Int(UnicodeScalar("a").value)] -= 1
            }
            
            
            if sCount == pCount {
                result.append(i - pLen + 1)
            }
        }
        
        return result
    }
}


 
func findAnagrams(_ s: String, _ p: String) -> [Int] {
    let lenS = s.count
    let lenP = p.count
     
    if lenP > lenS {
        return []
    }
    
    
    let sArray = Array(s)
    let pArray = Array(p)

    
    var pCount = [Character: Int]()
    var sCount = [Character: Int]()
    
    
    for char in pArray {
        pCount[char, default: 0] += 1
    }
    
    for i in 0..<lenP {
        sCount[sArray[i], default: 0] += 1
    }

    var result = [Int]()
    
     
    if sCount == pCount {
        result.append(0)
    }
    
    for i in lenP..<lenS {
        sCount[sArray[i], default: 0] += 1
        
        let outgoingChar = sArray[i - lenP]
        sCount[outgoingChar, default: 0] -= 1
        
       
        if sCount[outgoingChar] == 0 {
            sCount.removeValue(forKey: outgoingChar)
        }
        
        if sCount == pCount {
            result.append(i - lenP + 1)
        }
    }

    return result
}
 
