 /*
  Reverse bits of a given 32 bits unsigned integer.
  Input: n = 00000010100101000001111010011100
  Output:    964176192 (00111001011110000010100101000000)
  Explanation: The input binary string 00000010100101000001111010011100 represents the unsigned integer 43261596, so return 964176192 which its binary representation is 00111001011110000010100101000000.
  
  //разворот (обратный порядок) битов 32-битного целого числа `n`
  */


class Solution {
    func reverseBits(_ n: Int) -> Int {
        var n = n
        var reversed: Int = 0
        for i in 0..<32 {
            // Сдвигаем reversed влево на 1 бит
            reversed <<= 1
            // Добавляем последний бит n (проверьте его с помощью побитовой операции &)
            reversed |= (n & 1)
            // Сдвигаем n вправо на 1 бит, чтобы обработать следующий бит
            n >>= 1
        }
        return reversed
    }
}

 
