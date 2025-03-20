 /*
  Given the root of a complete binary tree, return the number of the nodes in the tree.

  According to Wikipedia, every level, except possibly the last, is completely filled in a complete binary tree, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.

  Design an algorithm that runs in less than O(n) time complexity.

  Input: root = [1,2,3,4,5,6]
  Output: 6
  Example 2:

  Input: root = []
  Output: 0
  Example 3:

  Input: root = [1]
  Output: 1
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

class Solution {
    func countNodes(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        return countNodes(root?.left) + countNodes(root?.right) + 1
    }
}
