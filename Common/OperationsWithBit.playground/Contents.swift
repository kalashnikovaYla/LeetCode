
//MARK: - И (AND): `&
///Используется для установки битов на 1, только если они равны 1 в обоих операндах.

let a: UInt8 = 0b1100_1100
let b: UInt8 = 0b1010_1010
let resultAnd = a & b // Результат: 0b1000_1000


//MARK: - *ИЛИ (OR)*: `|`
///Используется для установки битов на 1, если хотя бы один из операндов равен 1.

let resultOr = a | b // Результат: 0b1110_1110

//MARK: -  *Исключающее ИЛИ (XOR)*: `^

///Используется для установки битов на 1, если только один из операндов равен 1.
let resultXOR = a ^ b // Результат: 0b0110_0110


//MARK: - Негувирование (NOT): `~`

///Возвращает побитовый инверс (негатив) значения.

let resultNot = ~a // Результат: 0b0011_0011 (в зависимости от количества бит)

//MARK: - Сдвиг влево: `<<`
///Сдвигает биты влево на заданное количество позиций. Это эквивалентно умножению числа на 2 в степени сдвига.

let resultLeft = a << 2 // Результат: 0b0011_0010_0000

//MARK: - Сдвиг вправо: `>>`
///Сдвигает биты вправо на заданное количество позиций. Это эквивалентно целочисленному делению на 2 в степени сдвига.

let resultRight = a >> 2 // Результат: 0b0011_0000


//Установка флага
var flags: UInt8 = 0b0000_0000
flags |= 0b0000_0001 // Устанавливаем первый флаг

//Сброс флага
flags &= ~0b0000_0001 // Сбрасываем первый флаг

// Проверка флага
if flags & 0b0000_0001 != 0 {
    print("Первый флаг установлен")
} else {
    print("Первый флаг не установлен")
}

func fromIntToDecimal(nums: [Int]) -> Int {
    var decimal = 0
    var base = 1
    
    for digit in nums {
        if digit != 0 && digit != 1 {
            return 0
        }
    }
    
    for digit in nums.reversed() {
        if digit == 1 {
            decimal += base
        }
        base *= 2
    }
    
    return decimal
}

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


 
func hammingDistance(_ x: Int, _ y: Int) -> Int {
    let xorResult = x ^ y
    
    var distance = 0
    
    var number = xorResult
    while number > 0 {
        distance += number & 1
        number >>= 1
    }
    
    return distance
}



/*
 Given two binary strings a and b, return their sum as a binary string.

 Example 1:

 Input: a = "11", b = "1"
 Output: "100"
 
 Example 2:
 
 Input: a = "1010", b = "1011"
 Output: "10101"
 
 */
func addBinary(_ a: String, _ b: String) -> String {
    var result = ""
    var aLength = a.count - 1, bLength = b.count - 1
    var carry = 0

    while aLength >= 0 || bLength >= 0 {
        //не забываем учесть carry
        var totalSum = carry
        if aLength >= 0 {
            totalSum += Int(String(a[a.index(a.startIndex, offsetBy: aLength)]))!
            aLength -= 1
        }
        if bLength >= 0 {
            totalSum += Int(String(b[b.index(b.startIndex, offsetBy: bLength)]))!
            bLength -= 1
        }
        
        //добавляем элемент именно в начало 
        result = String(totalSum % 2) + result
        carry = totalSum / 2
    }

    if carry > 0 {
        result = String(1) + result
    }
    return result
}

//числа могут встретится 1 или 2 раза, но не более того. нужно вывести то число, которое встречается только 1 раз
///x ^ x = 0
///4  ^ 4 = 0
func singleNumber(_ nums: [Int]) -> Int {
    var result = 0
    for num in nums {
        result ^= num
    }
    return result
}
