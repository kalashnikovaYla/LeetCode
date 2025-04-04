/*
 Given an m x n matrix, return all elements of the matrix in spiral order.
 
 Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
 Output: [1,2,3,6,9,8,7,4,5]
 
 Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
 Output: [1,2,3,4,8,12,11,10,9,5,6,7]
 */


func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    guard !(matrix.isEmpty) else { return [] }
    
    var result: [Int] = []
    var rBegin = 0, rEnd = matrix.count - 1
    var cBegin = 0, cEnd = matrix[0].count - 1
    
    while rBegin <= rEnd && cBegin <= cEnd {
        // Traverse right
        for i in stride(from: cBegin, to: cEnd + 1, by: 1) {
            result.append(matrix[rBegin][i])
        }
        rBegin += 1
        
        // Traverse down
        for i in stride(from: rBegin, to: rEnd + 1, by: 1) {
            result.append(matrix[i][cEnd])
        }
        cEnd -= 1
        
        // Traverse left
        if rBegin <= rEnd {
            for i in stride(from: cEnd, to: cBegin - 1, by: -1) {
                result.append(matrix[rEnd][i])
            }
        }
        rEnd -= 1
        
        // Traverse up
        if cBegin <= cEnd {
            for i in stride(from: rEnd, to: rBegin - 1, by: -1) {
                result.append(matrix[i][cBegin])
            }
        }
        cBegin += 1
    }
    return result
}
