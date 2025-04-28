
/*
 
 Вам дан целочисленный массив цен, где цены[i] — это цена данной акции на i-й день.

 Каждый день вы можете решить купить и/или продать акцию. Вы можете держать не более одной акции в любой момент времени. Однако вы можете купить ее, а затем немедленно продать в тот же день.

 Найдите и верните максимальную прибыль, которую вы можете получить.
 
 Example 1:

 Input: prices = [7,1,5,3,6,4]
 Output: 7
 Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5), profit = 5-1 = 4.
 Then buy on day 4 (price = 3) and sell on day 5 (price = 6), profit = 6-3 = 3.
 Total profit is 4 + 3 = 7.

 Example 2:

 Input: prices = [1,2,3,4,5]
 Output: 4
 Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
 Total profit is 4.
 
 Example 3:

 Input: prices = [7,6,4,3,1]
 Output: 0
 Explanation: There is no way to make a positive profit, so we never buy the stock to achieve the maximum profit of 0.
 */

class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var totalProfit = 0
        
        //начинаем с элемента под индексом 1
        for i in 1..<prices.count {
            //Если prev < current тогда покупаем и продаем 
            if prices[i] > prices[i - 1] {
                totalProfit += prices[i] - prices[i - 1]
            }
        }
        
        return totalProfit
    }
}
