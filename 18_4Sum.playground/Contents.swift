/*
 Given an array nums of n integers, return an array of all the unique quadruplets [nums[a], nums[b], nums[c], nums[d]] such that:

 0 <= a, b, c, d < n
 a, b, c, and d are distinct.
 nums[a] + nums[b] + nums[c] + nums[d] == target
 You may return the answer in any order.

  

 Example 1:

 Input: nums = [1,0,-1,0,-2,2], target = 0
 Output: [[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
 
 Example 2:

 Input: nums = [2,2,2,2,2], target = 8
 Output: [[2,2,2,2]]
 */

func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
    var result = [[Int]]()
    
    
    let nums = nums.sorted()
    let n = nums.count
    
    for i in 0..<n {
        
        if i > 0 && nums[i] == nums[i - 1] {
            continue
        }
        
        for j in i + 1..<n {
            
            if j > i + 1 && nums[j] == nums[j - 1] {
                continue
            }
            
            var left = j + 1
            var right = n - 1
            
            while left < right {
                let sum = nums[i] + nums[j] + nums[left] + nums[right]
                
                if sum == target {
                    result.append([nums[i], nums[j], nums[left], nums[right]])
                    
                    
                    repeat {
                        left += 1
                    } while left < right && nums[left] == nums[left - 1]
                    
                    repeat {
                        right -= 1
                    } while left < right && nums[right] == nums[right + 1]
                    
                } else if sum < target {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
    }
    
    return result
}
 
