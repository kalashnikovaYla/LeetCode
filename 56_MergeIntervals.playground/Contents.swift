/*
 Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.

  

 Example 1:

 Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
 Output: [[1,6],[8,10],[15,18]]
 Explanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].
 Example 2:

 Input: intervals = [[1,4],[4,5]]
 Output: [[1,5]]
 Explanation: Intervals [1,4] and [4,5] are considered overlapping.
 */

class Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        
        let intervalCount = intervals.count
        
        guard intervalCount > 1 else {
            return intervals
        }
        
        let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
        var result: [[Int]] = [sortedIntervals[0]]
        
        for i in 1...intervalCount-1 {
            let lastAddedInterval = result.last!
            
            if lastAddedInterval[1] >= sortedIntervals[i][0] {
                result[result.count-1][1] = max(lastAddedInterval[1], sortedIntervals[i][1])
            } else {
                result.append(sortedIntervals[i])
            }
        }
        
        return result
    }
}
