//
//  EKAVLTreeNode.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/29/14.
//  Swiftified by Marco Abundo on 2/25/16.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

class EKAVLTreeNode {
    
    var height = 0
    var object: NSObject
    var leftChild: EKAVLTreeNode?
    var rightChild: EKAVLTreeNode?
    
    init(object: NSObject) {
        self.object = object
    }

    func printDescription() {
        NSLog("\(self.object)")
        
        if self.leftChild != nil {
            NSLog("Left child of %@ will be the -->", self.object)
            self.leftChild!.printDescription()
        }
        
        if self.rightChild != nil {
            NSLog("Right child of %@ will be the -->", self.object)
            self.rightChild!.printDescription()
        }
    }

}
