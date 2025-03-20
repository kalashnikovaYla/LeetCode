/*
 You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

 Merge all the linked-lists into one sorted linked-list and return it.

  

 Example 1:

 Input: lists = [[1,4,5],[1,3,4],[2,6]]
 Output: [1,1,2,3,4,4,5,6]
 Explanation: The linked-lists are:
 [
   1->4->5,
   1->3->4,
   2->6
 ]
 merging them into one sorted list:
 1->1->2->3->4->4->5->6
 Example 2:

 Input: lists = []
 Output: []
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) {
        self.val = val; 
        self.next = nil;
    }
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val;
        self.next = next;
    }
}
  


class Solution {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var arr = [Int]()

        for var list in lists
        {
            while list != nil
            {
                arr.append(list?.val ?? 0)
                list = list?.next
            }
        }
        arr = arr.sorted()

        var current: ListNode? = ListNode(0)
        var next = current

        for i in arr
        {
            current?.next = ListNode(i)
            current = current?.next
        }

        return next?.next
    }
}
