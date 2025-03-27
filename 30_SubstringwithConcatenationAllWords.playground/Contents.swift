/*
 You are given a string s and an array of strings words. All the strings of words are of the same length.

 A concatenated string is a string that exactly contains all the strings of any permutation of words concatenated.

 For example, if words = ["ab","cd","ef"], then "abcdef", "abefcd", "cdabef", "cdefab", "efabcd", and "efcdab" are all concatenated strings. "acdbef" is not a concatenated string because it is not the concatenation of any permutation of words.
 Return an array of the starting indices of all the concatenated substrings in s. You can return the answer in any order.

  

 Example 1:

 Input: s = "barfoothefoobarman", words = ["foo","bar"]

 Output: [0,9]

 Explanation:

 The substring starting at 0 is "barfoo". It is the concatenation of ["bar","foo"] which is a permutation of words.
 The substring starting at 9 is "foobar". It is the concatenation of ["foo","bar"] which is a permutation of words.

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
        let wordsCounted = words.reduce(into: Dictionary<String, Int>()) { wordsCounted, word in
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
        // print("slidingWindow \(s), wordsCounted=\(wordsCounted), wordCount=\(wordCount)")
        var state = State(wordsCounted)
        var result = Array<Int>()
        while state.left + wordCount - 1 < s.count {
            let word = s[state.right]
            // print("left=\(left), right=\(right), word=\(word), remainingWords=\(remainingWords)")
            if let count = state.remainingWords[word] {
                if count > 0 {
                    state.remainingWords[word] = count - 1
                    state.right += 1
                    if state.windowSize == wordCount {
                        result.append(state.left)
                        state.advanceLeft(s)
                    } else if state.right >= s.count {
                        // print("right index out of bound")
                        break
                    }
                } else {
                    // word exists in permutation but valid count has all been seen
                    while state.remainingWords[word] == 0 {
                        state.advanceLeft(s)
                        if state.left == state.right {
                            break
                        }
                    }
                    // print("valid word but too many used: left = \(left)")
                }
            } else {
                // print("invalid word")
                // word don't exist in permutations, any subarray containing it cannot be valid
                state.resetWindow()
            }
        }
        return result
    }
}

struct State {
    var left: Int
    var right: Int
    let wordsCounted: Dictionary<String, Int>
    var remainingWords: Dictionary<String, Int>

    var windowSize: Int {
        right - left
    }

    init(_ wordsCounted: Dictionary<String, Int>) {
        self.left = 0
        self.right = 0
        self.wordsCounted = wordsCounted
        self.remainingWords = wordsCounted
    }

    mutating func advanceLeft(_ s: [String]) {
        remainingWords[s[left]]! += 1
        left += 1
    }

    mutating func resetWindow() {
        left = right + 1
        right = left
        remainingWords = wordsCounted
    }
}
