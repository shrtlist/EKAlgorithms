//
//  EKBTree.swift
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Swiftified by Marco Abundo on 02/07/16.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

#if TARGET_OS_IPHONE
//#import "NSObject+EKComparisonForIOS.h"
#endif


class EKBTree {
    
    var root: EKBTreeNode

    init(object: AnyObject) {
        self.root = EKBTreeNode(object: object as! NSObject)
    }

    func insertNode(node: EKBTreeNode, parent: EKBTreeNode, isLeftChild value: Bool) -> Bool {
        if (value == true && parent.leftChild == nil) {
            parent.leftChild = node
        }
        else if (parent.rightChild == nil) {
            parent.rightChild = node
        }
        else {
            assert(parent.leftChild != nil || parent.rightChild != nil, "Can't insert into parent node!")
            return false
        }
        return true
    }

    func find(object: AnyObject) -> EKBTreeNode? {
        let queue = EKQueue()
        queue.insertObject(self.root)
        while !queue.isEmpty() {
            let node = queue.removeFirstObject()! as! EKBTreeNode
            
            let nodeObject = node.object

            if nodeObject.isEqualTo(object) {
                return node
            }
            
            if let leftChild = node.leftChild {
                queue.insertObject(leftChild)
            }
            
            if let rightChild = node.rightChild {
                queue.insertObject(rightChild)
            }
        }
        return nil
    }

    func preOrderTraversal() {
        EKBTree.preOrderTraversalRecursive(self.root)
    }

    func inOrderTraversal() {
        EKBTree.inOrderTraversalRecursive(self.root)
    }

    func postOrderTraversal() {
        EKBTree.postOrderTraversalRecursive(self.root)
    }

    func levelOrderTraversal() {
        let queue = EKQueue()
        queue.insertObject(self.root)
        while !queue.isEmpty() {
            let currentNode = queue.removeFirstObject()! as! EKBTreeNode
            
            if let leftChild = currentNode.leftChild {
                queue.insertObject(leftChild)
            }
            
            if let rightChild = currentNode.rightChild {
                queue.insertObject(rightChild)
            }
            
            NSLog("\(currentNode.object)")
        }
    }

    static func preOrderTraversalRecursive(node: EKBTreeNode) {
        NSLog("%@", node.object)
        EKBTree.preOrderTraversalRecursive(node.leftChild!)
        EKBTree.preOrderTraversalRecursive(node.rightChild!)
    }

    static func inOrderTraversalRecursive(node: EKBTreeNode) {
        EKBTree.inOrderTraversalRecursive(node.leftChild!)
        NSLog("%@", node.object)
        EKBTree.inOrderTraversalRecursive(node.rightChild!)
    }

    static func postOrderTraversalRecursive(node: EKBTreeNode) {
        EKBTree.postOrderTraversalRecursive(node.leftChild!)
        EKBTree.postOrderTraversalRecursive(node.rightChild!)
        NSLog("%@", node.object)
    }

}
