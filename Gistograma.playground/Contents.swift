import UIKit

func prints(string: String) {
    var dictionary = [Character: Int]()
    var maxCount = 0
    
    for i in string {
        if let value = dictionary[i] {
            dictionary[i] = value + 1
        } else {
            dictionary[i] = 1
        }
        
        maxCount = max(maxCount, dictionary[i] ?? 1)
    }
    
    let sortedKeys = dictionary.keys.sorted()
    
    for i in stride(from: maxCount, to: 0, by: -1) {
        for key in sortedKeys {
            if dictionary[key] ?? 0 >= i {
                print("#", terminator: "")
            } else {
                print(" ", terminator: "")
            }
        }
        print("")
    }
    
    print(String(sortedKeys))
}

prints(string: "Hello, world!")
/*
 #
 ##
##########
!,Hdelorw
 */
