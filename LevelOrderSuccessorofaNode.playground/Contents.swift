


class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

func levelOrderSuccessor(root: TreeNode?, target: TreeNode?) -> TreeNode? {
    guard let root = root, let target = target else {
        return nil
    }
    
    var queue: [TreeNode] = [root]
    var foundTarget = false
    
    while !queue.isEmpty {
        let currentNode = queue.removeFirst()
        
        // Если мы нашли целевой узел, то нам нужно вернуть следующий узел в очереди
        if foundTarget {
            return currentNode
        }
        
        if currentNode === target {
            foundTarget = true
        }
        
        if let left = currentNode.left {
            queue.append(left)
        }
        
        if let right = currentNode.right {
            queue.append(right)
        }
    }
 
    return nil
}

// Пример использования
let root = TreeNode(1)
let node2 = TreeNode(2)
let node3 = TreeNode(3)
let node4 = TreeNode(4)
let node5 = TreeNode(5)

root.left = node2
root.right = node3
node2.left = node4
node2.right = node5

if let successor = levelOrderSuccessor(root: root, target: node2) {
    print("Level Order Successor of \(node2.val) is \(successor.val)")
} else {
    print("Level Order Successor not found.")
}
