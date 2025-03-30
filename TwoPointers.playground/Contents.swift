import UIKit

//Дана отосортированная последовательность чисел длинной N и число K. Найти количество чисел A и B, таких что B + A > K

func findSum(nums: [Int], target: Int) -> Int {
    var countPairs = 0
    
    var last = 0
    
    for first in 0..<nums.count {
         
        while last < nums.count && nums[last] + nums[first] <= target {
            print(nums[last], nums[first])
            last += 1
        }
        countPairs += nums.count - last 
    }
    return countPairs
}

findSum(nums: [1,4,5,6], target: 90)
