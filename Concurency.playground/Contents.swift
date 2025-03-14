 
import Foundation

func doSomething() {
    let queue = DispatchQueue(label: "Serial queue")
    queue.async {
        print("1")
    }
    print("2")
}

//doSomething()


func example() {
    var value = 0
    
    DispatchQueue.concurrentPerform(iterations: 1000) { _ in
        value += 1
    }
    print("value = \(value)")
}
//example()

var array = [Int]()

func example2(){
   
    DispatchQueue.concurrentPerform(iterations: 1000) { i in
        array.append(i)
    }
    print("array = \(array.count)")
}
//example2()


class Loger {
    private var queue = DispatchQueue(label: "loger queue")
    
    private var logArray = [String]()
    
    var logs: [String] {
        get {
            queue.sync {
                logArray
            }
        }
    }
    
    func addEvent(log: String) {
        queue.sync {
            self.logArray.append(log)
        }
    }
}


func example3() {
    let logger = Loger()
    DispatchQueue.concurrentPerform(iterations: 1000) { i in
        logger.addEvent(log: String(i))
    }
    print(logger.logs.count)
}
//example3() //1000


func doSomething2() {
    let queue = DispatchQueue(label: "serial")
    queue.async(qos: .background) {
        print("1")
    }
    
    queue.async(qos: .utility) {
        print("2")
    }
}
//doSomething2() // 1 2

func doSomething3() {
    let task1 = Task(priority: .background) {
       // sleep(1)
        print("1")
    }
    let task2 = Task(priority: .utility) {
        print("2")
    }
}
//doSomething3() // 2 1 - мы не ждем задачу с более низким приоритетом - результат не определен

