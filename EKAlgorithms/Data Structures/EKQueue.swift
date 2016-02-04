//
//  EKQueue.swift
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.10.13.
//  Swiftified by Marco Abundo on 02/03/16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

class EKQueue: NSObject {

    var queueArray: NSMutableArray

    // MARK: init

    override init() {
        queueArray = NSMutableArray()
        super.init()
    }

    // MARK: Public API

    func insertObject(object: AnyObject) {
        queueArray.addObject(object)
    }

    func removeFirstObject() -> AnyObject? {
        if queueArray.count > 0 {
            let object = peek()
            queueArray.removeObjectAtIndex(0)
            return object
        }
        
        return nil
    }

    func peek() -> AnyObject? {
        if queueArray.count > 0 {
            return queueArray.objectAtIndex(0)
        }
        
        return nil
    }

    func isEmpty() -> Bool {
        return queueArray.count == 0
    }

    func clear() {
        queueArray.removeAllObjects()
    }

    func allObjectsFromQueue() -> [AnyObject] {
        let buffer = NSMutableArray()
        
        for object in queueArray {
            buffer.addObject(object)
        }
        
        return buffer.copy() as! [AnyObject]
    }
}
