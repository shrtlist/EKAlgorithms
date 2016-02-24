//
//  EKQueue.swift
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.10.13.
//  Swiftified by Marco Abundo on 02/03/16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

class EKQueue {

    private var queueArray = [AnyObject]()

    // MARK: Public API

    func insertObject(object: AnyObject) {
        queueArray.append(object)
    }

    func removeFirstObject() -> AnyObject? {
        if queueArray.count > 0 {
            let object = queueArray.removeAtIndex(0)
            return object
        }
        
        return nil
    }

    func peek() -> AnyObject? {
        if queueArray.count > 0 {
            return queueArray.first
        }
        
        return nil
    }

    func isEmpty() -> Bool {
        return queueArray.count == 0
    }

    func clear() {
        queueArray.removeAll()
    }

    func allObjectsFromQueue() -> [AnyObject] {
        var buffer = [AnyObject]()
        
        for object in queueArray {
            buffer.append(object)
        }
        
        return buffer
    }
}
