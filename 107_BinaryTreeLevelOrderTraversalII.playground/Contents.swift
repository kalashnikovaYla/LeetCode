/*
 Given the root of a binary tree, return the bottom-up level order traversal of its nodes' values. (i.e., from left to right, level by level from leaf to root).
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
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {return []}
        var res = [[Int]]()
        var queue = [root]
        while !queue.isEmpty {
            var cL = [Int]()
            for i in 0..<queue.count {
                let el = queue.removeFirst()
                cL.append(el.val)
                if let l = el.left {
                    queue.append(l)
                }
                if let r = el.right {
                    queue.append(r)
                }
            }
            res.append(cL)
        }
        return res.reversed()
    }
}
