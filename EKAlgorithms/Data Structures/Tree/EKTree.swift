//
//  EKTree.swift
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/16/14.
//  Swiftified by Marco Abundo on 02/10/16.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

class EKTree: NSObject {

    var root: EKTreeNode
    
    init(object: AnyObject) {
        self.root = EKTreeNode(object: object)
        self.root.parent = nil
    }

    func insertNode(node: EKTreeNode, leftSibling: EKTreeNode?, parent: EKTreeNode) {
        node.parent = parent
        
        if (leftSibling == nil) {
            parent.child = node
        }
        else {
            leftSibling!.sibling = node
        }
    }

    func printDescription() {
        self.root.printDescription()
    }

    static func forestToBinaryTree(trees: [EKTree]) -> EKBTree? {
        if trees.count > 0 {
            // Union trees
            var previous = trees[0]
            for tree in trees {
                if tree != previous {
                    previous.root.sibling = tree.root
                    previous              = tree
                }
            }
            
            let queue = EKQueue()
            queue.insertObject(trees[0].root)
            let result = EKBTree(object: queue.peek()!.object)
            
            // Create binary tree
            while !queue.isEmpty() {
                if let node = queue.removeFirstObject() as? EKTreeNode {
                    if let root = result.find(node.object) {
                        if node.child != nil {
                            queue.insertObject(node.child!)
                            root.leftChild        = EKBTreeNode()
                            root.leftChild.object = node.child!.object as! NSObject
                            root.leftChild.parent = root
                        }
                        if node.sibling != nil {
                            queue.insertObject(node.sibling!)
                            root.rightChild        = EKBTreeNode()
                            root.rightChild.object = node.sibling!.object as! NSObject
                            root.rightChild.parent = root
                        }
                    }
                }
            }
            return result
        }
        else {
            assert(trees.count > 0, "There is no tree in array!")
            return nil
        }
    }
}
