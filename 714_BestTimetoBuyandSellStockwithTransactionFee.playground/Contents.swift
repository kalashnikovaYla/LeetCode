/*
 You are given an array prices where prices[i] is the price of a given stock on the ith day, and an integer fee representing a transaction fee.

 Find the maximum profit you can achieve. You may complete as many transactions as you like, but you need to pay the transaction fee for each transaction.

 Note:

 You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).
 The transaction fee is only charged once for each stock purchase and sale.
  
 Вам дан массив prices, где prices[i] — это цена данной акции на i-й день, и целочисленная комиссия, представляющая комиссию за транзакцию.

 Найдите максимальную прибыль, которую вы можете получить. Вы можете совершить столько транзакций, сколько захотите, но вам необходимо заплатить комиссию за транзакцию за каждую транзакцию.

 Примечание:

 Вы не можете совершать несколько транзакций одновременно (т. е. вы должны продать акцию, прежде чем купить ее снова).
 Комиссия за транзакцию взимается только один раз за каждую покупку и продажу акций.
 
 
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
    
    //`hold[i]`: максимальная прибыль на день `i, если у нас есть акция на руках.
    var hold = Array(repeating: 0, count: n)
    
    //`cash[i]`: максимальная прибыль на день `i, если мы продали ее
    var cash = Array(repeating: 0, count: n)

    //В первый день, если мы покупаем акцию, наша прибыль равна отрицательной цене первой акции, так как мы потратили деньги на её покупку.
    hold[0] = -prices[0]

    for i in 1..<n {
        hold[i] = max(hold[i-1], cash[i-1] - prices[i])
        cash[i] = max(cash[i-1], hold[i-1] + prices[i] - fee)
    }

    return cash[n-1]
}
maxProfit([1,3,2,8,4,9], 2)
 
func maxProfit2(_ prices: [Int], _ fee: Int) -> Int {
    
    if prices.isEmpty { return 0 }
    
    //Это переменная, представляющая прибыль, если вы держите акцию в данный момент. Если вы не владеете акцией, то её значение будет отрицательным (т.е. вы фактически потеряли деньги на покупку).

    var hold = -prices[0]
    var result = 0
    
    for price in prices {
        let previous = result
        result = max(result, hold + price - fee)
        hold = max(hold, previous - price)
    }
    
    return result
}
maxProfit2([1,3,2,8,4,9], 2)
