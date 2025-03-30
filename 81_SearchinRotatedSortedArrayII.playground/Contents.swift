/*
 There is an integer array nums sorted in non-decreasing order (not necessarily with distinct values).

 Before being passed to your function, nums is rotated at an unknown pivot index k (0 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,4,4,5,6,6,7] might be rotated at pivot index 5 and become [4,5,6,6,7,0,1,2,4,4].

 Given the array nums after the rotation and an integer target, return true if target is in nums, or false if it is not in nums.

 You must decrease the overall operation steps as much as possible.
 
 Имеется целочисленный массив nums, отсортированный в порядке неубывания (не обязательно с различными значениями).

 Перед передачей в вашу функцию nums вращается с неизвестным индексом поворота k (0 <= k < nums.length) таким образом, что результирующий массив равен [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (индексирован с 0). Например, [0,1,2,4,4,4,5,6,6,7] может быть вращаться с индексом поворота 5 и стать [4,5,6,6,7,0,1,2,4,4].

 Учитывая массив nums после поворота и целочисленный target, верните true, если target находится в nums, или false, если он не находится в nums.

 Необходимо максимально сократить общее количество шагов операции.
  

 Example 1:

 Input: nums = [2,5,6,0,0,1,2], target = 0
 Output: true
 
 Example 2:

 Input: nums = [2,5,6,0,0,1,2], target = 3
 Output: false

 */

func search(_ nums: [Int], _ target: Int) -> Bool {
    var left = 0
    var right = nums.count - 1
    
    while left <= right {
        let mid = left + (right - left) / 2
        
        if nums[mid] == target {
            return true
        }
        
        if nums[left] == nums[mid] && nums[mid] == nums[right] {
            left += 1
            right -= 1
        } else if nums[left] <= nums[mid] {
            if nums[left] <= target && target < nums[mid] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        } else {
            if nums[mid] < target && target <= nums[right] {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
    
    return false
}

 
