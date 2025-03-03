public class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public var next: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.next = nil
    }
}
 
/*
 You are given a perfect binary tree where all leaves are on the same level, and every parent has two children. The binary tree has the following definition:

 struct Node {
   int val;
   Node *left;
   Node *right;
   Node *next;
 }
 Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.

 Initially, all next pointers are set to NULL.
 */
class Solution {
    func connect(_ root: Node?) -> Node? {
        guard let root = root else {
            return nil
        }
        
        var leftmost: Node? = root
        
        while leftmost != nil {
            var head: Node? = leftmost
            
            while head != nil {
                if let left = head?.left {
                    left.next = head?.right
                }
                if let right = head?.right {
                    right.next = head?.next?.left
                }
                head = head?.next
            }
            
            leftmost = leftmost?.left
        }
        
        return root
    }
}


func connect(_ root: Node?) -> Node? {
    
    if root == nil {
        return nil
    }
    var queue = [Node]()
    queue.append(root!)
    
    while !queue.isEmpty {
        var n = queue.count
        var nextQueue = [Node]()
        for i in 0...n-1 {
            queue[i].next = i == n-1 ? nil : queue[i+1]
            
            if queue[i].left != nil {
                nextQueue.append(queue[i].left!)
            }
            
            if queue[i].right != nil {
                nextQueue.append(queue[i].right!)
            }
        }
        
        queue = nextQueue
    }
    return root
}

 

func connect(root: Node?) -> Node? {
    guard let root = root else { return nil }
    
    var queue: [Node] = [root]
    
    while !queue.isEmpty {
        let levelCount = queue.count
        
        for i in 0..<levelCount {
            let node = queue.removeFirst()
            
            if i < levelCount - 1 {
                node.next = queue.first
                print(queue.first?.val)
            }

            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
    }
    return root
}
 
