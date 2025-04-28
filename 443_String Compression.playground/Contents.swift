/*
 Given an array of characters chars, compress it using the following algorithm:

 Begin with an empty string s. For each group of consecutive repeating characters in chars:

 If the group's length is 1, append the character to s.
 Otherwise, append the character followed by the group's length.
 The compressed string s should not be returned separately, but instead, be stored in the input character array chars. Note that group lengths that are 10 or longer will be split into multiple characters in chars.

 After you are done modifying the input array, return the new length of the array.

 You must write an algorithm that uses only constant extra space.

  
 Дан массив символов chars, сожмите его, используя следующий алгоритм:

 Начните с пустой строки s. Для каждой группы последовательных повторяющихся символов в chars:

 Если длина группы равна 1, добавьте символ к s.
 В противном случае добавьте символ, за которым следует длина группы.

 Сжатая строка s не должна возвращаться отдельно, а вместо этого должна храниться во входном массиве символов chars. Обратите внимание, что длина группы, которая составляет 10 или больше, будет разделена на несколько символов в chars.

 После того, как вы закончите изменять входной массив, верните новую длину массива.

 Вы должны написать алгоритм, который использует только постоянное дополнительное пространство.
 
 Example 1:

 Input: chars = ["a","a","b","b","c","c","c"]
 Output: Return 6, and the first 6 characters of the input array should be: ["a","2","b","2","c","3"]
 Explanation: The groups are "aa", "bb", and "ccc". This compresses to "a2b2c3".

 Example 2:

 Input: chars = ["a"]
 Output: Return 1, and the first character of the input array should be: ["a"]
 Explanation: The only group is "a", which remains uncompressed since it's a single character.

 Example 3:

 Input: chars = ["a","b","b","b","b","b","b","b","b","b","b","b","b"]
 Output: Return 4, and the first 4 characters of the input array should be: ["a","b","1","2"].
 Explanation: The groups are "a" and "bbbbbbbbbbbb". This compresses to "ab12".
 
 
 идея в том, чтобы не использовать дополнительное пространство
 остатки после write нас не волнуют 
 
 write - по нему будем записывать элемент в массив
 
 Будем двигать readIndex и считать count пока у нас последующие элементы равны
 
 начнем с 0 оба
 
 добавили букву writeIndex + 1, цифру тоже += 1 
 */

func compress(_ chars: inout [Character]) -> Int {
    var writeIndex = 0
    
    var readIndex = 0
    
    while readIndex < chars.count {
        let currentChar = chars[readIndex]
        var count = 0
        
        while readIndex < chars.count && chars[readIndex] == currentChar {
            //Двигаем readIndex пока элементы одинаковые
            readIndex += 1
            count += 1
        }
        
        chars[writeIndex] = currentChar
        writeIndex += 1
        
        
        if count > 1 {
            let countString = String(count)
            for digitChar in countString {
                chars[writeIndex] = digitChar
                writeIndex += 1
            }
        }
    }
    
    return writeIndex
}

var chars: [Character] =  ["a","a","b","b","b","c","c","c"]
compress(&chars)
print(chars)
