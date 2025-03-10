 /*
  A pangram is a sentence where every letter of the English alphabet appears at least once.
  Given a string sentence containing only lowercase English letters, return true if sentence is a pangram, or false otherwise
  */


func isPangram(_ sentence: String) -> Bool {
    let alphabet = Set("abcdefghijklmnopqrstuvwxyz")
    let sentenceSet = Set(sentence)
    
    return alphabet.isSubset(of: sentenceSet)
}

isPangram("the quick brown fox jumps over the lazy dog")
