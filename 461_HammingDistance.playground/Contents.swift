/*
 The Hamming distance between two integers is the number of positions at which the corresponding bits are different.

 Given two integers x and y, return the Hamming distance between them.
 
 Input: x = 1, y = 4
 Output: 2
 Explanation:
 1   (0 0 0 1)
 4   (0 1 0 0)
        ↑   ↑
 The above arrows point to positions where the corresponding bits are different.
 Example 2:

 Input: x = 3, y = 1
 Output: 1

 */


class Solution {
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        let xorResult = x ^ y
        
        // Счетчик для единиц
        var distance = 0
        
        // Подсчитываем количество единиц в xorResult
        var number = xorResult
        while number > 0 {
            distance += number & 1  // Проверяем последний бит
            number >>= 1            // Сдвигаем число вправо
        }
        
        return distance
    }
}

func hammingDistance(_ x: Int, _ y: Int) -> Int {
    var num1 = UInt(x)
    var num2 = UInt(y)
    
    var diff = 0
    while num1 != 0 || num2 != 0 {
        if (num1 & 1) != (num2 & 1) {
            diff += 1
        }
        
        num1 >>= 1
        num2 >>= 1
    }
    
    return diff
}
