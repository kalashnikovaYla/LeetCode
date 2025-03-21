/*
 You are given an array prices where prices[i] is the price of a given stock on the ith day, and an integer fee representing a transaction fee.

 Find the maximum profit you can achieve. You may complete as many transactions as you like, but you need to pay the transaction fee for each transaction.

 Note:

 You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).
 The transaction fee is only charged once for each stock purchase and sale.
  

 Example 1:

 Input: prices = [1,3,2,8,4,9], fee = 2
 Output: 8
 Explanation: The maximum profit can be achieved by:
 - Buying at prices[0] = 1
 - Selling at prices[3] = 8
 - Buying at prices[4] = 4
 - Selling at prices[5] = 9
 The total profit is ((8 - 1) - 2) + ((9 - 4) - 2) = 8.
 Example 2:

 Input: prices = [1,3,7,5,10,3], fee = 3
 Output: 6

 */


func maxProfit(_ prices: [Int], _ fee: Int) -> Int {
    guard !prices.isEmpty else { return 0 }

    let n = prices.count
    var hold = Array(repeating: 0, count: n)
    var cash = Array(repeating: 0, count: n)

    hold[0] = -prices[0]

    for i in 1..<n {
        hold[i] = max(hold[i-1], cash[i-1] - prices[i])
        cash[i] = max(cash[i-1], hold[i-1] + prices[i] - fee)
    }

    return cash[n-1]
}

 
