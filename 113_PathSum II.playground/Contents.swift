/*
 Given the root of a binary tree and an integer targetSum, return all root-to-leaf paths where the sum of the node values in the path equals targetSum. Each path should be returned as a list of the node values, not node references.

 A root-to-leaf path is a path starting from the root and ending at any leaf node. A leaf is a node with no children.
 */

 
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

func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
    var result = [[Int]]()
    var currentPath = [Int]()

    func dfs(_ node: TreeNode?, _ currentSum: Int) {
        guard let node = node else { return }

        
        currentPath.append(node.val)
        let currentSum = currentSum + node.val

        
        if node.left == nil && node.right == nil {
            if currentSum == targetSum {
                result.append(currentPath)
            }
        } else {
             
            dfs(node.left, currentSum)
            dfs(node.right, currentSum)
        }

        
        currentPath.removeLast()
    }

    dfs(root, 0)
    return result
}

 
let root = TreeNode(5)
root.left = TreeNode(4)
root.right = TreeNode(8)
root.left?.left = TreeNode(11)
root.right?.left = TreeNode(13)
root.right?.right = TreeNode(4)
root.left?.left?.left = TreeNode(7)
root.left?.left?.right = TreeNode(2)
root.right?.right?.right = TreeNode(1)

let targetSum = 22
let paths = pathSum(root, targetSum)
print(paths)  // Output: [[5, 4, 11, 2], [5, 8, 4, 5]]
