import Foundation
import UIKit
import SwiftUI

func doSomething() {
    let words = ["banana", "Apple", "orange", "apple"]
    let result = words.sorted{ $0 < $1}
    print(result)
}
//doSomething() //["Apple", "apple", "banana", "orange"]

func greet() {
    print("Hello swift")
}
//let message = greet() //Constant 'message' inferred to have type '()', which may be unexpected


class Animal {
    var name = "Leo"
}
var animal = Animal()
animal.name = "Tiger"
let clouser = { [capturedAnimal = animal] in
    print("Hello \(capturedAnimal.name)")
}
animal.name = "Lion"
//clouser() //Hello Lion

//ошибка компиляции
func doSomething1() {
   // let x: UInt = UInt(-5) //Negative integer '-5' overflows when stored into unsigned type 'UInt'
    let y: UInt = 10
   // print(x<y)
}
//doSomething1()

func doSomething2() {
    let text = "rocket"
    for (index, letter) in text.enumerated().reversed() where index % 2 != 0 {
        print("\(index): \(letter)")
    }
}

//doSomething2()
/*
 5: t
 3: k
 1: o
 */


func doSomething4() {
    let roles = ["Developer" : "Anna", "Manager" : "Bob"]
    for (index, pair) in roles.enumerated() {
        let output = "\(index): \(pair.key) - \(pair.value)"
        print(output)
    }
}
//doSomething4()
/*
 0: Developer - Anna
 1: Manager - Bob
 */


func doSomething5() {
    let array = [1, 2, 3, 4, 5]
    let result = array.filter{$0 & 2 == 0}.map {$0 + $0}
    print(result)
}
//doSomething5() //[2, 8, 10]

//MARK: не нужно ставить @escaping
class DataFetcher {
    var completionHandler: (() -> Void)?
    
    func fetchData(completion: (() -> Void)?) {
        self.completionHandler = completion
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
}

func createCounter() -> () -> Void {
    var counter = 0
    func incrementCounter() {
        counter += 1
        print(counter)
    }
    return incrementCounter
}



func doSomething6(){
    let clouser = createCounter()
    clouser()
    clouser()
    clouser()
}
//doSomething6()
/*
 1
 2
 3
 */


func doSomething7() {
    var a: Int? = .zero
    var b: Int? = nil
    a? = 10
    b? = 10
    print("\(a ?? 5) \(b ?? 7)")
}
//doSomething7() // 10 7
//b? = 10 - если так: то значение не изменится. но если убрать ? или инициализировать неопциональным значением var b: Int? = 5 - то обновиться
//оператор `?` используется для безопасного доступа к опциональным значениям, и присвоение значения через этот оператор работает только в случае, если исходное опциональное значение не равно `nil`.

func doSomething8() {
    class Person {
        var name: String
        init(name: String) {
            self.name = name
        }
    }
    
    let person1 = Person(name: "Alice")
    let person2 = Person(name: "Bob")
    
    let team1 = [person1, person2]
    let team2 = team1
    team2[1].name = "Charlie"
    print(team1[1].name)
}
//doSomething8() //Charlie

func doSomething9() {
    let view = UIView()
    view.backgroundColor = UIColor.green
    view.layer.backgroundColor = UIColor.red.cgColor
    print(view.backgroundColor)
}
//doSomething9()//красный


func doSomething10() {
    class MyClass: NSObject {
        var name: String
        override var description: String {
            return name
        }
        init(name: String) {
            self.name = name
        }
    }
    
    var firstMass: [MyClass] = [
        MyClass(name: "A"),
        MyClass(name: "V"),
        MyClass(name: "L")
    ]
    let secondMass = firstMass
    firstMass.popLast()
    firstMass.last?.name = "Ivan"
    print(secondMass)
}
//doSomething10() //[A, Ivan, L]


func doSomething11() {
    class UIView1: UIView {}
    class UIView2: UIView {}
    
    var view: UIView = UIView1()
    view.tag = 1
    let clouser = { [view] in
        print(view.tag)
    }
    view.tag = 2
    view = UIView2()
    view.tag = 3
    clouser()
}
//doSomething11() // 2 

func doSomething12() {
    var array = [[1,3], [2, nil], [nil, 1]]
    print(array.compactMap{ $0.count})
}
//doSomething12() //[2, 2, 2]


func processArray(_ array: [Int] ) -> [Int] {
    var result = [Int]()
    var temp = array
    for i in 0..<temp.count {
        let element = temp.remove(at: i%temp.count)
        result.append(element)
    }
    return result
}

//print(processArray([1,2,3,4,5])) //[1, 3, 5, 4, 2]


func doSomething13() {
    var a = 14
    var b = 2
    let clouser: () -> Int = { [a,b] in //если бы захвата значений не было, то было бы 11 [a,b] in
        return a + b
    }
    a = 5
    b = 6
    print(clouser())
}
//doSomething13() //16


func doSomething14() {
    func personWorks() -> (language: String, experience: Int) {
        ("Swift", 2)
    }
    print(personWorks().0)
}
//doSomething14() //Swift


//ошибка компиляции
func doSomething15() {
    let names = ["Anna", "Maria"]
    /*
     for i in 0...names.length {
         print("Hello")
     }
     */
}


func doSomething16() {
    var lang = "Objc"
    let code = {
        print(lang)
    }
    code()
    lang = "Swift"
    code()
}
//doSomething16()
/*
                 Objc
                 Swift
                 */

func doSomething17() {
    var dictWithNils: [String: Int?] = ["one": 1, "two": 2, "none": nil]
    print(dictWithNils.count)
    dictWithNils["two"] = nil
    dictWithNils["none"] = nil
    print(dictWithNils.count)
}
/*
 doSomething17()
 3
 1
 */

func doSomething18() {
    var names = [String]()
    names.append("Marina")
    let example1 = names.popLast()
    let example2 = names.popLast() //@inlinable public mutating func popLast() -> Element?
    print(example2)
}
//doSomething18() //nil

func doSomething20() {
    var names = [String]()
    names.append("Maria")
    let example1 = names.removeLast()
    let example2 = names.removeLast() // @inlinable public mutating func removeLast() -> Element
    print(example2)
}
//doSomething20() // Swift/RangeReplaceableCollection.swift:867: Fatal error: Can't remove last element from an empty collection Ошибка в рантайм



func doSomething19() {
    func deferTest() -> String {
        var currentString = ""
        currentString += "A"
        
        defer {
            currentString += "B"
        }
        
        if true {
            defer {
                currentString += "C"
            }
            currentString += "E"
        }
        currentString += "F"
        
        defer {
            currentString += "G"
        }
        return currentString
    }
    deferTest()
}
//doSomething19() //AECF


func doSomething21() {
    func people() -> (job: String, name: String) {
        return ("Builder", "Igor")
    }
    
    let result = people().0
    print(result)
}

//doSomething21() //Builder


func doSomething22() {
    let numbers = [1,3,5,7,9]
    let result = numbers.reduce(0, +)
    print(result)
}
//doSomething22() //25


func doSomething23() {
    let names = ["Mark", "Sergey", "Ian"]
    let result = names.sorted {$0 > $1}
    print(result)
}
//doSomething23() //["Sergey", "Mark", "Ian"]


func doSomething24() {
    func one(_ number: Int) -> Int {
        func two(_ number: Int) -> Int {
            return number * 5
        }
        return number * two(3)
    }
    
    print(one(2))
}
//doSomething24() //30



func doSomething25() {
    class Person {
        var name = "Dima"
    }
    let person = Person()
    person.name = "Artem"
    let clouser = { [person] in
        print("Hello \(person.name)")
    }
    person.name = "Sergey"
    clouser()
}
//doSomething25() //Hello Sergey


func doSomething26() {
    let names = ["D": "Igor", "M": "Nurse"]
    for (key, value) in names.enumerated() {
        let test = value
    }
}
//doSomething26() //String: String


func doSomething27() {
    let value = 8
    
    func showValue() {
        print("show \(value)")
    }
    
    func wrapper(){
        print("show \(value)")
        let value = 9
        showValue()
    }
    wrapper()
}

//doSomething27()


func doSomething28() {
    var array = [1,2,3]
    
    for i in array {
        print(i)
        array = [4,5,6]
    }
    print(array)
}
doSomething28() //1 2 3 //array become [4, 5, 6]
