import UIKit

func maxProfit(_ prices: [Int]) -> Int {
    guard !prices.isEmpty else { return 0 }
    
    var minPrice = Int.max
    var maxProfit = 0
    
    for price in prices {
        if price < minPrice {
            minPrice = price
        } else {
            
            let profit = price - minPrice
            
            if profit > maxProfit {
                maxProfit = profit
            }
        }
    }
    return maxProfit
}


maxProfit([2,4,1])
