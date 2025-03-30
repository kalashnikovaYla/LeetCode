import UIKit

/*
 A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

 Given a string s, return true if it is a palindrome, or false otherwise.

  

 Example 1:

 Input: s = "A man, a plan, a canal: Panama"
 Output: true
 Explanation: "amanaplanacanalpanama" is a palindrome.
 Example 2:

 Input: s = "race a car"
 Output: false
 Explanation: "raceacar" is not a palindrome.
 Example 3:

 Input: s = " "
 Output: true
 Explanation: s is an empty string "" after removing non-alphanumeric characters.
 Since an empty string reads the same forward and backward, it is a palindrome.

 */

func isPalindrome(_ s: String) -> Bool {

    if s.isEmpty {
        return true
    }
    var str = s.lowercased()
    
    var left = 0
    var right = str.count - 1
    
    while left < right {
        let leftChar = str[str.index(str.startIndex, offsetBy: left)]
        let rightChar = str[str.index(str.startIndex, offsetBy: right)]
        
        if !(leftChar.isNumber || leftChar.isLetter) {
            left += 1
        } else if !(rightChar.isNumber || rightChar.isLetter) {
            right -= 1
        } else {
            if leftChar != rightChar {
                return false
            }
            left += 1
            right -= 1
        }
    }
    
    return true
}

isPalindrome("A man, a plan, a canal: Panama")
 

func checkPalindrome(_ s: String) -> Bool {
    let str = s.filter{$0.isNumber || $0.isLetter}.lowercased()
    return String(str.reversed()) == str
}


func palindrome(_ s: String) -> Bool {
    var sArray = Array(s)
    var leftP = 0
    var rightP = sArray.count - 1
    
    while leftP < rightP {
        while leftP < rightP, !alphaNumerical(sArray[leftP]) {
            leftP += 1
        }
        while leftP < rightP, !alphaNumerical(sArray[rightP]) {
            rightP -= 1
        }
        
        if sArray[leftP].lowercased() != sArray[rightP].lowercased() {
            return false
        }
        
        leftP += 1
        rightP -= 1
    }
    
    return true
}

func alphaNumerical(_ char: Character) -> Bool {
    let asciiValue = char.asciiValue ?? 0
    return (asciiValue >= 48 && asciiValue <= 57) ||  // '0'-'9'
    (asciiValue >= 65 && asciiValue <= 90) ||  // 'A'-'Z'
    (asciiValue >= 97 && asciiValue <= 122) //'a'-'z'
}
