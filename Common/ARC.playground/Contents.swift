
class Object {
    let value = "value"
    
    deinit {
        print("deinit")
    }
}

var object: Object? = Object()
let array = [object]
object = nil
//print(array[0]?.value) ///Optional("value")



//MARK: FIX IT

var array2: [WeakObjectWrapper] = []

class WeakObjectWrapper {
    weak var object: Object?
    init(object: Object) {
        self.object = object
    }
}

// Создаём объект
var object2: Object? = Object()

// Добавляем слабую ссылку в массив
if let obj = object2 {
    array2.append(WeakObjectWrapper(object: obj))
}

// Удаляем сильную ссылку
object2 = nil
//print(array2.first?.object?.value)//nil



class ClassA {
    var child: ClassB
    init(child: ClassB) {
        self.child = child
    }
    deinit {
        print("deinit")
    }
}

class ClassB {
    weak var parent: ClassA?
}

let bObject = ClassB()
var aObject: ClassA? = ClassA(child: bObject)
bObject.parent = aObject
aObject = nil


struct Person {
    let name: String
    
    func greetings() {
        return { [self] in
            print("Hello, \(self.name)")
        }()
    }
    
    ///'weak' may only be applied to class and class-bound protocol types, not 'Person'
   /*
    func greetings1() {
        return { [weak self] in
            print("Hello, \(self?.name)")
        }()
    }
    */
}
