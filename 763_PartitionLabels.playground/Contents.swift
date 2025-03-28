/*
 You are given a string s. We want to partition the string into as many parts as possible so that each letter appears in at most one part. For example, the string "ababcc" can be partitioned into ["abab", "cc"], but partitions such as ["aba", "bcc"] or ["ab", "ab", "cc"] are invalid.

 Note that the partition is done so that after concatenating all the parts in order, the resultant string should be s.

 Return a list of integers representing the size of these parts.

  

 Example 1:

 Input: s = "ababcbacadefegdehijhklij"
 Output: [9,7,8]
 Explanation:
 The partition is "ababcbaca", "defegde", "hijhklij".
 This is a partition so that each letter appears in at most one part.
 A partition like "ababcbacadefegde", "hijhklij" is incorrect, because it splits s into less parts.
 Example 2:

 Input: s = "eccbbbbdec"
 Output: [10]
  
 */

func partitionLabels(_ s: String) -> [Int] {
    var lastOccurrence = [Character: Int]()
     
    for (index, char) in s.enumerated() {
        lastOccurrence[char] = index
    }
    
    var partitions = [Int]()
    var currentEnd = 0
    var partitionStart = 0
    
    for (index, char) in s.enumerated() {
        currentEnd = max(currentEnd, lastOccurrence[char]!)
       
        if index == currentEnd {
            partitions.append(currentEnd - partitionStart + 1)
            partitionStart = index + 1
        }
    }
    
    return partitions
}

 
let example1 = "ababcbacadefegdehijhklij"
let example2 = "eccbbbbdec"
print(partitionLabels(example1)) // Output: [9, 7, 8]
 

