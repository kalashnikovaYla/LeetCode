/*
 Given an array of strings words and an integer k, return the k most frequent strings.

 Return the answer sorted by the frequency from highest to lowest. Sort the words with the same frequency by their lexicographical order.

  

 Example 1:

 Input: words = ["i","love","leetcode","i","love","coding"], k = 2
 Output: ["i","love"]
 Explanation: "i" and "love" are the two most frequent words.
 Note that "i" comes before "love" due to a lower alphabetical order.
 Example 2:

 Input: words = ["the","day","is","sunny","the","the","the","sunny","is","is"], k = 4
 Output: ["the","is","sunny","day"]
 Explanation: "the", "is", "sunny" and "day" are the four most frequent words, with the number of occurrence being 4, 3, 2 and 1 respectively.
 */


class Solution {
    func topKFrequent(_ words: [String], _ k: Int) -> [String] {
        var counts: [Int: [String]] = [:]
        var countDict: [String: Int] = [:]
        for word in words {
            countDict[word, default: 0] += 1
        }

        for (word, count) in countDict {
            counts[count, default: []].append(word)
        }

        var res = [String]()

        for i in (0..<words.count).reversed() {
            for word in counts[i, default: []].sorted() {
                res.append(word)
                if res.count == k {
                    return res
                }
            }
        }
        return res
    }
}

 
