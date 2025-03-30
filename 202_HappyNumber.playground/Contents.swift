 /*
  Write an algorithm to determine if a number n is happy.

  A happy number is a number defined by the following process:

  Starting with any positive integer, replace the number by the sum of the squares of its digits.
  Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
  Those numbers for which this process ends in 1 are happy.
  Return true if n is a happy number, and false if not.
  
  Напишите алгоритм для определения того, является ли число n счастливым. Счастливое число — это число, определяемое следующим процессом:

  Начиная с любого положительного целого числа, замените число суммой квадратов его цифр. Повторяйте процесс, пока число не станет равным 1 (где оно и останется), или пока оно не зациклится бесконечно в цикле, который не включает 1.
  Те числа, для которых этот процесс заканчивается на 1, являются счастливыми.
  Верните true, если n является счастливым числом, и false, если нет.

  Example 1:

  Input: n = 19
  Output: true
  Explanation:
  1(2) + 9(2) = 82
  8(2) + 2(2) = 68
  6(2) + 8(2) = 100
  1(2) + 0(2) + 02 = 1
 
  Example 2:

  Input: n = 2
  Output: false
  */

class Solution {
    func isHappy(_ n: Int) -> Bool {
        var seenNumbers = Set<Int>()
        var currentNumber = n
        
        while currentNumber != 1 {
            if seenNumbers.contains(currentNumber) {
                return false
            }
            seenNumbers.insert(currentNumber)
            
            var nextNumber = 0
            var temp = currentNumber
            while temp > 0 {
                let digit = temp % 10
                nextNumber += digit * digit
                temp /= 10
            }
            
            currentNumber = nextNumber
        }
        return true
    }
}


func isHappy(_ n: Int) -> Bool {
    var seen = Set<Int>()
    var ans = n
    while (ans != 1 && !seen.contains(ans)) {
        seen.insert(ans)
        var res: Int = 0
        while (ans > 0) {
            var remainder = ans % 10
            res += (remainder * remainder)
            ans = ans / 10
        }
        ans = res
    }
    
    return ans == 1
}
