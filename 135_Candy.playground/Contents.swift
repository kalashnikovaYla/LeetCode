/*
 135. Candy

 There are n children standing in a line. Each child is assigned a rating value given in the integer array ratings.

 You are giving candies to these children subjected to the following requirements:

 Each child must have at least one candy.
 Children with a higher rating get more candies than their neighbors.
 Return the minimum number of candies you need to have to distribute the candies to the children.

  

 Example 1:

 Input: ratings = [1,0,2]
 Output: 5
 Explanation: You can allocate to the first, second and third child with 2, 1, 2 candies respectively.
 Example 2:

 Input: ratings = [1,2,2]
 Output: 4
 Explanation: You can allocate to the first, second and third child with 1, 2, 1 candies respectively.
 The third child gets 1 candy because it satisfies the above two conditions.
 */


func candy(_ ratings: [Int]) -> Int {
    let n = ratings.count
    if n == 0 { return 0 }
    
    // Step 1: Initialize candies
    var candies = Array(repeating: 1, count: n)
    
    // Step 2: Left to right pass
    for i in 1..<n {
        if ratings[i] > ratings[i - 1] {
            candies[i] = candies[i - 1] + 1
        }
    }
    
    // Step 3: Right to left pass
    for i in (0..<n-1).reversed() {
        if ratings[i] > ratings[i + 1] {
            candies[i] = max(candies[i], candies[i + 1] + 1)
        }
    }
    
    return candies.reduce(0, +)
}

 
let ratings = [1, 0, 2]
let result = candy(ratings)
print(result)  // Output: 5
