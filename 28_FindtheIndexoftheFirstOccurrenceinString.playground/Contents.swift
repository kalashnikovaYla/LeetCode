/*
 Given two strings needle and haystack, return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

  

 Example 1:

 Input: haystack = "sadbutsad", needle = "sad"
 Output: 0
 Explanation: "sad" occurs at index 0 and 6.
 The first occurrence is at index 0, so we return 0.
 Example 2:

 Input: haystack = "leetcode", needle = "leeto"
 Output: -1
 Explanation: "leeto" did not occur in "leetcode", so we return -1.
 */


class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        var result = -1
        
        if needle.count > haystack.count {
            return result
        }
        for i in 0...(haystack.count - needle.count) {
            
            let firstI = haystack.index(haystack.startIndex, offsetBy: i)
            print(haystack.count, needle.count)
            let secondI = haystack.index(haystack.startIndex, offsetBy: i +  needle.count)
            let subStr = haystack[firstI..<secondI]
            if subStr == needle {
                return i
            }
        }
        return result
    }
}


func strStr(_ haystack: String, _ needle: String) -> Int {
       var needleCount = needle.count
       var hayArr = Array(haystack)
       var needleArr = Array(needle)
       
       if needleCount > hayArr.count {
           return -1
       }
       for i in 0..<hayArr.count {
           var finalCount:Int = 0
           if hayArr[i] == needle.first {
               var incCount = 0
               for j in 0..<needleArr.count {
                   if incCount + i >= hayArr.count {
                       return -1
                   }
                   if needleArr[j] == hayArr[incCount + i] {
                       finalCount += 1
                       if finalCount == needleCount {
                           return i
                       }
                   }
                   incCount += 1
               }
           }
       }
       
       
       return -1
   }
