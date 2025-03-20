/*
 Given a string s that contains parentheses and letters, remove the minimum number of invalid parentheses to make the input string valid.

 Return a list of unique strings that are valid with the minimum number of removals. You may return the answer in any order.

  

 Example 1:

 Input: s = "()())()"
 Output: ["(())()","()()()"]
 Example 2:

 Input: s = "(a)())()"
 Output: ["(a())()","(a)()()"]
 
 Example 3:

 Input: s = ")("
 Output: [""]
 */


class Solution {
    func removeInvalidParentheses(_ s: String) -> [String] {
        var ans = [String]()
        remove(s, &ans, 0, 0, ["(", ")"])
        return ans
        
        
    }
    
    func remove(_ s: String, _ ans: inout [String], _ last_i: Int, _ last_j: Int, _ par: [Character]) {
        var stack = 0
        
        for i in last_i..<s.count {
            let index = s.index(s.startIndex, offsetBy: i)
            if s[index] == par[0] {
                stack += 1
            }
            if s[index] == par[1] {
                stack -= 1
            }
            if stack >= 0 {
                continue
            }
            
            for j in last_j...i {
                let jIndex = s.index(s.startIndex, offsetBy: j)
                if s[jIndex] == par[1] && (j == last_j || s[s.index(before: jIndex)] != par[1]) {
                    let newString = s.prefix(upTo: jIndex) + s.suffix(from: s.index(after: jIndex))
                    remove(String(newString), &ans, i, j, par)
                }
            }
            return
        }
        
        let reversed = String(s.reversed())
        if par[0] == "(" {
            remove(reversed, &ans, 0, 0, [")", "("])
        } else {
            ans.append(reversed)
        }
    }
}
