
import Foundation

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
            if i == 0 { maxOfLeft = nums2[j - 1] }
            else if j == 0 { maxOfLeft = nums1[i - 1] }
            else { maxOfLeft = max(nums1[i - 1], nums2[j - 1]) }

            if (m + n) % 2 == 0 {
                var minOfRight: Int
                if i == m { minOfRight = nums2[j] }
                else if j == n { minOfRight = nums1[i] }
                else { minOfRight = min(nums1[i], nums2[j]) }
                
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

 
