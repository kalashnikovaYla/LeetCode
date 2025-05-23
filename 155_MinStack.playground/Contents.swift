/*

 Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

 Implement the MinStack class:

 MinStack() initializes the stack object.
 void push(int val) pushes the element val onto the stack.
 void pop() removes the element on the top of the stack.
 int top() gets the top element of the stack.
 int getMin() retrieves the minimum element in the stack.
 You must implement a solution with O(1) time complexity for each function.

  

 Example 1:

 Input
 ["MinStack","push","push","push","getMin","pop","top","getMin"]
 [[],[-2],[0],[-3],[],[],[],[]]

 Output
 [null,null,null,null,-3,null,0,-2]
 
 Explanation
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin(); // return -3
 minStack.pop();
 minStack.top();    // return 0
 minStack.getMin(); // return -2
 */

class MinStack {
    private var stack: [Int]
    private var minStack: [Int]
    
    init() {
        stack = []
        minStack = []
    }
    
    func push(_ val: Int) {
        stack.append(val) 
        if minStack.isEmpty || val <= minStack[minStack.count - 1] {
            minStack.append(val)
        }
    }
    
    func pop() {
        guard let topValue = stack.popLast() else { return }
        
        if topValue == minStack[minStack.count - 1] {
            minStack.popLast()
        }
    }
    
    func top() -> Int {
        return stack.last ?? 0
    }
    
    func getMin() -> Int {
        return minStack.last ?? 0
    }
}

// Example usage:
let minStack = MinStack()
minStack.push(-2)
minStack.push(0)
minStack.push(-3)
print(minStack.getMin()) // Returns -3
minStack.pop()
print(minStack.top())    // Returns 0
print(minStack.getMin()) // Returns -2
