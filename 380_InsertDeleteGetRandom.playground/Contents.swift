/*
 Implement the RandomizedSet class:

 RandomizedSet() Initializes the RandomizedSet object.
 bool insert(int val) Inserts an item val into the set if not present. Returns true if the item was not present, false otherwise.
 bool remove(int val) Removes an item val from the set if present. Returns true if the item was present, false otherwise.
 int getRandom() Returns a random element from the current set of elements (it's guaranteed that at least one element exists when this method is called). Each element must have the same probability of being returned.
 You must implement the functions of the class such that each function works in average O(1) time complexity.

 Input
 ["RandomizedSet", "insert", "remove", "insert", "getRandom", "remove", "insert", "getRandom"]
 [[], [1], [2], [2], [], [1], [2], []]
 Output
 [null, true, false, true, 2, true, false, 2]

 Explanation
 RandomizedSet randomizedSet = new RandomizedSet();
 randomizedSet.insert(1); // Inserts 1 to the set. Returns true as 1 was inserted successfully.
 randomizedSet.remove(2); // Returns false as 2 does not exist in the set.
 randomizedSet.insert(2); // Inserts 2 to the set, returns true. Set now contains [1,2].
 randomizedSet.getRandom(); // getRandom() should return either 1 or 2 randomly.
 randomizedSet.remove(1); // Removes 1 from the set, returns true. Set now contains [2].
 randomizedSet.insert(2); // 2 was already in the set, so return false.
 randomizedSet.getRandom(); // Since 2 is the only number in the set, getRandom() will always return 2.

 */


import Foundation

class RandomizedSet {
    private var v: [Int]
    private var pos: [Int: Int]

    init() {
        v = []
        pos = [:]
    }

    func insert(_ val: Int) -> Bool {
        if pos[val] != nil {
            return false
        }
        pos[val] = v.count
        v.append(val)
        return true
    }

    func remove(_ val: Int) -> Bool {
        if pos[val] == nil {
            return false
        }
        let index = pos[val]!
        if index != v.count - 1 {
            let last = v[v.count - 1]
            pos[last] = index
            v[index] = last
        }
        v.removeLast()
        pos.removeValue(forKey: val)
        return true
    }

    func getRandom() -> Int {
        let size = v.count
        let randIndex = Int(arc4random_uniform(UInt32(size)))
        return v[randIndex]
    }
}

let obj = RandomizedSet()
let param_1 = obj.insert(1)
let param_2 = obj.remove(2)
let param_3 = obj.insert(2)
let param_4 = obj.getRandom()
let param_5 = obj.remove(1)
let param_6 = obj.insert(2)
let param_7 = obj.getRandom()


class RandomizedSet2 {
    private var dict: [Int: Int]
    private var list: [Int]
    
    init() {
        dict = [:]
        list = []
    }
    
    func insert(_ val: Int) -> Bool {
        if dict[val] != nil {
            return false
        }
        list.append(val)
        dict[val] = list.count - 1
        return true
    }
    
    func remove(_ val: Int) -> Bool {
        guard let index = dict[val] else {
            return false
        }
        
        let lastElement = list[list.count - 1]
        list[index] = lastElement
        dict[lastElement] = index
        
        list.removeLast()
        dict.removeValue(forKey: val)   
        
        return true
    }
    
    func getRandom() -> Int {
        return list.randomElement()!
    }
}
