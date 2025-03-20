/*
 Given an array of strings strs, group the anagrams together. You can return the answer in any order.

  

 Example 1:

 Input: strs = ["eat","tea","tan","ate","nat","bat"]

 Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

 Explanation:

 There is no string in strs that can be rearranged to form "bat".
 The strings "nat" and "tan" are anagrams as they can be rearranged to form each other.
 The strings "ate", "eat", and "tea" are anagrams as they can be rearranged to form each other.
 
 Example 2:

 Input: strs = [""]

 Output: [[""]]

 Example 3:

 Input: strs = ["a"]

 Output: [["a"]]
 */

class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var dict = [String: [String]]()
        for s in strs {
            let key = String(s.sorted())
            dict[key, default: []].append(s)
        }
        return Array(dict.values)
    }
}


func groupAnagrams(_ strs: [String]) -> [[String]] {
    var anagramMap = [String: [String]]()
    
    for str in strs {
        
        let sortedStr = String(str.sorted())
         
        if var anagrams = anagramMap[sortedStr] {
            anagrams.append(str)
            anagramMap[sortedStr] = anagrams
        } else {
            anagramMap[sortedStr] = [str]
        }
    }
     
    return Array(anagramMap.values)
}

 
