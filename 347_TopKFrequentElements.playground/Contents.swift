/*
 Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.

  

 Example 1:

 Input: nums = [1,1,1,2,2,3], k = 2
 Output: [1,2]
 Example 2:

 Input: nums = [1], k = 1
 Output: [1]
 */


class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var dict = [Int: Int]()
        for element in nums {
            dict[element] = (dict[element] ?? 0) + 1
        }
        
        
        var tupleArray = [(Int, Int)]()
        for (key, value) in dict {
            tupleArray.append((value, key))
        }

        tupleArray.sort{ $0.0 > $1.0 }

        var result = [Int]()
        for index in 0..<k {
            result.append(tupleArray[index].1)
        }
        return result
    }
}
