import Foundation


//MARK: - Sync func
actor Counter {
    private(set) var value = Int.zero
    
    func increment() {
        value += 1
    }
}

let counter = Counter()

Task {
    let currentValue = await counter.value
    print(Task.currentPriority) //TaskPriority.high
    await counter.increment()
}

//MARK: - Async actor func + Actor Reentrancy

enum Opinion {
    case good
    case bad
    case noIdea
}

actor Friend {
    func tellOpinion(_ opinion: Opinion) {}
}

actor Person {
    let friend: Friend
    var opinion: Opinion = .noIdea
    
    init(friend: Friend) {
        self.friend = friend
    }
    
    func thinkOfGood() async -> Opinion {
        opinion = .good
        await friend.tellOpinion(opinion)
        return opinion
    }
    
    func thinkOfBad() async -> Opinion {
        opinion = .bad
        await friend.tellOpinion(opinion)
        return opinion
    }
}

let friend = Friend()
let persone = Person(friend: friend)

Task {
    async let goodThink = persone.thinkOfGood()
    async let badThink = persone.thinkOfBad()

    let (shouldBeGood, shouldBeBad) = await (goodThink, badThink)
    print(shouldBeGood) //результат не определен, то bad, то good
}


//MARK: - Cash

actor Storage {
    var cache = [UUID: Task<Data?, Never>]()
    
    func getHeavyData(for key: UUID) async -> Data? {
        if let doneTask = cache[key] {
            return await doneTask.value
        }
        
        let task = Task {
            await requestDataFromDatabase(for: key)
        }
        cache[key] = task
        return await task.value
    }
    
    private func requestDataFromDatabase(for id : UUID) async -> Data? {
        try? await Task.sleep(for: .seconds(7))
        return nil
    }
}

enum StorageError: Error {
    case dataNotFound
    case otherError(String)
}

actor StorageWithError {
    var cache = [UUID: Task<Data?, Error>]()
    
    func getHeavyData(for key: UUID) async throws -> Data? {
        if let doneTask = cache[key] {
            return try await doneTask.value
        }
        
        let task = Task<Data?, Error> {
            do {
                if let data = try await requestDataFromDatabase(for: key) {
                    return data
                } else {
                    throw StorageError.dataNotFound
                }
            } catch {
                throw error
            }
        }
        cache[key] = task
        return try await task.value
    }
    
    private func requestDataFromDatabase(for id : UUID) async -> Data? {
        try? await Task.sleep(for: .seconds(7))
        return nil
    }
}


//MARK: - Actor hopping

actor ActorA {
    private var data: Int = 0
    
    func updateData(with value: Int) {
        data = value
    }
}

actor ActorB {
    private var value: Int = 0
    
    func performUpdate(on actorA: ActorA) async {
        await actorA.updateData(with: value)
    }
}


//MARK: - Sendable
let sendableClosure = { @Sendable (number: Int) -> String in
    if number > 12 {
        return "More than 12"
    } else {
        return "Less than 12"
    }
}


//MARK: - Global actor
///class/struct не даст использовать
@globalActor
final actor MyGlobalActor: GlobalActor {
    static let shared = MyGlobalActor()
    private init() {}
}

///Если убрать @MyGlobalActor, вывод пойдет не по порядку
///Attribute  'GlobalActor' is not supported on a closure -  'GlobalActor' не получится поставить, но можно @MainActor, обязательно у обоих
Task.detached { @MyGlobalActor in
    for i in 0..<2 {
        print("one")
    }
}
Task.detached { @MyGlobalActor in
    for i in 0..<2 {
        print("two")
    }
}
/*
 one
 one
 one
 two
 two
 two
 */


//MARK: GCD + Structured Concurrency
final class MyClass {
    @MainActor
    func callMainActorMethod() {
        print(Thread.isMainThread ? "Main Thread" : "Background Thread")
    }
}

func execute() {
    DispatchQueue.global(qos: .background).async {
        let myClass = MyClass()
        //myClass.callMainActorMethod() //уже не запустится Call to main actor-isolated instance method 'callMainActorMethod()' in a synchronous nonisolated context
    }
}


//MARK: - Nonisolated

actor LocalCache<T> {
    private var value: T?
    nonisolated let lifetime: TimeInterval
    
    var cacheValue: T? {
        value
    }
    
    init(initialValue: T, lifetime: TimeInterval) {
        self.value = initialValue
        self.lifetime = lifetime
    }
    
    func setNewCachValue(_ newValue: T) {
        self.value = newValue
    }
    
    func dropCachedValue() {
        self.value = nil
    }
}
let cache = LocalCache(initialValue: "Hello", lifetime: 10)

Task {
    await cache.setNewCachValue("World")
    await cache.dropCachedValue()
    let lifetimeValue = cache.lifetime
}


//MARK: - Protocol

protocol AnyService {
    func doSomething()
}

actor Service: AnyService {
    ///Без  nonisolated - Actor-isolated instance method 'doSomething()' cannot be used to satisfy nonisolated protocol requirement
    nonisolated func doSomething() {}
}

protocol AnyAsyncService {
    func doSomething() async
}

actor AsyncService: AnyAsyncService {
    func doSomething() async {}
}


//MARK: - Continuation
func loadData(by id: Int, completion: @escaping (Data) -> Void) { }

///- Осторожно проверяет, что `resume` вызывается ровно один раз.
///- Можно использовать только один вызов `resume`.
///- Хорошо подходит для простых случаев, когда callback возвращает один результат.
///- Часто применяется при оборачивании функций с одним `completion`.
func fetchData(by id: Int) async -> Data {
    await withCheckedContinuation { continuation in
        loadData(by: id) { data in
             continuation.resume(returning: data)
        }
    }
}

///- Для ситуаций, когда callback может завершиться не только успешно, но и с ошибкой.
///- Возвращает `async throws`, и `resume` вызывается либо с `returning`, либо с `throwing`.
func fetchData() async throws -> String {
    return try await withCheckedThrowingContinuation { continuation in
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            continuation.resume(returning: "Данные успешно получены")
        }
    }
}

func fetchDataUnsafe() async throws -> String {
    return try await withUnsafeThrowingContinuation { continuation in
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            // Вызов resume — ответственность за корректность возлагается на разработчика
            continuation.resume(returning: "Данные успешно получены (unsafe)")
            // Следует быть аккуратным: деопределять, что вызов resuming случится только один раз
        }
    }
}



//MARK: - Cancel task


func performTask() async {
    do {
        for i in 1...10 {
            ///Проверяет, отменена ли текущая задача, и выбрасывает ошибку `CancellationError`, если отмена действительно произошла.
            try Task.checkCancellation()
            print("Выполнение итерации \(i)")
            try await Task.sleep(nanoseconds: 1_000_000_000)
        }
    } catch is CancellationError {
        print("Задача отменена (CancellationError перехвачена)")
    } catch {
        print("Произошла другая ошибка: (error)")
    }
}

let task = Task {
    await performTask()
}
task.cancel() //Задача отменена (CancellationError перехвачена)"

func performTaskTwo() async {
    do {
        for i in 1...4 {
            ///Когда использовать: Когда нужно просто проверить состояние отмены без выбрасывания исключения.
            if !Task.isCancelled {
                print("Выполнение итерации \(i)")
                try await Task.sleep(nanoseconds: 1_000_000_000)
            }
        }
    } catch {
        print("Задача отменена")
    }
}

let task2 = Task {
    await performTaskTwo()
}
task2.cancel()
 


func fetchData(url: URL) async throws -> Data {
    return try await withCheckedThrowingContinuation { continuation in
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
           print("Task execute")
            if let error = error {
                continuation.resume(throwing: error)
            } else if let data = data {
                continuation.resume(returning: data)
            } else {
                continuation.resume(throwing: URLError(.badServerResponse))
            }
        }

        guard !Task.isCancelled else {
            //continuation.resume(throwing: CancellationError())
            task.cancel()
            return
        }
        task.resume()
    }
}

let url = URL(string: "https://example.com")!
let task3 = Task {
    if let data = try? await fetchData(url: url) {
    } else {
        print("Ошибка загрузки данных или задача была отменена")
    }
}

task3.cancel() //Тут отмены не произойдет если будем использовать внутри, нужно использовать др метод


actor Networking {
    var currentTask: Task<Data, Error>?

    func fetchData(from url: URL) async throws -> Data {
        currentTask?.cancel()

        let task = Task<Data, Error> {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                print("Получено данных: \(data.count) байт")
                return data
            } catch {
                if (error as NSError).code == NSURLErrorCancelled {
                    print("Запрос был отменен")
                } else {
                    print("Ошибка: \(error.localizedDescription)")
                }
                throw error
            }
        }
        currentTask = task
        return try await task.value
    }

    func cancel() {
        currentTask?.cancel()
    }
}


//MARK: - Task Async call

actor AsyncTest {
    func test1() -> String { return "test1"}
    func test2() -> String { return "test2"}
    func test3() -> String { return "test3"}
}

let asyncTestActor = AsyncTest()

//Последовательно
Task(priority: .high) {
    let first = await asyncTestActor.test1()
    let second = await asyncTestActor.test2()
    let third = await asyncTestActor.test3()
}

//Паралелльно

Task(priority: .high) {
    async let first = asyncTestActor.test1()
    async let second = asyncTestActor.test2()
    async let third = asyncTestActor.test3()
    
    let (f, s, t) = await (first, second, third)
    print(f) //test1
}

//MARK: - Task Group
func fetchDataWithThrow(from url: URL, index: Int) async throws -> (Data, Int) {
    let (data, _) = try await URLSession.shared.data(from: url)
    return (data, index)
}

func loadMultipleURLsWithThrow(urls: [URL]) async throws -> [Data] {
    try await withThrowingTaskGroup(of: (Data, Int).self,
                                    returning: [Data].self) { group in
        
        urls.enumerated().forEach { index, url in
            group.addTask {
                try await fetchDataWithThrow(from: url, index: index)
            }
        }
        
        var results = [Data](repeating: Data(), count: urls.count)
        for try await (data, index) in group {
            results[index] = data
        }
        return results
    }
}

func fetchData(from url: URL, index: Int) async -> (Data?, Int) {
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        return (data, index)
    } catch {
        return (nil, index)
    }
}

func loadMultipleURLs(urls: [URL]) async -> [Data] {
    await withTaskGroup(of: (Data?, Int).self) { group in
        for (index, url) in urls.enumerated() {
            group.addTask {
                await fetchData(from: url, index: index)
            }
        }
        
        var results = [Data?](repeating: nil, count: urls.count)
        for await (data, index) in group {
            if let data = data {
                results[index] = data
            }
        }
        return results.compactMap { $0 }
    }
}

 
 
//MARK: - AsyncSequence
struct AsyncCounter: AsyncSequence {
    let limit: Int

    struct AsyncIterator: AsyncIteratorProtocol {
        let limit: Int
        var current = 1

        mutating func next() async -> Int? {
            guard !Task.isCancelled else {
                return nil
            }

            guard current <= limit else {
                return nil
            }
            let result = current
            current += 1
            return result
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(limit: limit)
    }
}

 
func printAsyncCounter() async {
    for await number in AsyncCounter(limit: 10) {
        print(number, terminator: " ")
    }
}

Task {
    await printAsyncCounter()
}


//MARK: - Async Stream

///AsyncStream в Swift — это структура, которая позволяет создавать асинхронные последовательности значений. Она была введена в Swift 5.5 как часть расширений для работы с асинхронным программированием и предоставляет удобный способ для работы с потоками данных, которые могут поступать по мере их получения.
///AsyncStream позволяет вам генерировать последовательности значений, которые могут быть получены асинхронно. Это полезно для работы с данными, которые могут поступать из сетевых запросов, событий пользовательского интерфейса или других асинхронных источников.
func createAsyncStream() -> AsyncStream<Int> {
    return AsyncStream { continuation in
        Task {
            for number in 1...5 {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                continuation.yield(number)
            }
            continuation.finish()
        }
    }
}

let asyncStream = createAsyncStream()

Task {
    for await number in asyncStream {
        print("Received number: \(number)")
    }
    print("Stream finished.")
}

