/*
 The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

 P   A   H   N
 A P L S I I G
 Y   I   R
 And then read line by line: "PAHNAPLSIIGYIR"

 Write the code that will take a string and make this conversion given a number of rows:

 string convert(string s, int numRows);
  

 Example 1:

 Input: s = "PAYPALISHIRING", numRows = 3
 Output: "PAHNAPLSIIGYIR"
 Example 2:

 Input: s = "PAYPALISHIRING", numRows = 4
 Output: "PINALSIGYAHRPI"
 Explanation:
 P     I    N
 A   L S  I G
 Y A   H R
 P     I
 Example 3:

 Input: s = "A", numRows = 1
 Output: "A"
  
 */

func convert(_ s: String, _ numRows: Int) -> String {
    
    if numRows <= 1 || numRows >= s.count {
        return s
    }

    var rows = [String](repeating: "", count: numRows)
    
    var currentRow = 0
    var goingDown = false
    
    
    for char in s {
        rows[currentRow].append(char)

        if currentRow == 0 {
            goingDown = true
        } else if currentRow == numRows - 1 {
            goingDown = false
        }

        currentRow += goingDown ? 1 : -1
    }

    return rows.joined()
}

 
let input = "PAYPALISHIRING"
let numRows = 3
let output = convert(input, numRows)
print(output)  // Output: "PAHNAPLSIIGYIR"
