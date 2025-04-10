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
 

class Solution2 {
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
         
        let wordLength = words.first!.count
        let totalConcatLength = wordLength * words.count
     
        guard s.count >= totalConcatLength else { return [] }

        // Create a frequency map of the words
        var wordFrequencyMap: [[UInt8]: Int] = [:]
        for word in words {
            let wordBytes = word.map {
                $0.asciiValue!
            }
            wordFrequencyMap[wordBytes, default: 0] += 1
        }

        
        var resultIndices: [Int] = []
        
        s.utf8.withContiguousStorageIfAvailable { inputBuffer in
             
            for startOffset in 0..<wordLength {
                 
                var currentWindowMap: [[UInt8]: Int] = [:]
                
                for pos in stride(from: startOffset, to: inputBuffer.count, by: wordLength) {
                    print(pos)
                    if pos + wordLength <= inputBuffer.count {
                        
                        let wordSlice = Array(inputBuffer[pos..<pos + wordLength])
                        print("wordSlice", wordSlice)
                        if wordFrequencyMap[wordSlice] != nil {
                            currentWindowMap[wordSlice, default: 0] += 1
                        }
                         
                        if pos + wordLength >= totalConcatLength {
                            if currentWindowMap == wordFrequencyMap {
                                resultIndices.append(pos + wordLength - totalConcatLength)
                            }
                             
                            let removeStart = pos + wordLength - totalConcatLength
                            let removeSlice = Array(inputBuffer[removeStart..<removeStart + wordLength])
                            if wordFrequencyMap[removeSlice] != nil {
                                currentWindowMap[removeSlice, default: 0] -= 1
                            }
                        }
                    }
                }
            }
        }
        return resultIndices
    }
}
 

func findSubstring3(_ s: String, _ words: [String]) -> [Int] {
    let wordLength = words.first!.count
    let totalConcatLength = wordLength * words.count

    guard s.count >= totalConcatLength else { return [] }

 
    var wordFrequencyMap: [String: Int] = [:]
    for word in words {
        wordFrequencyMap[word, default: 0] += 1
    }

    var resultIndices: [Int] = []

  
    for startIndex in 0...(s.count - totalConcatLength) {
        var currentWindowMap: [String: Int] = [:]

        for i in 0..<words.count {
            let wordIndex = startIndex + i * wordLength
            let start = s.index(s.startIndex, offsetBy: wordIndex)
            let end = s.index(s.startIndex, offsetBy: wordIndex + wordLength)
            let word = String(s[start..<end])

            if let count = wordFrequencyMap[word] {
                currentWindowMap[word, default: 0] += 1

                if currentWindowMap[word]! > count {
                   
                    break
                }
            } else {
                 
                break
            }
        }

        if currentWindowMap == wordFrequencyMap {
            resultIndices.append(startIndex)
        }
    }

    return resultIndices
}
