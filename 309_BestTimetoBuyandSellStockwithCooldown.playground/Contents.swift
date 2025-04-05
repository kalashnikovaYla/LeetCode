/*
 You are given an array prices where prices[i] is the price of a given stock on the ith day.

 Find the maximum profit you can achieve. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times) with the following restrictions:

 After you sell your stock, you cannot buy stock on the next day (i.e., cooldown one day).
 Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

 Вам дан массив цен, где цены[i] — это цена данной акции на i-й день.

 Найдите максимальную прибыль, которую вы можете получить. Вы можете совершить столько транзакций, сколько захотите (т. е. купить одну и продать одну акцию несколько раз) со следующими ограничениями:

 После продажи акций вы не можете купить акции на следующий день (т. е. кулдаун один день).
 Примечание: вы не можете совершать несколько транзакций одновременно (т. е. вы должны продать акции, прежде чем купить их снова).

 Example 1:

 Input: prices = [1,2,3,0,2]
 Output: 3
 Explanation: transactions = [buy, sell, cooldown, buy, sell]
 
 Example 2:

 Input: prices = [1]
 Output: 0
 */

func maxProfit(_ prices: [Int]) -> Int {
    guard !prices.isEmpty else { return 0 }

    let n = prices.count
    var hold = Array(repeating: 0, count: n)
    var sold = Array(repeating: 0, count: n)
    var rest = Array(repeating: 0, count: n)

    hold[0] = -prices[0]

    for i in 1..<n {
        hold[i] = max(hold[i-1], rest[i-1] - prices[i])
        sold[i] = hold[i-1] + prices[i]
        rest[i] = max(rest[i-1], sold[i-1])
    }

    return max(sold[n-1], rest[n-1])
}

 
let prices1 = [1, 2, 3, 0, 2]
let maxProfit1 = maxProfit(prices1)
print(maxProfit1)

let prices2 = [1]
let maxProfit2 = maxProfit(prices2)
print(maxProfit2)   
