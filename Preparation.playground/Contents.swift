import Foundation


/*
 функция рассчета стоимости проживания в отеле, дано количество дней проживания - обяз, дата заселения - не обяз параметр - стоимость проживания в будние дни 1500, в выходные 2200  
 */

func calculateHotelCost(days: Int, checkInDate: Date = Date(), weekdayRate: Double = 1500, weekendRate: Double = 2200) -> Double {
     
    let calendar = Calendar.current
    var totalCost: Double = 0.0
    
   
    for dayOffset in 0..<days {
        
        if let currentDate = calendar.date(byAdding: .day, value: dayOffset, to: checkInDate) {
            
            let weekday = calendar.component(.weekday, from: currentDate)
            
           
            if weekday == 1 || weekday == 7 {
                totalCost += weekendRate
            } else {
                totalCost += weekdayRate
            }
        }
    }
    
    return totalCost
}

 
let numberOfDays = 5
let checkIn = Date()
let totalCost = calculateHotelCost(days: numberOfDays, checkInDate: checkIn)

print("Общая стоимость проживания: \(totalCost) рублей.")
