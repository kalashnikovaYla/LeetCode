/*
 We are playing the Guess Game. The game is as follows:

 I pick a number from 1 to n. You have to guess which number I picked.

 Every time you guess wrong, I will tell you whether the number I picked is higher or lower than your guess.

 You call a pre-defined API int guess(int num), which returns three possible results:

 -1: Your guess is higher than the number I picked (i.e. num > pick).
 1: Your guess is lower than the number I picked (i.e. num < pick).
 0: your guess is equal to the number I picked (i.e. num == pick).
 Return the number that I picked.

  

 Example 1:

 Input: n = 10, pick = 6
 Output: 6
 Example 2:

 Input: n = 1, pick = 1
 Output: 1
 Example 3:

 Input: n = 2, pick = 1
 Output: 1
 */


class Solution {
    func guess(_ num: Int) -> Int {
        // This function is provided by the game environment.
        // You would typically not implement it yourself.
        // However, for the sake of completeness, the logic is:
        
        // Let's assume \picked\ is the number to guess.
        // This value would be set in a real game environment.
        let picked = 6 // Change this as necessary for testing
        
        if num < picked {
            return 1 // The guess is lower than the picked number.
        } else if num > picked {
            return -1 // The guess is higher than the picked number.
        } else {
            return 0 // The guess is correct.
        }
    }


    
    func guessNumber(_ n: Int) -> Int {
        var low = 1
        var high = n
        
        while low <= high {
            let mid = low + (high - low) / 2
            let result = guess(mid)
            
            if result == 0 {
                return mid
            } else if result == -1 {
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        
        return -1
    }
}
