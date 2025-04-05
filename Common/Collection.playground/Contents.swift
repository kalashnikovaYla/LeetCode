
import Foundation


//MARK: - Set


var setA: Set<Int> = [1, 2, 3, 5]
var setB: Set<Int> = [1, 2, 3]

// Добавление элемента
setA.insert(4)

// Удаление элемента
setA.remove(2)

// Проверка наличия
if setA.contains(1) {
    print("Множество A содержит 1")
}

// Объединение
let unionSet = setA.union(setB)
print("Объединение: \(unionSet)")

// Пересечение
let intersectionSet = setA.intersection(setB)
print("Пересечение: \(intersectionSet)")

// Разность
let differenceSet = setA.subtracting(setB)
print("Разность: \(differenceSet)")

// Симметрическая разность
let symmetricDifferenceSet = setA.symmetricDifference(setB)
print("Симметрическая разность: \(symmetricDifferenceSet)")

// Проверка подмножества и надмножества
print("Является ли A подмножеством B? \(setA.isSubset(of: setB))")
print("Является ли A надмножеством B? \(setA.isSuperset(of: setB))")

// Очистка множества
setA.removeAll()
print("Множество A после очистки: \(setA)")

//MARK: - String


let greeting = "Hello, World!"
let startIndex = greeting.index(greeting.startIndex, offsetBy: 7)
let endIndex = greeting.index(greeting.endIndex, offsetBy: -1)
let subString = greeting[startIndex...endIndex] // "World"


let substring = greeting.prefix(5) // "Hello" 'Substring'


var mutableString = "Hello, World!"
mutableString = mutableString.replacingOccurrences(of: "World", with: "Swift")

var stringWithRemovedPart = "Hello, World!"
let range = stringWithRemovedPart.range(of: "World")!
stringWithRemovedPart.removeSubrange(range)

if let range = greeting.range(of: "World") {
    print("Found at: \(range)")
}


let csv = "apple,banana,cherry"
let fruits = csv.components(separatedBy: ",") // ["apple", "banana", "cherry"]



let repeatedString = String(repeating: "Hello ", count: 3)
print(repeatedString)

var res = ""
let word1 = "abc"
let rangeExample = word1.index(word1.startIndex, offsetBy: 0)...word1.endIndex
res += word1[rangeExample] //String.SubSequence

res.append(word1[word1.index(word1.startIndex, offsetBy: 0)]) ///Character

//MARK: - NSString
let s = (substring as NSString).substring(to: 2)
let objcStr = greeting as NSString
let objcRange = objcStr.range(of: "Hello")
print("NSString range length: \(objcRange.length), location: \(objcRange.location)")



//MARK: - Array
 
var numbers = [1, 2, 3, 4, 5]
numbers.removeLast()
numbers.remove(at: 0)
//numbers.removeAll()

let sortedNumbers = numbers.sorted() // Возвращает отсортированный массив
numbers.sort() // Сортирует массив на месте
let sliced = numbers[1..<3] // Получает срез массива
numbers[1...2] = [10, 20]

var array = [1,2,3,4,5]
let newEl = [-1, 0]
array.insert(contentsOf: newEl, at: 0)
print(array) //[-1, 0, 1, 2, 3, 4, 5]
