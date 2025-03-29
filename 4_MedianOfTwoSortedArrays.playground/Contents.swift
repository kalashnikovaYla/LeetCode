
import Foundation

/*
 Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.

 The overall run time complexity should be O(log (m+n)).

  

 Example 1:

 Input: nums1 = [1,3], nums2 = [2]
 Output: 2.00000
 Explanation: merged array = [1,2,3] and median is 2.
 Example 2:

 Input: nums1 = [1,2], nums2 = [3,4]
 Output: 2.50000
 Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
 */


func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let m = nums1.count
    let n = nums2.count
    
    // Убедимся, что nums1 - это наименьший массив.
    if m > n {
        return findMedianSortedArrays(nums2, nums1)
    }

    var imin = 0
    var imax = m
    let halfLen = (m + n + 1) / 2

    while imin <= imax {
        let i = (imin + imax) / 2
        let j = halfLen - i

        if i < m && nums2[j - 1] > nums1[i] {
            // i слишком маленький; нужно увеличить его
            imin = i + 1
        } else if i > 0 && nums1[i - 1] > nums2[j] {
            // i слишком большой; нужно уменьшить его
            imax = i - 1
        } else {
            // i находится на нужном месте
            var maxOfLeft: Int
            if i == 0 {
                maxOfLeft = nums2[j - 1]
            } else if j == 0 {
                maxOfLeft = nums1[i - 1]
            } else {
                maxOfLeft = max(nums1[i - 1], nums2[j - 1])
            }

            if (m + n) % 2 == 0 {
                var minOfRight: Int
                if i == m {
                    minOfRight = nums2[j]
                }
                else if j == n {
                    minOfRight = nums1[i]
                }
                else {
                    minOfRight = min(nums1[i], nums2[j])
                }
                
                return Double(maxOfLeft + minOfRight) / 2.0
            } else {
                return Double(maxOfLeft)
            }
        }
    }

    return 0.0 // Тем не менее, это не должно происходить
}

// Пример вызова функции:
let nums1 = [1, 3]
let nums2 = [2]
let median = findMedianSortedArrays(nums1, nums2)
print("Median: \(median)")  // Вывод: Median: 2.0

 

func findMedianSortedArrays2(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var newArray = [Int]()
    var left = 0
    var right = 0
    while left < nums1.count && right < nums2.count {
        if nums1[left] <= nums2[right] {
            newArray.append(nums1[left])
            left += 1
        } else {
            newArray.append(nums2[right])
            right += 1
        }
    }
    if left < nums1.count {
        newArray.append(contentsOf:nums1[left...(nums1.count - 1)])
    }
    
    if right < nums2.count {
        newArray.append(contentsOf:nums2[right...(nums2.count - 1)])
    }
    if newArray.count % 2 == 1 {
        return Double(newArray[newArray.count / 2])
    } else {
        let l = newArray[(newArray.count / 2) - 1]
        let r = newArray[newArray.count / 2]
        return Double(l + r) / 2.0
    }
}

