//
//  EKTreeNode.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 14.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

class EKBTreeNode {
    
    var object: NSObject
    var leftChild: EKBTreeNode?
    var rightChild: EKBTreeNode?
    var parent: EKBTreeNode?
    
    init(object: NSObject) {
        self.object = object
    }

    func printDescription() {
        NSLog("\(self.object)")
        
        if self.leftChild != nil {
            NSLog("Left child of \(self.object) will be the -->")
            self.leftChild!.printDescription()
        }
        
        if self.rightChild != nil {
            NSLog("Right child of \(self.object) will be the -->")
            self.rightChild!.printDescription()
        }
    }

    func isLeftChildOfParent() -> Bool {
        return self.parent!.leftChild === self ? true : false
    }

}
