Task(priority: .high) {
    print("Задача запущена с высоким приоритетом")
    
    /// Задача запустится с низким приоритетом,
    /// но из-за вызова value её приоритет будет увеличен до high
    await Task(priority: .low) {
        //print(Task.currentPriority) //TaskPriority.high
    }.value
}



let task = Task {
    print("Task 1 has started")
    await startLongTask()
    print("Task 1 has finished")
   
    print("Task 2 has started")
    await startLongTask()
    print("Task 2 has finished")
}

func startLongTask() async {
    try? await Task.sleep(for: .seconds(5))
}
task.cancel()
/*
 Task 1 has started
 Task 1 has finished
 Task 2 has started
 Task 2 has finished
 */


let taskDetached = Task.detached {
    print("Task detached 1 has started")
    await startLongTask()
    print("Task detached 1 has finished")
   
    print("Task detached 2 has started")
    await startLongTask()
    print("Task detached 2 has finished")
}

func startLongTask2() async {
    try? await Task.sleep(for: .seconds(5))
}
taskDetached.cancel()
/*
 Task detached 1 has started
 Task detached 1 has finished
 Task detached 2 has started
 Task detached 2 has finished
 */
