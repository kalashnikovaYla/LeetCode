/*

 You are given a positive integer days representing the total number of days an employee is available for work (starting from day 1). You are also given a 2D array meetings of size n where, meetings[i] = [start_i, end_i] represents the starting and ending days of meeting i (inclusive).

 Return the count of days when the employee is available for work but no meetings are scheduled.
 Note: The meetings may overlap.

  

 Example 1:

 Input: days = 10, meetings = [[5,7],[1,3],[9,10]]

 Output: 2

 Explanation:

 There is no meeting scheduled on the 4th and 8th days.

 Example 2:

 Input: days = 5, meetings = [[2,4],[1,3]]

 Output: 1

 Explanation:

 There is no meeting scheduled on the 5th day.

 Example 3:

 Input: days = 6, meetings = [[1,6]]

 Output: 0

 Explanation:

 Meetings are scheduled for all working days.
 */

class Solution {
    func countDays(_ days: Int, _ meetings: [[Int]]) -> Int {
        var meetings = meetings.sorted{$0[0]<$1[0]}
        
        var lastDay = 0
        var count = 0
        for meeting in meetings {
            if meeting[0] > lastDay {
                count += (meeting[0] - lastDay - 1)
                lastDay = meeting[1]
            } else {
                lastDay = max(lastDay, meeting[1])
            }
        }
        if lastDay < days {
            count += (days - lastDay)
        }

        return count
    }
}

func countAvailableDays(totalDays: Int, meetings: [[Int]]) -> Int {
    var bookedDays = Set<Int>()
     
    for meeting in meetings {
        let start = meeting[0]
        let end = meeting[1]
        for day in start...end {
            bookedDays.insert(day)
        }
    }
    
    /*
     var availableDaysCount = 0
     for day in 1...totalDays {
         if !bookedDays.contains(day) {
             availableDaysCount += 1
         }
     }
     */
    
    return totalDays - bookedDays.count
}

 
let days = 10
let meetings = [[5, 7], [1, 3], [9, 10]]
let availableDays = countAvailableDays(totalDays: days, meetings: meetings)
print(availableDays)


func minSubArrayLen(target: Int, nums: [Int]) -> Int {
    var left = 0
    var sum = 0
    var minLength = nums.count + 1
    
    for right in 0..<nums.count {
        sum += nums[right]
        
        while sum >= target {
            minLength = min(minLength, right - left + 1)
            sum -= nums[left]
            left += 1
        }
    }
    
    return minLength == nums.count + 1 ? 0 : minLength
}
