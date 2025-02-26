import Foundation

class Solution {
    func longestPalindrome(_ s: String) -> String {
    // Consider every index as center and expand to find longest palindrome at that index.
    // Check for both even length palindrome & odd length palindrome
        var string = Array(s)
        var longestPalindrome: (startIdx: Int, endIdx: Int) = (-1, -1)
        for idx in string.indices {
            let oddPalindrome = checkPalindrome(string: string, startIdx: idx, endIdx: idx)
            let evenPalindrome = checkPalindrome(string: string, startIdx: idx, endIdx: idx + 1)
            var maxPalindrome = oddPalindrome
            if evenPalindrome.endIdx - evenPalindrome.startIdx >= oddPalindrome.endIdx - oddPalindrome.startIdx {
                maxPalindrome = evenPalindrome
            }
            if maxPalindrome.endIdx - maxPalindrome.startIdx >= longestPalindrome.endIdx - longestPalindrome.startIdx {
                longestPalindrome = maxPalindrome
            }
        }
        return String(string[longestPalindrome.startIdx...longestPalindrome.endIdx])
    }

    func checkPalindrome(string: [Character], startIdx: Int, endIdx: Int) -> (startIdx: Int, endIdx: Int) {
        guard startIdx >= 0, endIdx < string.count, string[startIdx] == string[endIdx] else { return (startIdx, startIdx) }
        var startIdx = startIdx
        var endIdx = endIdx
        while startIdx - 1 >= 0, endIdx + 1 < string.count, string[startIdx - 1] == string[endIdx + 1] {
            startIdx -= 1
            endIdx += 1
        }
        return (startIdx, endIdx)
    }
}


func longestPalindrome(_ s: String) -> String {
    if s.isEmpty {
        return ""
    }

    var start = 0
    var end = 0

    for i in 0..<s.count {
        let len1 = expandAroundCenter(s, left: i, right: i)    // Для нечетной длины палиндрома
        let len2 = expandAroundCenter(s, left: i, right: i + 1) // Для четной длины палиндрома
        let len = max(len1, len2)

        if len > end - start {
            start = i - (len - 1) / 2
            end = i + len / 2
        }
    }

    let startIdx = s.index(s.startIndex, offsetBy: start)
    let endIdx = s.index(s.startIndex, offsetBy: end + 1)
    return String(s[startIdx..<endIdx])
}

private func expandAroundCenter(_ s: String, left: Int, right: Int) -> Int {
    print("expandAroundCenter", s, left, right)
    let sArray = Array(s)
    var leftIndex = left
    var rightIndex = right

    while leftIndex >= 0 && rightIndex < sArray.count && sArray[leftIndex] == sArray[rightIndex] {
        leftIndex -= 1
        rightIndex += 1
    }

    return rightIndex - leftIndex - 1
}

// Пример использования:
let input = "babad"
let result = longestPalindrome(input)
 
