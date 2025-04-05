/*
 Implement pow(x, n), which calculates x raised to the power n (i.e., xn).

  

 Example 1:

 Input: x = 2.00000, n = 10
 Output: 1024.00000
 
 Example 2:

 Input: x = 2.10000, n = 3
 Output: 9.26100
 
 Example 3:

 Input: x = 2.00000, n = -2
 Output: 0.25000
 Explanation: 2-2 = 1/22 = 1/4 = 0.25

 Этот метод, известный как "быстрое возведение в степень", позволяет вычислять степень гораздо быстрее, чем просто умножать число само на себя \( n \) раз, особенно при больших значениях \( n \).
 
Этот цикл работает по принципу "разделяй и властвуй":
- Пока `currentExponent` больше 0, мы проверяем, является ли оно нечетным (т.е. `currentExponent % 2 == 1`).
  - Если нечетное, то мы перемножаем `result` на `currentProduct`, то есть мы добавляем текущий множитель в результат.
 
- Затем мы "квадратим" `currentProduct`, то есть умножаем его на себя. Это позволяет нам уменьшить степень вдвое.
- Уменьшаем `currentExponent` в два раза (используя целочисленное деление).
 
 
 число, возведенное в отрицательную степень, равно единице, деленной на это число, возведенное в соответствующую положительную степень.
*/


func myPow(_ x: Double, _ n: Int) -> Double {
    
    //По математическим правилам любое число в ноль степени равно 1, поэтому если n = 0, функция сразу возвращает 1.0.
    if n == 0 {
        return 1.0
    }
    
    
    let (base, exponent) = n > 0 ? (x, n) : (1 / x, -n)
    
    var result = 1.0
    var currentProduct = base //9
    var currentExponent = exponent //2 //3
    
    while currentExponent > 0 {
        if currentExponent % 2 == 1 {
            result *= currentProduct // 1 * 81
        }
        currentProduct *= currentProduct//81
        currentExponent /= 2
    }
    
    return result
}
 
myPow(9.0, 2)
 
