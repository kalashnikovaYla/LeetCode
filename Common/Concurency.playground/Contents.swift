 
import Foundation
import UIKit

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

 Вот если бы было sync
 <_NSMainThread: 0x60000170c000>{number = 1, name = main}
 1
 2
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
   
    //Concurency(66666,0x104ff0200) malloc: Heap corruption detected, free list is damaged at 0x600000c2afa0
    DispatchQueue.concurrentPerform(iterations: 1000) { i in
        array.append(i)
    }
    print("array = \(array.count)")
}
//example2()


func example3(){
    let queue = DispatchQueue(label: "array.queue")
    DispatchQueue.concurrentPerform(iterations: 1000) { i in
        queue.sync {
            array.append(i)
        }
    }
    print("array = \(array.count)")
}
//example3() //краша не случится

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


func example4() {
    let logger = Loger()
    DispatchQueue.concurrentPerform(iterations: 1000) { i in
        logger.addEvent(log: String(i))
    }
    print(logger.logs.count)
}
//example4() //1000


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

/*
 Operation 1 is running
 Operation 2 is running
 All operations are completed
 */
 
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

func doSomething11() {
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
//doSomething11()

func doSomething12() {
    print("2")
    DispatchQueue.main.async {
        print("3")
        
        DispatchQueue.main.sync {
            print("4")
        }
        print("5")
    }
    print("6")
}
 
/*
 print("1")
 doSomething12()
 print("7")
 1
 2
 6
 7
 3
 */


@MainActor
class ViewModel: ObservableObject {
    func runTest() async {
        print("1")
        await MainActor.run {
            print("2")
            Task { @MainActor in
                print("3")
            }
            print("4")
        }
        print("5")
    }
}

func doSomething13() {
    Task {
        let vm = await ViewModel()
        await vm.runTest()
    }
}
//doSomething13()
/*
 1
 2
 4
 5
 3
 */

var counter = 0

func doSomething14(){
    
    
    func asyncIncrement() {
        DispatchQueue.global().async {
            for _ in 0..<1000 {
                counter += 1
            }
        }
    }
    
    func asyncDecrement() {
        DispatchQueue.global().async {
            for _ in 0..<1000 {
                counter -= 1
            }
        }
    }
    
    asyncIncrement()
    asyncDecrement()
    Thread.sleep(forTimeInterval: 1.0)
    print(counter)
}

//doSomething14() //резултат неопределен

func doSomething15() {
    DispatchQueue.global().async {
        print("1")
        DispatchQueue.global().sync {
            print("2")
        }
        DispatchQueue.global().async {
            print("3")
        }
        print("4")
    }
}
//doSomething15() //1 2 4 3


func doSomething16() {
    let group = DispatchGroup()
   
    group.enter()
    DispatchQueue.global().sync {
        print("watermelon")
        group.leave()
    }
    
    group.enter()
    DispatchQueue.main.async {
        print("avocado")
        group.leave()
    }
    
    group.enter()
    DispatchQueue.main.async {
        print("peach")
        group.leave()
    }
    group.notify(queue: .main) {
        print("apple")
    }
}
//doSomething16()
/*
 watermelon
 avocado
 peach
 apple
 */


func doSomething17() {
    class CustomOperation: Operation {
        override func main() {
            sleep(2)
            print("Custom operation")
        }
    }
    
    let queue = OperationQueue()
    for _ in 1...3 {
        let operation = CustomOperation()
        queue.addOperation(operation)
    }
    
    print("start")
    queue.waitUntilAllOperationsAreFinished()
    print("Finished")
}
//doSomething17()
/*
 start
 Custom operation
 Custom operation
 Custom operation
 Finished
 */


func doSomething18() {
    
    print("1")
    DispatchQueue.global().sync {
        sleep(10)
        print("2")
        DispatchQueue.main.sync {
             
            print("3")
        }
        
        print("4")
    }
    print("5")
}
 
//doSomething18() //1 2 deadlock


func doSomething19() async -> Int {
    print("1")
    Task {
        print("2")
        Task { @MainActor in
            print("3")
        }
        print("4")
    }
    print("5")
    return 6
}


/*
 Поскольку мы уже находимся в главном потоке, декоратор @MainActor добавит следующую задачу для выполнения на главном потоке, как только он освободится.  Система вызовет принт 1 и 5, затем выполнит задачу и вызовет печать 2 и 4, а также добавит следующую задачу в главный поток, где мы находимся. Поэтому система вернет 6 и напечатает это число. Только после этого система выполнит ожидающую задачу MainActor для вызова печати 3
 1 5 2 4 6 3
 */


func doSomething20() {
    func processNumbers(numbers: [Int], completion: @escaping(Int) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var sum = 0
            for number in numbers {
                sum += number
            }
            completion(sum)
        }
    }
    
    processNumbers(numbers: [1,2,3,4,5]) { result in
        print("the sum \(result)")
    }
    print("end")
}
//doSomething20()
/*
 end
 the sum 15
 */


func doSomething21() {
    let queue = DispatchQueue(label: "label", attributes: .concurrent)
    var result = [Int]()
    for i in 0..<5 {
        queue.async {
            result.append(i)
        }
    }
    queue.async {
        print(result)
    }
}
//doSomething21()
//?

struct Adverb {
    let id: String
}
func getAdverb(id: String, completion: @escaping(Adverb) -> Void) {
    sleep(1)
    completion(Adverb(id: id))
}

func getAdverb(id: String) async -> Adverb {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return Adverb(id: id)
}

func asyncGetAdverbs(ids: [String]) async -> [Adverb] {
    return await withTaskGroup(of: (Int, Adverb).self) { group in
        for (index, id) in ids.enumerated() {
            group.addTask {
                let adverb = await getAdverb(id: id)
                return (index, adverb)
            }
        }
        
        var tempResults = Array<Adverb?>(repeating: nil, count: ids.count)
        
        for await (index, adverb) in group {
            tempResults[index] = adverb
        }
        
        return tempResults.compactMap { $0 }
    }
}

func getAdverbs(ids: [String],  completion: @escaping([Adverb]) -> Void) {
    let group = DispatchGroup()
    
    var array: [Adverb?] = Array(repeating: nil, 
                                 count: ids.count)

    for (index, id) in ids.enumerated() {
        group.enter()
        getAdverb(id: id) { adverb in
            array[index] = adverb
            group.leave()
        }
    }
    group.notify(queue: .main) {
        let nonNilArray = array.compactMap { $0 }
        completion(nonNilArray)
    }
}

func doSomething22() {
    let range = 1...25
    let ids = range.map {
        String($0)
    }
    
    getAdverbs(ids: ids) { array in
        print(array)
    }
}
//doSomething22()

func doSomething23() {
    let range = 1...25
    let ids = range.map {
        String($0)
    }
    
    Task {
        let result = await asyncGetAdverbs(ids: ids)
        print(result)
    }
}

//doSomething23()


func doSomething25() {
    let queue = DispatchQueue(label: "example", attributes: .concurrent)
    var result = [Int]()
    for i in 0..<5 {
        queue.async {
            result.append(i)
        }
    }
    queue.async {
        print(result)
    }
}
//doSomething25() //Порядок и результат не гарантирован
