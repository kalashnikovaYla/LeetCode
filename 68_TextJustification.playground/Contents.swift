/*
 Given an array of strings words and a width maxWidth, format the text such that each line has exactly maxWidth characters and is fully (left and right) justified.

 You should pack your words in a greedy approach; that is, pack as many words as you can in each line. Pad extra spaces ' ' when necessary so that each line has exactly maxWidth characters.

 Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line does not divide evenly between words, the empty slots on the left will be assigned more spaces than the slots on the right.

 For the last line of text, it should be left-justified, and no extra space is inserted between words.

 Note:

 A word is defined as a character sequence consisting of non-space characters only.
 Each word's length is guaranteed to be greater than 0 and not exceed maxWidth.
 The input array words contains at least one word.
 */

struct Line {
    let maxWidth: Int

    var words: [String] = []
    var wordsLength: Int = 0 // total words + 1 space per word (an extra space is always counted)

    mutating func addWord(_ newWord: String) -> Bool {
        let spaces_needed = words.count
        let newMinWidth = self.wordsLength + newWord.count + spaces_needed
        if newMinWidth > self.maxWidth {
            return false
        }
        words.append(newWord)
        self.wordsLength += newWord.count
        return true
    }

    func justify(_ leftOnly: Bool = false) -> String {
        let seperators = words.count - 1
        if leftOnly || seperators == 0 {
            var ret = words.joined(separator: " ")
            while ret.count < self.maxWidth {
                ret += " "
            }
            return ret
        }
        let num_spaces = self.maxWidth - self.wordsLength
        let space_per_seprator = num_spaces / seperators
        var remainders = num_spaces % seperators
        
        var seperator = String(repeating: " ", count: space_per_seprator)
        var ret = String()
        for (i, w) in words.enumerated() {
            ret += w
            if i != (words.count - 1) {
                ret += seperator
                if remainders > 0 {
                    ret += " "
                    remainders -= 1
                }
            }
        }
        return ret
    }
}


class Solution {
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        var lines : [Line] = []
        var currentLine = Line(maxWidth: maxWidth)
        for w in words {
            if !currentLine.addWord(w) {
                lines.append(currentLine)
                currentLine = Line(maxWidth: maxWidth)
                currentLine.addWord(w) // assuming this first word always works
            }
        }
        if !currentLine.words.isEmpty {
            lines.append(currentLine)
        }

        var result: [String] = []
        for (i, line) in lines.enumerated() {
            result.append(line.justify((i == lines.count-1)))
        }

        return result
    }
}
