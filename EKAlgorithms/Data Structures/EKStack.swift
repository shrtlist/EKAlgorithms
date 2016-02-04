//
//  EKStack.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

class EKStack: NSObject {

    var stackArray: NSMutableArray
    let maxStackSize: Int

    // MARK: Default init

    override convenience init() {
        self.init(size: Int.max)
    }

    // MARK: Init with limited size of stack

    init(size: Int) {
        stackArray   = NSMutableArray()
        
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
        stackArray.removeLastObject()
        
            return object
        }
        else {
            return nil
        }
    }

    func push(object: AnyObject?) {
        if isFull() {
            NSLog("Stack is full")
            return
        }
        
        if object != nil {
            stackArray.addObject(object!)
        }
        else {
            assert(object != nil, "You can't push nil object to stack")
        }
    }

    func peek() -> AnyObject? {
        if stackArray.count > 0 {
            return stackArray.lastObject
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
        stackArray.removeAllObjects()
    }

    func allObjectsFromStack() -> NSArray {
        let buffer = NSMutableArray()
        
        for object in stackArray {
            buffer.addObject(object)
        }
        
        return buffer.copy() as! NSArray
    }
}
