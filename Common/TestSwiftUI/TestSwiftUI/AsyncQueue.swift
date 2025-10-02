//
//  AsyncQueue.swift
//  TestSwiftUI
//
//  Created by Юлия on 02/10/25.
//

public struct AsyncQueue: Sendable {
    private let taskStreamContinuation: AsyncStream<@Sendable () async -> Void>.Continuation
    
    public init(priority: TaskPriority? = nil) {
        let (stream, continuation) = AsyncStream<@Sendable() async -> Void>.makeStream()
        self.taskStreamContinuation = continuation
        
        Task.detached(priority: priority) {
            for await task in stream {
                await task()
            }
        }
    }
    
    public func close() {
        taskStreamContinuation.finish()
    }
    
    public func enqueue(_ task: @escaping @Sendable () async -> Void) {
        taskStreamContinuation.yield(task)
    }
    
    public func enqueueAndWait<T: Sendable>(_ task: @escaping @Sendable () async -> T) async -> T {
        await withUnsafeContinuation { continuation in
            taskStreamContinuation.yield {
                continuation.resume(returning: await task())
            }
        }
    }
}
