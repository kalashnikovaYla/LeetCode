/*
 Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order, find two numbers such that they add up to a specific target number. Let these two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 <= numbers.length.

 Return the indices of the two numbers, index1 and index2, added by one as an integer array [index1, index2] of length 2.

 The tests are generated such that there is exactly one solution. You may not use the same element twice.

 Your solution must use only constant extra space.

 Дано 1-индексный массив целых чисел, который уже отсортирован в неубывающем порядке, найдите два числа, которые в сумме дают определенное целевое число. Пусть эти два числа будут numbers[index1] и numbers[index2], где 1 <= index1 < index2 <= numbers.length.

 Верните индексы двух чисел, index1 и index2, сложенные на единицу, как целочисленный массив [index1, index2] длины 2.

 Тесты генерируются таким образом, что существует ровно одно решение. Вы не можете использовать один и тот же элемент дважды.

 Ваше решение должно использовать только постоянное дополнительное пространство.
  

 Example 1:

 Input: numbers = [2,7,11,15], target = 9
 Output: [1,2]
 Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].

 Example 2:

 Input: numbers = [2,3,4], target = 6
 Output: [1,3]
 Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].

 */


//Массив отсортирован в неубывающем порядке, так что бинарный поиск
class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = numbers.count - 1
        
        while left < right {
            let sum = numbers[left] + numbers[right]
            if sum == target {
                return [left + 1, right + 1]
            } else if sum < target {
                left += 1
            } else {
                right -= 1
            }
        }
        
        
        return []
    }
}

Solution().twoSum([2,7,11,15], 9)
