/*
 Given two strings s and t of lengths m and n respectively, return the minimum window substring of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".

 The testcases will be generated such that the answer is unique.

  

 Example 1:

 Input: s = "ADOBECODEBANC", t = "ABC"
 Output: "BANC"
 Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.


 Example 2:

 Input: s = "a", t = "a"
 Output: "a"
 Explanation: The entire string s is the minimum window.
 
 
 Example 3:

 Input: s = "a", t = "aa"
 Output: ""
 Explanation: Both 'a's from t must be included in the window.
 Since the largest window of s only has one 'a', return empty string.

 
 Чтобы решить эту проблему, мы можем использовать подход скользящего окна вместе с двумя указателями, чтобы найти минимальную подстроку окна в данной строке. Цель состоит в том, чтобы найти наименьшее окно в строке, которое содержит все символы из указанной строки шаблона.
 В этом решении мы начинаем с подсчета частот символов в строке шаблона и хранения их в словаре. Затем мы инициализируем два указателя, «левый» и «правый», в начало строки. Мы пересматриваем строку с помощью «правого» указателя и отслеживаем символы и их частоты в текущем окне.
 Всякий раз, когда мы находим символ, который соответствует одному из требуемых символов, и его частота соответствует требуемой частоте, мы приуплачаем переменную счетчика. Если все необходимые символы найдены в текущем окне, мы пытаемся свернуть окно, перемещая указатель «левого» до тех пор, пока окно не перестанет быть действительным. Во время этого мы обновляем минимальную подстроку окна, если найдем окно меньшего размера.
 Мы повторяем процесс перемещения указателей и проверки достоверности окна, пока не доберемся до конца строки. Наконец, мы возвращаем минимальную подстроку окна, найденную во время итерации.
 */

class Solution {
    func minWindow(_ s: String, _ t: String) -> String {
        let sArray = Array(s)
        let tArray = Array(t)
        
        var dictT = [Character: Int]()
        for char in tArray {
            dictT[char, default: 0] += 1
        }
        
        let required = dictT.count
        
        var left = 0
        var right = 0
        var formed = 0
        var windowCounts = [Character: Int]()
        
        var minLength = Int.max
        var minLeft = 0
        var minRight = 0
        
        while right < sArray.count {
            let char = sArray[right]
            
            windowCounts[char, default: 0] += 1
            
            if let count = dictT[char], count == windowCounts[char] {
                formed += 1
            }
            
            while left <= right && formed == required {
                
                let startChar = sArray[left]
                let endChar = sArray[right]
                
                if minLength > right - left + 1 {
                    minLength = right - left + 1
                    minLeft = left
                    minRight = right
                }
                
                windowCounts[startChar, default: 0] -= 1
                if let count = dictT[startChar], windowCounts[startChar]! < count {
                    formed -= 1
                }
                left += 1
            }
            
            right += 1
        }
        
        return minLength == Int.max ? "" : String(sArray[minLeft...minRight])
    }
}





class Solution2 {
    func minWindow(_ s: String, _ t: String) -> String {
        if t.isEmpty {
            return ""
        }
        
        // window to map character count from t string
        var tMap: [Character: Int] = [:]
        
        // window to map character count from s string
        var sMap: [Character: Int] = [:]
        
        for char in t {
            tMap[char, default: 0] += 1
        }
        
        var have: Int = 0
        var need: Int = tMap.count
        var sArr = Array(s)
        var length = Int.max // since we want min length
        var res = 0
        var tuple = (-1, -1)
        var leftIndex = 0
        
        
        for rightIndex in 0..<s.count {
            
            let char = sArr[rightIndex]
            print(char)
            sMap[char, default: 0] += 1
            
            // проверяем, удовлетворяет ли количество символов в tMap количеству символов в sMap
            // tMap[char] != nil -> проверяем, существует ли символ в tMap или нет, так как нас не интересуют символы, которых нет в tMap
            if tMap[char] != nil, tMap[char] == sMap[char] {
                have += 1
            }
            
            // if you find a new min result then update
            while have == need {
                print("have == need")
                // rightIndex - left + 1 = size of current window
                if rightIndex - leftIndex + 1 < length {
                    length = rightIndex - leftIndex + 1
                    tuple = (leftIndex, rightIndex) // left index and right index of current window
                }
                
                // pop from the left of the window
                sMap[sArr[leftIndex], default: 0] -= 1
                
                // КОГДА мы выталкиваем элементы слева, возможно, что условие have больше не выполняется

                // если sArr[leftIndex] — один из символов, который нам нужен для выполнения условия
                if tMap[sArr[leftIndex]] != nil, sMap[sArr[leftIndex]]! < tMap[sArr[leftIndex]]! {
                    have -= 1
                }
                // when we meet the condition, we have to move left pointer
                leftIndex += 1
            }
            
        }
        
        if length < Int.max {
            return String(sArr[tuple.0...tuple.1])
        }
        return ""
    }
}
Solution2().minWindow("APBANC", "ABC")
