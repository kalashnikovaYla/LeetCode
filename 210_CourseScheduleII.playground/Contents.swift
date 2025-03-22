/*
 
 There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

 For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
 Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.

  

 Example 1:

 Input: numCourses = 2, prerequisites = [[1,0]]
 Output: [0,1]
 Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1].
 Example 2:

 Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
 Output: [0,2,1,3]
 Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0.
 So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3].
 Example 3:

 Input: numCourses = 1, prerequisites = []
 Output: [0]
 */


class Solution {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        var graph = [[Int]](repeating: [Int](), count: numCourses)
        var inDegree = [Int](repeating: 0, count: numCourses)
        
        for prerequisite in prerequisites {
            let course = prerequisite[0]
            let preCourse = prerequisite[1]
            graph[preCourse].append(course)
            inDegree[course] += 1
        }
        
        // Step 2: Initialize the queue with all courses having no prerequisites (in-degree of 0)
        var queue = [Int]()
        for course in 0..<numCourses {
            if inDegree[course] == 0 {
                queue.append(course)
            }
        }
        
        // Step 3: Perform BFS to get the topological order
        var order = [Int]()
        
        while !queue.isEmpty {
            let current = queue.removeFirst()
            order.append(current)
            
            for neighbor in graph[current] {
                inDegree[neighbor] -= 1
                if inDegree[neighbor] == 0 {
                    queue.append(neighbor)
                }
            }
        }
        
        // Step 4: Check if we were able to take all courses
        if order.count == numCourses {
            return order
        } else {
            return [] // There's a cycle, thus it's impossible to finish all courses
        }

    }
}
