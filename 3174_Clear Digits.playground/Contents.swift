import UIKit

//3174. Clear Digits
func clearDigits(_ s: String) -> String {
    var result = [Character]()
     for char in s {
         if char.isWholeNumber {
             if !result.isEmpty {
                 result.removeLast()
             }
         } else {
             result.append(char)
         }
     }
     return String(result)
}

clearDigits("cb34")
