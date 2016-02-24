//
//  Dictionary+EKStuff.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 4/11/14.
//  Swiftified by Marco Abundo on 2/14/16.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

extension Dictionary {
    
    mutating func increaseValueForKey(key: Key, by num: Int) {
        let object = self[key]
        
        if object is Int {
            let value  = object as! Int
            let result = num + value
            
            self[key] = result as? Value
        }
        else {
            assert(false, "Object is not a instance of Int!")
        }
    }

    mutating func selfIncreaseValueForKey(key: Key) {
        increaseValueForKey(key, by: 1)
    }

    mutating func selfDecreaseValueForKey(key: Key) {
        increaseValueForKey(key, by: -1)
    }

}
