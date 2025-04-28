/*
 Given two binary strings a and b, return their sum as a binary string.

 Example 1:

 Input: a = "11", b = "1"
 Output: "100"
 
 Example 2:
 
 Input: a = "1010", b = "1011"
 Output: "10101"
 
 */

import Foundation
func addBinary(_ a: String, _ b: String) -> String {
    var result = ""
    var aLength = a.count - 1, bLength = b.count - 1
    var carry = 0

    while aLength >= 0 || bLength >= 0 {
        var totalSum = carry
        if aLength >= 0 {
            totalSum += Int(String(a[a.index(a.startIndex, offsetBy: aLength)]))!
            aLength -= 1
        }
        if bLength >= 0 {
            totalSum += Int(String(b[b.index(b.startIndex, offsetBy: bLength)]))!
            bLength -= 1
        }
        
        //Вставляем именно в начало
        result = String(totalSum % 2) + result
        carry = totalSum / 2
    }

    if carry > 0 {
        result = String(1) + result
    }
    return result
}
