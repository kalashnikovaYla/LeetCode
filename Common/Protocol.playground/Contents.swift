//MARK: - associatedtyp
protocol Proto {
    associatedtype Item
    func get() -> Item
}
 
/*
 class exampleA {
     let service: Proto

     init(service: Proto) {
         self.service = service
     }
     
     func getItem() {
         service.get()
     }
 }
 */

 
 /*
 ///это некорректно, потому что `Proto` — это протокол с ассоциированным типом, его нельзя использовать как тип без указания конкретных параметров или обобщений.

 ///Класс `exampleA` не является обобщённым или не использует `some`/`any`

 Почему использовать `any` и `some`?

 - Использовать `any` — когда хотите держать группу разных типов, реализующих один протокол, и не знать их конкретный тип.
 - Использовать `some` — когда хотите возвратить или работать с конкретным типом, за которым скрыт его конкретный класс, но при этом при этом важно, что этот тип — один и тот же, для обеспечивания согласованности.

 */

class ExampleA {
    let service: any Proto ///В Swift 5.6 и позже `any` позволяет явно указать, что переменная, параметр или свойство является экзистенциальным типом, то есть он ссылается на любой тип, который реализует указанный протокол или протоколы.


    ///`some` — использование подписанного типа (Opaque Type) `some` позволяет указать конкретный тип, который реализует протокол, но его конкретный тип скрыт за интерфейсом.
    ///Используется, чтобы объявить конкретный тип, известный только внутри текущей функции или инициализатора, но ярко выражены абстракция и неизменность возвращаемого типа.
    init(service: any Proto) {
        self.service = service
    }
    
    func getItem() {
        service.get()
    }
}

class Service: Proto {
    typealias Item = Int
    func get() -> Int {
        return (0...34).randomElement() ?? 0
    }
}
let service = Service()
let exmpl = ExampleA(service: service)



//MARK: Array ext with generic
/*
 [1,2,3,4,5].groupBy {$0 % 2} -> [
     0: [2, 4],
     1: [1, 3,5]
 ]
 
 ["Nikita", "Nikolay", "Alex"].groupBy {$0.first!} -> [
    "N": ["Nikita", "Nikolay"],
    "A": ["Alex"]
]
 */
 

extension Array {
    func groupBy<Key: Hashable>(_ keySelector: (Element) -> Key) -> [Key: [Element]] {
        var result: [Key: [Element]] = [:]
        for element in self {
            let key = keySelector(element)
            if result[key] != nil {
                result[key]?.append(element)
            } else {
                result[key] = [element]
            }
        }
        return result
    }
}


struct KeyObject: Hashable {
    let a: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
}
//если А одинаковые, то ключи перезапишутся hasher.combine(0)
let key1 = KeyObject(a: 1)
let key2 = KeyObject(a: 1)

var dict: [KeyObject: String] = [:]
dict[key1] = "hi"
dict[key2] = "h"
//print(dict[key1])


class ClassA {
    class func classMethod() {}
    static func staticMethod() {}
}

extension ClassA {
    func staticMethod2() {}
}

class ClassB: ClassA {
    override class func classMethod() {}
    ///Cannot override static method
    //override static func staticMethod() {}
    
    ///Do not see this func 
    //override func staticMethod2() {}
}
