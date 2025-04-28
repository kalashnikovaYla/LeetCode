
/*

 Дан массив положительных целых чисел nums, вернуть максимально возможную сумму строго возрастающего подмассива в nums.

 Подмассив определяется как непрерывная последовательность чисел в массиве.

 Example 1:

 Input: nums = [10,20,30,5,10,50]
 Output: 65
 Explanation: [5,10,50] is the ascending subarray with the maximum sum of 65.

 Example 2:

 Input: nums = [10,20,30,40,50]
 Output: 150
 Explanation: [10,20,30,40,50] is the ascending subarray with the maximum sum of 150.

 Example 3:

 Input: nums = [12,17,15,13,10,11,12]
 Output: 33
 Explanation: [10,11,12] is the ascending subarray with the maximum sum of 33.
 
 нужно вернуть максимально возможную сумму строго возрастающего подмассива
 
 мы ставим maxSum на 1 элемент, sum на 1 элемент
 low == 0 hight == 1
 и начиная с 1 элемента проверяем, что nums[hight - 1] < nums[hight]
 */


func maxAscendingSum(_ nums: [Int]) -> Int {
    var maxSum = nums.first ?? 0
    var currerntSum = nums.first ?? 0
    var low = 0
    var hight = 1
   
    while hight < nums.count {
        if nums[hight - 1] < nums[hight] {
            currerntSum += nums[hight]
            hight += 1
            if currerntSum > maxSum {
                maxSum = currerntSum
            }
        } else {
            low = hight
            hight = low + 1
            currerntSum = nums[low]
        }
    }
    return maxSum
}

maxAscendingSum([12, 17, 15, 13, 10, 11, 12])
