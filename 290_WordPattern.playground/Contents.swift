/*
 Given a pattern and a string s, find if s follows the same pattern.

 Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in s. Specifically:

 Each letter in pattern maps to exactly one unique word in s.
 Each unique word in s maps to exactly one letter in pattern.
 No two letters map to the same word, and no two words map to the same letter.
  

 Example 1:

 Input: pattern = "abba", s = "dog cat cat dog"

 Output: true

 Explanation:

 The bijection can be established as:

 'a' maps to "dog".
 'b' maps to "cat".
 */


func wordPattern(_ pattern: String, _ s: String) -> Bool {
    let words = s.split(separator: " ").map { String($0) }
    guard words.count == pattern.count else {
        return false
    }
    
    var charToWord: [Character: String] = [:]
    var wordToChar: [String: Character] = [:]  
    
    for (char, word) in zip(pattern, words) {
        if let existingWord = charToWord[char] {
            if existingWord != word {
                return false
            }
        } else {
            charToWord[char] = word
        }
         
        if let existingChar = wordToChar[word] {
            if existingChar != char {
                return false
            }
        } else {
            wordToChar[word] = char
        }
    }
    
    return true
}
