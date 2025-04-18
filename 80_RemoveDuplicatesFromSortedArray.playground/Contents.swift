
/*
 
 Дано целое число массива nums, отсортированное в порядке неубывания, удалить некоторые дубликаты на месте так, чтобы каждый уникальный элемент появлялся не более двух раз. Относительный порядок элементов должен оставаться прежним.

 Поскольку в некоторых языках невозможно изменить длину массива, вместо этого вы должны поместить результат в первую часть массива nums. Более формально, если после удаления дубликатов есть k элементов, то первые k элементов nums должны содержать конечный результат. Неважно, что вы оставите после первых k элементов.

 Верните k после размещения конечного результата в первых k слотах nums.

 Не выделяйте дополнительное пространство для другого массива. Вы должны сделать это, изменив входной массив на месте с O(1) дополнительной памяти.

 Custom Judge:

 The judge will test your solution with the following code:

 int[] nums = [...]; // Input array
 int[] expectedNums = [...]; // The expected answer with correct length

 int k = removeDuplicates(nums); // Calls your implementation

 assert k == expectedNums.length;
 for (int i = 0; i < k; i++) {
     assert nums[i] == expectedNums[i];
 }
 If all assertions pass, then your solution will be accepted.

  

 Example 1:

 Input: nums = [1,1,1,2,2,3]
 Output: 5, nums = [1,1,2,2,3,_]
 Explanation: Your function should return k = 5, with the first five elements of nums being 1, 1, 2, 2 and 3 respectively.
 It does not matter what you leave beyond the returned k (hence they are underscores).
 
 Example 2:

 Input: nums = [0,0,1,1,1,1,2,3,3]
 Output: 7, nums = [0,0,1,1,2,3,3,_,_]
 Explanation: Your function should return k = 7, with the first seven elements of nums being 0, 0, 1, 1, 2, 3 and 3 respectively.
 It does not matter what you leave beyond the returned k (hence they are underscores).
 */
func removeDuplicates(_ nums: inout [Int]) -> Int {
    var dictionary = [Int: Int]()
    var index = 0
    
    while index < nums.count {
        let key = nums[index]
        
        if let value = dictionary[key] {
            if (dictionary[key] ?? 0) > 1 {
                nums.remove(at: index)
            } else {
                dictionary[key] = value + 1
                index += 1
            }
        } else {
            dictionary[key] = 1
            index += 1
        }
        
    }
    
    return nums.count
}

var array = [1,2,3,3,3,4,4,5,5,5]
//removeDuplicates(&array)
 

func removeDuplicate(_ nums: inout [Int]) -> Int {
    var currentElement: Int?
    var currentCount = 0
    var index = 0
    
    while index < nums.count {

        if currentElement != nums[index] {
            currentElement = nums[index]
            currentCount = 0
        } else {
            if currentCount < 1 {
                currentCount += 1
            } else {
                nums.remove(at: index)
                continue
            }
        }
        index += 1
    }

    return nums.count
}

removeDuplicate(&array)
 
