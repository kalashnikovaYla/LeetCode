
class Object {
    let value = "value"
    
    deinit {
        print("deinit")
    }
}

var object: Object? = Object()
let array = [object]
object = nil
print(array[0]?.value) ///Optional("value")



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
if let obj = object {
    array2.append(WeakObjectWrapper(object: obj))
}

// Удаляем сильную ссылку
object = nil
print(array2.first?.object?.value)//nil
