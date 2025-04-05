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

//миним рантайм
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

//memory 
func countDays(_ days: Int, _ meetings: [[Int]]) -> Int {
    let meetings = meetings.sorted { $0[0]<$1[0] }
    var result = days
    var prevEnd = 0
    for meeting in meetings {
        let start = max(prevEnd+1, meeting[0])
        result -= max(0, meeting[1]+1-start)
        prevEnd = max(prevEnd, meeting[1])
    }
    return result
}

//Time Limit Exceeded
class Solution2 {
    func countDays(_ days: Int, _ meetings: [[Int]]) -> Int {
        var rangeSet = Set<Int>()
        for meeting in meetings {
            let range = meeting[0]...meeting[1]
            for day in range {
                rangeSet.insert(day)
            }

        }
        return days - rangeSet.count
    }
}
