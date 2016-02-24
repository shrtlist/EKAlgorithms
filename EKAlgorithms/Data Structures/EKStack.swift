//
//  EKStack.swift
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.10.13.
//  Swiftified by Marco Abundo on 02/03/16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

class EKStack {

    private var stackArray = [AnyObject]()
    private let maxStackSize: Int

    // MARK: Convenience init

    convenience init() {
        self.init(size: Int.max)
    }

    // MARK: Init with limited size of stack

    init(size: Int) {
        if (size > 0) {
            maxStackSize = size
        }
        else {
            maxStackSize = Int.max
        }
    }

    // MARK: Public API

    func popLastObject() -> AnyObject? {
        if let object = peek() {
            stackArray.removeLast()
        
            return object
        }
        else {
            return nil
        }
    }

    func push(object: AnyObject) {
        if isFull() {
            NSLog("Stack is full")
            return
        }
        
        stackArray.append(object)
    }

    func peek() -> AnyObject? {
        if stackArray.count > 0 {
            return stackArray.last
        }
        
        return nil
    }

    func sizeOfStack() -> Int {
        return stackArray.count
    }

    func isEmpty() -> Bool {
        return stackArray.count == 0
    }

    func isFull() -> Bool {
        return sizeOfStack() == maxStackSize
    }

    func clear() {
        stackArray.removeAll()
    }

    func allObjectsFromStack() -> [AnyObject] {
        var buffer = [AnyObject]()
        
        for object in stackArray {
            buffer.append(object)
        }
        
        return buffer
    }
}
