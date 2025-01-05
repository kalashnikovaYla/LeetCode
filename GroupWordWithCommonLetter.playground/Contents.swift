import UIKit

func sort(array: [String]) -> [[String]] {
    var answer = [[String]]()
    var dictionary = [String: [String]]()
    
    for word in array {
        let sortedWord = String(word.sorted())
        
        if let value = dictionary[sortedWord] {
            dictionary[sortedWord] = value + [word]
        } else {
            dictionary[sortedWord] = [word]
        }
    }
    
    for key in dictionary.keys {
        answer.append(dictionary[key] ?? [])
    }
    return answer
}
