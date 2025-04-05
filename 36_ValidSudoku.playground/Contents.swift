/*
 Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:

 Each row must contain the digits 1-9 without repetition.
 Each column must contain the digits 1-9 without repetition.
 Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.

 Note:

 A Sudoku board (partially filled) could be valid but is not necessarily solvable.
 Only the filled cells need to be validated according to the mentioned rules.
 
 Input: board =
 [["5","3",".",".","7",".",".",".","."]
 ,["6",".",".","1","9","5",".",".","."]
 ,[".","9","8",".",".",".",".","6","."]
 ,["8",".",".",".","6",".",".",".","3"]
 ,["4",".",".","8",".","3",".",".","1"]
 ,["7",".",".",".","2",".",".",".","6"]
 ,[".","6",".",".",".",".","2","8","."]
 ,[".",".",".","4","1","9",".",".","5"]
 ,[".",".",".",".","8",".",".","7","9"]]
 Output: true

 Input: board =
 [["8","3",".",".","7",".",".",".","."]
 ,["6",".",".","1","9","5",".",".","."]
 ,[".","9","8",".",".",".",".","6","."]
 ,["8",".",".",".","6",".",".",".","3"]
 ,["4",".",".","8",".","3",".",".","1"]
 ,["7",".",".",".","2",".",".",".","6"]
 ,[".","6",".",".",".",".","2","8","."]
 ,[".",".",".","4","1","9",".",".","5"]
 ,[".",".",".",".","8",".",".","7","9"]]
 Output: false
 Explanation: Same as Example 1, except with the 5 in the top left corner being modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is invalid.
 */


class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        for x in 0..<9 {
            var row = Set<Character>()
            for y in 0..<9 {
                let element = board[x][y]
                if element == "." {
                    continue
                } else if row.contains(element) {
                    return false
                } else {
                    row.insert(element)
                }
            }
        }
        for y in 0..<9 {
            var column = Set<Character>()
            for x in 0..<9 {
                let element = board[x][y]
                if element == "." {
                    continue
                } else if column.contains(element) {
                    return false
                } else {
                    column.insert(element)
                }
            }
        }
        for b in 0..<9 {
            var boxes = Set<Character>()
            for i in b / 3 * 3..<b / 3 * 3 + 3 {
                for j in b % 3 * 3..<b % 3 * 3 + 3 {
                    let element = board[i][j]
                    if element == "." {
                        continue
                    } else if boxes.contains(element) {
                        return false
                    } else {
                        boxes.insert(element)
                    }
                }
            }
        }
        return true
    }
}


func isValidSudoku(_ board: [[Character]]) -> Bool {
    var rows = [Set<Character>](repeating: Set<Character>(), count: 9)
    var cols = [Set<Character>](repeating: Set<Character>(), count: 9)
    var boxes = [Set<Character>](repeating: Set<Character>(), count: 9)
    
    for i in 0..<9 {
        for j in 0..<9 {
            let num = board[i][j]
            if num != "." {
                // Determine the index for the 3x3 box
                let boxIndex = (i / 3) * 3 + (j / 3)
                
                // Check if we've seen this number in the same row, column or box
                if rows[i].contains(num) ||
                    cols[j].contains(num) ||
                    boxes[boxIndex].contains(num) {
                    return false
                }
                
                // Add the number to the respective sets
                rows[i].insert(num)
                cols[j].insert(num)
                boxes[boxIndex].insert(num)
            }
        }
    }
    return true
    
}


isValidSudoku([["5","3",".",".","7",".",".",".","."],["6",".",".","1","9","5",".",".","."],[".","9","8",".",".",".",".","6","."],["8",".",".",".","6",".",".",".","3"],["4",".",".","8",".","3",".",".","1"],["7",".",".",".","2",".",".",".","6"],[".","6",".",".",".",".","2","8","."],[".",".",".","4","1","9",".",".","5"],[".",".",".",".","8",".",".","7","9"]])
