/*
 Given two strings ransomNote and magazine, return true if ransomNote can be constructed by using the letters from magazine and false otherwise.

 Each letter in magazine can only be used once in ransomNote.

  

 Example 1:

 Input: ransomNote = "a", magazine = "b"
 Output: false
 
 Example 2:

 Input: ransomNote = "aa", magazine = "ab"
 Output: false
 
 Example 3:
 Input: ransomNote = "aa", magazine = "aab"
 Output: true
 
 мы собрали наш словарь, и пошли перебирать все карактерс
 когда перебираем и находим, делаем у этого элемента count -= 1
 
 если count == 0 return false 
 */


class Solution {

    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {

        let magazineArray = Array(magazine.utf8)
        let noteArray = Array(ransomNote.utf8)
        var hashTable = Array(repeating: 0, count: 256)
        
        for item in magazineArray {
            hashTable[Int(item)] += 1
        }

        for item in noteArray {
            if hashTable[Int(item)] == 0 {
                return false
            } else {
                hashTable[Int(item)] -= 1
            }
        }

        return true
        
    }
}
Solution().canConstruct("aa", "aab")

///Буквы у нас в диапозоне [97 - 122] 
func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    guard ransomNote.count <= magazine.count else {
        return false
    }
    var arr = Array(repeating: 0, count: 26)
    for i in magazine.utf8 {
        arr[Int(i)-97] += 1
    }
    
    for i in ransomNote.utf8 {
        if  arr[Int(i)-97] == 0 {
            return false
        } else {
            arr[Int(i)-97] -= 1
        }
    }
    return true
}
