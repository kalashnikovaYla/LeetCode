/*
 You are given a string s and an array of strings words. All the strings of words are of the same length.

 A concatenated string is a string that exactly contains all the strings of any permutation of words concatenated.

 For example, if words = ["ab","cd","ef"], then "abcdef", "abefcd", "cdabef", "cdefab", "efabcd", and "efcdab" are all concatenated strings. "acdbef" is not a concatenated string because it is not the concatenation of any permutation of words.
 Return an array of the starting indices of all the concatenated substrings in s. You can return the answer in any order.

 Вам дана строка s и массив строк words. Все строки words имеют одинаковую длину.

 concatenated string — это строка, которая содержит в точности все строки любой перестановки сцепленных слов.

 Например, если words = ["ab","cd","ef"], то "abcdef", "abefcd", "cdabef", "cdefab", "efabcd" и "efcdab" — это все сцепленные строки. "acdbef" не является сцепленной строкой, поскольку она не является конкатенацией какой-либо перестановки слов.
 Верните массив начальных индексов всех сцепленных подстрок в s. Вы можете вернуть ответ в любом порядке.
  

 Example 1:

 Input: s = "barfoothefoobarman", words = ["foo","bar"]

 Output: [0,9]

 Explanation:

 Подстрока, начинающаяся с 0, — это «barfoo». Это конкатенация [«bar», «foo»], которая является перестановкой слов.
 Подстрока, начинающаяся с 9, — это «foobar». Это конкатенация [«foo», «bar»], которая является перестановкой слов.

 Example 2:

 Input: s = "wordgoodgoodgoodbestword", words = ["word","good","best","word"]

 Output: []

 Explanation:

 There is no concatenated substring.

 Example 3:

 Input: s = "barfoofoobarthefoobarman", words = ["bar","foo","the"]

 Output: [6,9,12]

 Explanation:

 The substring starting at 6 is "foobarthe". It is the concatenation of ["foo","bar","the"].
 The substring starting at 9 is "barthefoo". It is the concatenation of ["bar","the","foo"].
 The substring starting at 12 is "thefoobar". It is the concatenation of ["the","foo","bar"].


 */

class Solution {
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        let wordLength = words.first!.count
        var wordsCounted = [String: Int]()

        for word in words {
            wordsCounted[word, default: 0] += 1
        }
        var result = Array<Int>()
        for i in 0 ..< wordLength {
            guard var wordStartIndex = s.index(s.startIndex, offsetBy: i, limitedBy: s.endIndex) else {
                break
            }
            var sAsWords = Array<String>()
            while true {
                guard let wordEndIndex = s.index(
                    wordStartIndex,
                    offsetBy: wordLength,
                    limitedBy: s.endIndex) else {
                    break
                }
                let word = String(s[wordStartIndex ..< wordEndIndex])
                sAsWords.append(word)
                wordStartIndex = wordEndIndex
            }
            let r = slidingWindow(sAsWords, wordsCounted, words.count)
            result += r.map { wordIndex in
                i + wordIndex * wordLength
            }
        }
        return result
    }
    
    func slidingWindow(_ s: [String], _ wordsCounted: Dictionary<String, Int>, _ wordCount: Int) -> [Int] {
        //print("slidingWindow \(s), wordsCounted=\(wordsCounted), wordCount=\(wordCount)")
        var remainingWords = wordsCounted
        var result = Array<Int>()
        var left = 0
        var right = 0
        while left + wordCount - 1 < s.count {
            let word = s[right]
            // print("left=\(left), right=\(right), word=\(word), remainingWords=\(remainingWords)")
            if let count = remainingWords[word] {
                if count > 0 {
                    remainingWords[word] = count - 1
                    right += 1
                    // print("right = \(right)")
                    if right - left == wordCount {
                        result.append(left)
                        // print("result = \(left)")
                        remainingWords[s[left]]! += 1
                        left += 1
                    } else if right >= s.count {
                        // print("right index out of bound")
                        break
                    }
                } else {
                    // word exists in permutation but valid count has all been seen
                    while remainingWords[word] == 0 {
                        remainingWords[s[left]]! += 1
                        left += 1
                        if left == right {
                            break
                        }
                    }
                    // print("valid word but too many used: left = \(left)")
                }
            } else {
                // print("invalid word")
                // word don't exist in permutations, any subarray containing it cannot be valid
                left = right + 1
                right = left
                remainingWords = wordsCounted
            }
        }
        return result
    }
}

Solution().findSubstring("barfoothefoobarman", ["foo","bar"])
