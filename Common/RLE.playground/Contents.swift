 

func runLengthEncoding(_ input: String) -> String {
    var result = ""
    var count = 1

    for i in 1..<input.count {
        let index = input.index(input.startIndex, offsetBy: i)
        let prevIndex = input.index(input.startIndex, offsetBy: i - 1)
        
        if input[prevIndex] == input[index] {
            count += 1
        } else {
            result.append(input[prevIndex])
            result.append(String(count))
            count = 1
        }
    }

    let lastIndex = input.index(input.startIndex, offsetBy: input.count - 1)
    result.append(input[lastIndex])
    result.append(String(count))

    return result
}


func search(string: String) -> String {
    var last = string[string.startIndex]
    var answer = [String]()
    
    for i in 1..<string.count {
        if string[string.index(string.startIndex, offsetBy: i)] != last {
            answer.append(String(last))
            last = string[string.index(string.startIndex, offsetBy: i)]
        }
    }
    answer.append(String(last))
    return answer.joined(separator: "")
}


func pack(character: Character, lenght: Int) -> String {
    if lenght > 1 {
        return String(character) + String(lenght)
    }
    return String(character)
}


func rle(string: String) -> String {
    var lastCharacter = string[string.startIndex]
    var lastIndex = 0
    var answer = [String]()
    
    for i in 1..<string.count {
        if string[string.index(string.startIndex, offsetBy: i)] != lastCharacter {
            answer.append(pack(character: lastCharacter, lenght: i - lastIndex))
            lastIndex = i
            lastCharacter = string[string.index(string.startIndex, offsetBy: i)]
        }
    }
    
    answer.append(pack(character: lastCharacter, lenght: string.count - lastIndex))
    return answer.joined(separator: "")
}


/*
 Мы берем 1 элемент по индексу 0 и делаем его lastCharacter
 затем начиная с 1..<chars.count мы проходимя по массиву и как только у нас не совпало, мы добавляем символ в result 
 */
