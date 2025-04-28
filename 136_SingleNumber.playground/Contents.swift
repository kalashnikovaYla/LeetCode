/*
 Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

 You must implement a solution with a linear runtime complexity and use only constant extra space.

 Дано непустое множество целых чисел nums, каждый элемент встречается дважды, за исключением одного. Найдите этот единственный элемент.

 Вам необходимо реализовать решение с линейной сложностью выполнения и использовать только постоянное дополнительное пространство.

 Example 1:

 Input: nums = [2,2,1]

 Output: 1

 Example 2:

 Input: nums = [4,1,2,1,2]

 Output: 4

 Example 3:

 Input: nums = [1]

 Output: 1
 
 В конце цикла в переменной `result` будет храниться то число, которое встречается только один раз, так как все остальные числа, которые встречаются по два раза, "обнулятся".

 Таким образом, функция `singleNumber` возвращает единственное число, которое не имеет пары в массиве.

 Пример работы функции:
 - Для входного массива `[4, 1, 2, 1, 2]`:
   - XOR (4) = 4
   - XOR (1) = 4 ^ 1 = 5
   - XOR (2) = 5 ^ 2 = 7
   - XOR (1) = 7 ^ 1 = 6
   - XOR (2) = 6 ^ 2 = 4
 - В итоге останется только число `4`, которое встречается единожды.
 
 
 Элементы могут встретиться 1 или 2 раза, не более 
 */


func singleNumber(_ nums: [Int]) -> Int {
    var result = 0
    for num in nums {
        result ^= num
    }
    return result
}
