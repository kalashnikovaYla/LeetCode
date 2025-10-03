import Foundation


//MARK: - 1

protocol ProtocolExample8 {}

extension ProtocolExample8 {
    func doSomething() {
        print("Default Implementation")
    }
}

struct StructWithProtocol: ProtocolExample8 {
    func doSomething() {
        print("Struct Implementation")
    }
}

let firstStruct = StructWithProtocol()
firstStruct.doSomething() //Struct Implementation

let secondStruct: ProtocolExample8 = StructWithProtocol()
secondStruct.doSomething() //Default Implementation

class ClassExample8: ProtocolExample8 {
    func doSomething() {
        print("Required Implementation")
    }
    func doSomething2() {
        print("Do something 2")
    }
}

let first = ClassExample8()
let second: ProtocolExample8 = ClassExample8()
//first.doSomething()
//second.doSomething()
//second.doSomething2()

/*
 Required Implementation
 Default Implementation
 Это происходит, потому что во втором случае система выбирает дефолтную реализацию протокола и это Direct Dispatch, а мы осуществляем в нашем классе свою реализацию, и под капотом этот метод переходит в Witness Table.
 Для того, чтобы программа поняла, что в нашем случае мы используем Witness Table, нам нужно добавить этот метод в протокол.
 protocol ProtocolExample8 {
      func doSomething()
 }

 let second: ProtocolExample8 = ClassExample8()
 second.doSomething2()
 Value of type 'any ProtocolExample8' has no member 'doSomething2' - будет ошибка компиляции

 В этом случае `second` объявлена как переменная типа `ProtocolExample8`, но ссылается на экземпляр `ClassExample8`. Это означает, что `second` может использовать только те методы, которые доступны через протокол `ProtocolExample8`. Однако, так как `ClassExample8` реализует все требования протокола, вы все равно можете вызывать метод `doSomething()` через `second`, и будет использована реализация, определенная в `ClassExample8`.

 */

//MARK: - 2
class A {
    func sound(type: String = "Unkn") {
        print("A sound \(type)")
    }
}

class Dog: A {
    override func sound(type: String = "Bark") {
        print("Dog sound \(type)")
    }
}

let pet: A = Dog()
//pet.sound() // Dog sound Unkn
/*
 Основная причина этого поведения - в том, как Swift обрабатывает параметры по умолчанию. Значение по умолчанию для параметра используется в момент определения метода, а не в момент вызова. Так как pet является ссылкой типа A, используется значение по умолчанию, определенное в классе A.
 */

let pet2: Dog = Dog()
//pet2.sound() //Dog sound Bark

//MARK: - 3

protocol P {
    func showMessage()
}

extension P {
    func showMessage() {
        print("extension")
    }
}

struct S: P {
    func showMessage() {
        print("Struct")
    }
}

class C: P {
    
}
let objc1: P = S()
let objc2: P = C()
objc1.showMessage() //Struct
//objc2.showMessage() //extension
/*
 Если убрать из протокола метод func showMessage() - то будет
 extension
 extension
 */


//статическая диспетчерезация 
final class Rectangle {
    var width: Double
    var height: Double
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    func area() -> Double {
        return width * height
    }
}

//Static dispatch
final class SampleFinalClass {
    func sayHello() {
        print("Hello!")
    }
}

struct SampleStruct {
    func sayHello() {
        print("Hello!")
    }
}

extension SampleStruct {
    func someFunc() {
        print("Hello!")
    }
}


class Father {
    func eat() {
        print("father eats")
    }
    func walk() {}
    func sleep() {}
    func work() {}
}
 

class Child: Father {
    override func eat() {
        print("child eats")
    }
    override func walk() {}
    override func sleep() {}
    override func work() {}
}

let child = Child()
//child.eat() // child eats

let child2: Father = Child()
//child2.eat() // child eats


//Witness Table
protocol GameProtocol {
    func buyGame()
}

class Brother: GameProtocol {
    func buyGame() {
        print("AssassinsCreed")
    }
}

class Sister: GameProtocol {
    func buyGame() {
        print("Barbie")
    }
}

let brother = Brother()
//brother.buyGame() //AssassinsCreed
let sister: GameProtocol = Sister()
sister.buyGame() //Barbie

struct Mother: GameProtocol {
    func buyGame() {
        
    }
}


