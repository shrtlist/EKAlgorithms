//
//  EKTreeNode.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Swiftified by Marco Abundo on 02/10/16.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

class EKTreeNode: NSObject {
    
    var object: AnyObject
    var child: EKTreeNode?
    var sibling: EKTreeNode?
    var parent: EKTreeNode?
    
    init(object: AnyObject) {
        self.object = object
        super.init()
    }

    func printDescription() {
        NSLog("\(self.object)")
        
        if self.child != nil {
            NSLog("First child of \(self.object) will be the -->")
            self.child!.printDescription()
        }
        
        if self.sibling != nil {
            NSLog("Next sibling of \(self.object) will be the -->")
            self.sibling!.printDescription()
        }
    }

}
