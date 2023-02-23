/*
 Given a non-negative integer x, return the square root of x rounded down to the nearest integer. The returned integer should be non-negative as well.

 You must not use any built-in exponent function or operator.

 For example, do not use pow(x, 0.5) in c++ or x ** 0.5 in python.
  

 Example 1:

 Input: x = 4
 Output: 2
 Explanation: The square root of 4 is 2, so we return 2.
 Example 2:

 Input: x = 8
 Output: 2
 Explanation: The square root of 8 is 2.82842..., and since we round it down to the nearest integer, 2 is returned.
  
 */

func mySqrt(_ x: Int) -> Int {
    if x == 0 || x == 1 {
        return x
    }
    var low = 1, height = x, mid = -1
    
    while low <= height {
        mid = low + (height - low) / 2
        if mid <= x/mid && (mid + 1) > x/(mid + 1) {
            return mid
        } else if mid < x/mid{
            low = mid + 1
        } else {
            height = mid - 1
        }
    }
    return mid
}
