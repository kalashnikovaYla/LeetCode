import UIKit

func check(first: Int, second: Int) -> Bool {
    let firstDictionary = createDictionary(number: first)
    let secondDictionary = createDictionary(number: second)
    
    for i in 0...9 {
        if firstDictionary[i] != secondDictionary[i] {
            return false
        }
    }
    return true
}


func createDictionary(number: Int) -> [Int: Int] {
    var number = number
    var dictionary = [Int: Int] ()
    
    while number > 0 {
        let last = number%10
        if let value = dictionary[last] {
            dictionary[last] = value + 1
        } else {
            dictionary[last] = 1
        }
        number/10 
    }
    return dictionary
}
