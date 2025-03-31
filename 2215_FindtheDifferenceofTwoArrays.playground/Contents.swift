/*
 Given two 0-indexed integer arrays nums1 and nums2, return a list answer of size 2 where:

 answer[0] is a list of all distinct integers in nums1 which are not present in nums2.
 answer[1] is a list of all distinct integers in nums2 which are not present in nums1.
 Note that the integers in the lists may be returned in any order.

  

 Example 1:

 Input: nums1 = [1,2,3], nums2 = [2,4,6]
 Output: [[1,3],[4,6]]
 Explanation:
 For nums1, nums1[1] = 2 is present at index 0 of nums2, whereas nums1[0] = 1 and nums1[2] = 3 are not present in nums2. Therefore, answer[0] = [1,3].
 For nums2, nums2[0] = 2 is present at index 1 of nums1, whereas nums2[1] = 4 and nums2[2] = 6 are not present in nums1. Therefore, answer[1] = [4,6].

 Example 2:

 Input: nums1 = [1,2,3,3], nums2 = [1,1,2,2]
 Output: [[3],[]]
 Explanation:
 For nums1, nums1[2] and nums1[3] are not present in nums2. Since nums1[2] == nums1[3], their value is only included once and answer[0] = [3].
 Every integer in nums2 is present in nums1. Therefore, answer[1] = [].
 */


func findDifference(_ nums1: [Int], _ nums2: [Int]) -> [[Int]] {
    let set1 = Set(nums1)
    let set2 = Set(nums2)
    
    
    let uniqueToNums1 = Array(set1.subtracting(set2))
    let uniqueToNums2 = Array(set2.subtracting(set1))
    
    
    return [uniqueToNums1, uniqueToNums2]
}

findDifference([1,2,3,3], [1,1,2,2])


class Solution {
    func findDifference(_ nums1: [Int], _ nums2: [Int]) -> [[Int]] {
        var uniqueNums1 = Set<Int>()
        var uniqueNums2 = Set<Int>()
        var answer: [[Int]] = []
         
        for item in nums1 {
            uniqueNums1.insert(item)
        }
        for item in nums2 {
            uniqueNums2.insert(item)
        }
         
        var answer0 = [Int]()
        for item in uniqueNums1 {
            if !uniqueNums2.contains(item) {
                answer0.append(item)
            }
        }
         
        var answer1 = [Int]()
        for item in uniqueNums2 {
            if !uniqueNums1.contains(item) {
                answer1.append(item)
            }
        }
        answer = [answer0, answer1]
        return answer
    }
}
