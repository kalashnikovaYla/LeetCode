/*

 Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

 An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

 Example 1:

 Input: grid = [
   ["1","1","1","1","0"],
   ["1","1","0","1","0"],
   ["1","1","0","0","0"],
   ["0","0","0","0","0"]
 ]
 Output: 1
 
 Example 2:

 Input: grid = [
   ["1","1","0","0","0"],
   ["1","1","0","0","0"],
   ["0","0","1","0","0"],
   ["0","0","0","1","1"]
 ]
 */

import Foundation

func numIslands(_ grid: [[Character]]) -> Int {
    guard !grid.isEmpty else { return 0 }
    
    var grid = grid
    let rows = grid.count
    let cols = grid[0].count
    var islandCount = 0
    
    func dfs(_ row: Int, _ col: Int) {

        if row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] == "0" {
            return
        }
         
        grid[row][col] = "0"
        
       
        dfs(row - 1, col) // up
        dfs(row + 1, col) // down
        dfs(row, col - 1) // left
        dfs(row, col + 1) // right
    }
    
    for i in 0..<rows {
        for j in 0..<cols {
            if grid[i][j] == "1" {
                islandCount += 1
                dfs(i, j)  
            }
        }
    }
    
    return islandCount
}

// Example usage
let grid: [[Character]] = [
    ["1", "1", "1", "1", "0"],
    ["1", "1", "0", "1", "0"],
    ["1", "1", "0", "0", "0"],
    ["0", "0", "0", "0", "0"]
]

let numberOfIslands = numIslands(grid)
print(numberOfIslands) // Output: 1
