/*
 1200. Minimum Absolute Difference

 Given an array of distinct integers arr, find all pairs of elements with the minimum absolute difference of any two elements.

 Return a list of pairs in ascending order(with respect to pairs), each pair [a, b] follows

 a, b are from arr
 a < b
 b - a equals to the minimum absolute difference of any two elements in arr
  

 Example 1:

 Input: arr = [4,2,1,3]
 Output: [[1,2],[2,3],[3,4]]
 Explanation: The minimum absolute difference is 1. List all pairs with difference equal to 1 in ascending order.
 Example 2:

 Input: arr = [1,3,6,10,15]
 Output: [[1,3]]
 Example 3:

 Input: arr = [3,8,-10,23,19,-4,-14,27]
 Output: [[-14,-10],[19,23],[23,27]]

 */
class Solution {
    func minimumAbsDifference(_ arr: [Int]) -> [[Int]] {
        
        let sortedArr = arr.sorted()
        
        var minAbsDiff = Int.max
        var result: [[Int]] = []
        
        
        for i in 1..<sortedArr.count {
            let diff = sortedArr[i] - sortedArr[i - 1]
            
            if diff < minAbsDiff {
                minAbsDiff = diff
                result = [[sortedArr[i - 1], sortedArr[i]]]
            } else if diff == minAbsDiff {
                result.append([sortedArr[i - 1], sortedArr[i]])
            }
        }
        
        return result
    }
}


func minimumAbsDifference(_ arr: [Int]) -> [[Int]] {
    var minDiff = Int.max
    var pairs: [[Int]] = []
    let sortedArr = arr.sorted()
    
    for i in 1..<sortedArr.count {
        let diff = sortedArr[i] - sortedArr[i - 1]
        if diff < minDiff {
            minDiff = diff
            pairs = []
        }
        if diff == minDiff {
            pairs.append([sortedArr[i - 1], sortedArr[i]])
        }
    }
    
    return pairs
}
