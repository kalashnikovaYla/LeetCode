/*
 You are given two strings word1 and word2. Merge the strings by adding letters in alternating order, starting with word1. If a string is longer than the other, append the additional letters onto the end of the merged string.

 Return the merged string.

  

 Example 1:

 Input: word1 = "abc", word2 = "pqr"
 Output: "apbqcr"
 Explanation: The merged string will be merged as so:
 word1:  a   b   c
 word2:    p   q   r
 merged: a p b q c r
 Example 2:

 Input: word1 = "ab", word2 = "pqrs"
 Output: "apbqrs"
 Explanation: Notice that as word2 is longer, "rs" is appended to the end.
 word1:  a   b
 word2:    p   q   r   s
 merged: a p b q   r   s
 */

func mergeAlternately(_ word1: String, _ word2: String) -> String {
    let minCount = min(word1.count, word2.count)
    var res = ""
    var first = 0
    var second = 0
    
    while first < word1.count && second < word2.count {
        res.append(word1[word1.index(word1.startIndex, offsetBy: first)])
        res.append(word2[word2.index(word2.startIndex, offsetBy: second)])
        first += 1
        second += 1
    }
    
    if first < word1.count {
        let sub = word1.index(word1.startIndex, offsetBy: first)...word1.index(word1.startIndex, offsetBy: word1.count - 1)
        res += word1[sub]
    }
    if second < word2.count {
        let sub = word1.index(word2.startIndex, offsetBy: second)...word2.index(word2.startIndex, offsetBy: word2.count - 1)
        res += word2[sub]
    }
    return res
}
