//
//  EKDeque.swift
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 20.10.13.
//  Swiftified by Marco Abundo on 02/03/16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

class EKDeque: NSObject {

    private var dequeArray = [AnyObject]()

    // MARK: Public API

    func insertObjectToBack(object: AnyObject) {
        dequeArray.append(object)
    }

    func insertObjectToFront(object: AnyObject) {
        dequeArray.insert(object, atIndex: 0)
    }

    func removeFirstObject() -> AnyObject? {
        if dequeArray.count > 0 {
            let object = dequeArray.removeAtIndex(0)
            
            return object
        }
        
        return nil
    }

    func removeLastObject() -> AnyObject? {
        let object = dequeArray.removeLast()
        
        return object
    }

    func peekFirstObject() -> AnyObject? {
        return dequeArray.first
    }

    func peekLastObject() -> AnyObject? {
        if dequeArray.count > 0 {
            return dequeArray.last
        }
        
        return nil
    }

    func isEmpty() -> Bool {
        return dequeArray.count == 0
    }

    func clear() {
        dequeArray.removeAll()
    }

    func allObjectsFromDeque() -> [AnyObject] {
        var buffer = [AnyObject]()
        
        for object in dequeArray {
            buffer.append(object)
        }
        
        return buffer
    }

}
