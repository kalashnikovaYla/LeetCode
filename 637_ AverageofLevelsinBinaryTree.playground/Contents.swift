
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class Solution {
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        guard let root = root else {return []}
        var result = [Double]()

        var queue = [root]
        while !queue.isEmpty {
            var currRes = 0
            var current = queue.count
            for i in 0..<queue.count {
                let el = queue.removeFirst()
                currRes += (el.val)
                if let left = el.left {
                    queue.append(left)
                }

                 if let right = el.right {
                    queue.append(right)
                }
            }
            let level = Double(currRes)/Double(current)
            result.append(level)
            
        }
        return result
    }
}



func averageOfLevels(_ root: TreeNode?) -> [Double] {
    guard let root else {
        return [0.0]
    }
    var result: [Double] = []
    var nodeQueue: [TreeNode] = []
    nodeQueue.append(root)
    
    while nodeQueue.count != 0 {
        var size = nodeQueue.count
        var sum: Double = 0
        var count: Double = 0
        for _ in nodeQueue {
            let node = nodeQueue.removeFirst()
            
            if let left = node.left {
                nodeQueue.append(left)
            }
            if let right = node.right {
                nodeQueue.append(right)
            }
            
            sum = sum + Double(node.val)
            count = count + 1
        }
        result.append(sum/count)
        sum = 0
        count = 0
    }
    return result
}
