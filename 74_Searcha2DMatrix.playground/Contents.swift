/*
 You are given an m x n integer matrix matrix with the following two properties:

 Each row is sorted in non-decreasing order.
 The first integer of each row is greater than the last integer of the previous row.
 Given an integer target, return true if target is in matrix or false otherwise.

 You must write a solution in O(log(m * n)) time complexity.

 Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
 Output: true
 
 Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
 Output: false
 */


class Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard matrix.count > 0, matrix[0].count > 0 else {
            return false
        }
        
        let m = matrix.count
        let n = matrix[0].count
        var left = 0
        var right = m * n - 1
        
        while left <= right {
            let mid = left + (right - left) / 2
            let midValue = matrix[mid / n][mid % n]
            
            if midValue == target {
                return true
            } else if midValue < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        
        return false

    }
}
