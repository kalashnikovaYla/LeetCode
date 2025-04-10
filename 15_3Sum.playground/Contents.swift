/*
 Given an integer array nums, return all the triplets 
 [nums[i], nums[j], nums[k]] such that
 i != j, i != k, and j != k,
 
 and nums[i] + nums[j] + nums[k] == 0.

 Notice that the solution set must not contain duplicate triplets.
 
 Дан целочисленный массив nums, вернуть все триплеты
 [nums[i], nums[j], nums[k]] такие, что
 i != j, i != k, и j != k,

 и nums[i] + nums[j] + nums[k] == 0.

 Обратите внимание, что набор решений не должен содержать повторяющихся триплетов.
  

 Example 1:

 Input: nums = [-1,0,1,2,-1,-4]
 Output: [[-1,-1,2],[-1,0,1]]

 Explanation:
 nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
 nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
 nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
 The distinct triplets are [-1,0,1] and [-1,-1,2].
 Notice that the order of the output and the order of the triplets does not matter.
 
 Example 2:

 Input: nums = [0,1,1]
 Output: []
 Explanation: The only possible triplet does not sum up to 0.
 */

func threeSum(_ nums: [Int]) -> [[Int]] {
    var result = [[Int]]()
    let sortedNums = nums.sorted()

    for i in 0..<sortedNums.count {
        // Пропускаем дубликаты
        if i > 0 && sortedNums[i] == sortedNums[i - 1] {
            continue
        }
        
        var left = i + 1
        var right = sortedNums.count - 1
        
        while left < right {
            let sum = sortedNums[i] + sortedNums[left] + sortedNums[right]
            if sum == 0 {
                result.append([sortedNums[i], sortedNums[left], sortedNums[right]])
                
                // Пропускаем дубликаты
                while left < right && sortedNums[left] == sortedNums[left + 1] {
                    left += 1
                }
                while left < right && sortedNums[right] == sortedNums[right - 1] {
                    right -= 1
                }
                
                left += 1
                right -= 1
                
            } else if sum < 0 {
                left += 1
            } else {
                right -= 1  
            }
        }
    }
    
    return result
}

 
let example1 = [-1, 0, 1, 2, -1, -4]
print(threeSum(example1)) // Вывод: [[-1, -1, 2], [-1, 0, 1]]

let example2 = [0, 1, 1]
print(threeSum(example2)) // Вывод: []
