 
import Foundation

func load() {
    DispatchQueue.main.async {
        print("enter async")
        print("1")
    }
    print("2")
    print(Thread.current.description)
    print("end load")
}
//load()
/*
 2
 <_NSMainThread: 0x600001704040>{number = 1, name = main}
 end load
 enter async
 1
 
 После того, как текущий поток (который выполняет функцию `load`) завершит все синхронные операции (в данном случае, печать "2" и информацию о потоке), он начнет обрабатывать очередь задач. В этот момент будет выполнен блок из `DispatchQueue.main.async`, и, следовательно, будет напечатано "1".

 */

func doSomething() {
    let queue = DispatchQueue(label: "Serial queue")
    
    queue.async {
        print(Thread.current.description)
        print("1")
    }
    print("2")
}

//doSomething()
/*
 Результат не определен.
 
 Поскольку `async` означает, что задача будет выполнена позже, текущий поток не ждет завершения этой задачи. Поэтому выполнение потока продолжится, и строка `"2"` будет выведена немедленно, часто до того, как будет завершена задача, добавленная в очередь.

 */

func doSomething1() {
    let queue = DispatchQueue(label: "Serial queue")
    
    queue.sync {
        sleep(1)
        print(Thread.current.description)
        print("1")
    }
    print("2")
}

//doSomething1()
/*
 код внутри замыкания будет выполнен синхронно. Это означает, что текущий поток (в данном случае, основной поток) будет ждать завершения выполнения кода внутри замыкания, прежде чем продолжить выполнение.
 1
 2
 */


func example() {
    var value = 0
    
    DispatchQueue.concurrentPerform(iterations: 1000) { _ in
        value += 1
        print(Thread.current.description)
    }
    print("value = \(value)")
}
//example()
//каждый раз результат будет разный, data race

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
        print(Task.currentPriority)
    }
    
    queue.async(qos: .utility) {
        print("2")
        print(Task.currentPriority)
    }
}
//doSomething2() // 1 2
/*
 если бы было attributes: .concurrent - то результат бы был неопределен
 */

func doSomething3() {
    let task1 = Task(priority: .background) {
       // sleep(1)
        print(Task.currentPriority)
        print("1")
    }
    let task2 = Task(priority: .utility) {
        print(Task.currentPriority)
        print("2")
    }
}
//doSomething3() // мы не ждем задачу с более низким приоритетом - результат не определен

func doSomething4() {
    let queue = DispatchQueue.global()
    queue.async(qos: .background) {
        print(Task.currentPriority)
        print("1")
    }
    queue.async(qos: .utility) {
        print(Task.currentPriority)
        print("2")
    }
    
    queue.async {
        print(Task.currentPriority)//TaskPriority.high
        print("3")
    }
}
//doSomething4()
//3 2 1

func doSomething5() {
    print("A")//1
    DispatchQueue.main.async {
        print("B")//3
        
        //5
        DispatchQueue.main.async {
            print("C")
        }
        DispatchQueue.main.async {
            print("D")
        }
        DispatchQueue.main.async {
            print("E")
        }
    }
    print("F")//2
    
    DispatchQueue.main.async {
        print("G")//4
    }
}
//doSomething5()
/*
 A
 F
 B
 G
 C
 D
 E
 */


func doSomething6() {
    let group = DispatchGroup()
    group.enter()
    
    DispatchQueue.global().async {
       // print("first enter")
        sleep(2)
        print("A")
        //print("first end")
        group.leave()
    }
    
    group.enter()
    DispatchQueue.global().async {
        //print("second enter")
        sleep(1)
        print("B")
        //print("second end")
        group.leave()
    }
    
    group.notify(queue: .main) {
        print("Done") //вызовется в самом конце как дескриптор завершения
    }
    print("C")
}

//doSomething6()
/*
 first enter
 second enter
 C
 B
 second end
 A
 first end
 Done
 
 C
 B
 A
 Done
 */


func doSomething7() {
    let main = DispatchQueue(label: "main")
    let bc = DispatchQueue(label: "bc")
    
    main.async {
        print("1")
        bc.sync {
            sleep(1)
            print("2")
            main.async {
                print("3")
            }
        }
        print("4")
    }
}
//doSomething7()
//1 2 4 3


func doSomething8() {
    print("A")
    
    DispatchQueue.main.async {
        print("B")
        
        DispatchQueue.global().async { //из за того что тут sync будет ожидание - если бы async то сначала бы G потом E - даже без sleep
            //sleep(1)
            print("E")
        }
    }
    
    DispatchQueue.main.async {
        print("G")
    }
}
//doSomething8()
//A B E G


func doSomething9() {
    var counter = 0
    let semaphore = DispatchSemaphore(value: 1)

    DispatchQueue.concurrentPerform(iterations: 10) { i in
        semaphore.wait()
        print("wait \(i)")
        counter += 1
        
        semaphore.signal()
        print("signal \(i)")
    }
}
//doSomething9()
/*
 Если 0 то ничего не запустится.
 Если 1 то будут входить по 1
    wait 0
    signal 0
    wait 1
    signal 1
 
 Если 2 то по 2 и тд
 */

func doSomething10() {
    let operationQueue = OperationQueue()

    let operation1 = BlockOperation {
        print("Operation 1 is running")
        sleep(3)
    }

    let operation2 = BlockOperation {
        print("Operation 2 is running")
    }

    operation2.addDependency(operation1)
    operationQueue.addOperations([operation1, operation2], waitUntilFinished: false)
    operationQueue.addBarrierBlock {
        print("All operations are completed")
    }
}
//doSomething10()


 
class Counter {
    private var value: Int = 0
    private let lock = NSLock()
    
    func increment() {
        lock.lock()
        value += 1
        lock.unlock()
    }
    
    func getValue() -> Int {
        lock.lock()
        let currentValue = value
        lock.unlock()
        return currentValue
    }
}

func getSomething11() {
    let counter = Counter()
    let group = DispatchGroup()
    
    for _ in 0..<10 {
        group.enter()
        DispatchQueue.global().async {
            counter.increment()
            group.leave()
        }
    }
    
    group.notify(queue: .main) {
        let finalValue = counter.getValue()
        print("Final counter value: \(finalValue)")
    }
}
getSomething11()
