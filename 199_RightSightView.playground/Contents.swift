 
/*
Given the root of a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.
*/


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

func rightSideView(_ root: TreeNode?) -> [Int] {
    var result = [Int]()
    guard let root = root else { return result }
    
    
    var queue: [TreeNode] = [root]
    
    while !queue.isEmpty {
        let levelSize = queue.count
        for i in 0..<levelSize {
            let currentNode = queue.removeFirst()
            
            // If it's the last node in this level, append it to the result
            if i == levelSize - 1 {
                result.append(currentNode.val)
            }
            
            if let left = currentNode.left {
                queue.append(left)
            }
            if let right = currentNode.right {
                queue.append(right)
            }
        }
    }
    
    return result
}
 
let root = TreeNode(1)
let node2 = TreeNode(2)
let node3 = TreeNode(3)
let node5 = TreeNode(5)
let node4 = TreeNode(4)

root.left = node2
root.right = node3
node2.right = node5
node3.right = node4

let visibleFromRight = rightSideView(root)
print(visibleFromRight)  // Output should be [1, 3, 4] (values seen from the right side)
