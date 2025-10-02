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
   // print(Task.currentPriority) //TaskPriority.high
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
   // print(shouldBeGood) //результат не определен, то bad, то good
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
        //print("one")
    }
}
Task.detached { @MyGlobalActor in
    for i in 0..<2 {
        //print("two")
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
