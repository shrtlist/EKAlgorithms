//
//  EKBSTree.swift
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 14.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

class EKBSTree {

    var root: EKBTreeNode
    
    init(obj: NSObject) {
        self.root = EKBTreeNode(object: obj)
    }

    func insertObject(object: NSObject) {
        let treeNode    = EKBTreeNode(object: object)
        
        var currentNode = self.root
        var parentNode  = self.root
        
        while true {
            if object.isGreaterThan(currentNode.object) {
                if currentNode.rightChild == nil {
                    currentNode.rightChild = treeNode
                    treeNode.parent        = parentNode
                    break
                }
                else {
                    currentNode = currentNode.rightChild!
                    parentNode = currentNode;
                }
            }
            else {
                if currentNode.leftChild == nil {
                    currentNode.leftChild = treeNode
                    treeNode.parent       = parentNode
                    break;
                }
                else {
                    currentNode = currentNode.leftChild!
                    parentNode  = currentNode
                }
            }
        }
    }

    func printDescription(){
        self.root.printDescription()
    }

    func deleteObject(obj: NSObject) -> EKBTreeNode? {
        var node = self.find(obj)
        
        if node != nil {
            if node!.leftChild != nil && node!.rightChild != nil {
                    // Use in-order successor node
                var tmpCell = node!.rightChild
                
                while tmpCell!.leftChild != nil {
                    tmpCell = tmpCell!.leftChild
                }
                /*
                 // If you would like to use in-order predecessor node, uncomment this and comment code above
                 EKBTreeNode *tmpCell = node.leftChild;
                 while (tmpCell.rightChild) {
                 tmpCell = tmpCell.rightChild;
                 }
                 */
                let temp = node!.object.copy() as! NSObject
                node!.object     = tmpCell!.object.copy() as! NSObject
                tmpCell!.object  = temp
                node!.rightChild = self.deleteObject(temp)
            }
            else {
                if node!.leftChild != nil {
                    node = node!.leftChild
                }
                else if node!.rightChild != nil {
                    node = node!.rightChild
                }
                
                if node!.isLeftChildOfParent() {
                    node!.parent!.leftChild = nil
                }
                else {
                    node!.parent!.rightChild = nil
                }
            }
        }
        
        return node;
    }

    func find(obj: NSObject) -> EKBTreeNode? {
        var currentNode = self.root
        
        while (true) {
            if obj.isGreaterThan(currentNode.object) {
                if currentNode.rightChild != nil {
                    currentNode = currentNode.rightChild!
                }
                else {
                    return nil
                }
            }
            else if obj.isLessThan(currentNode.object) {
                if currentNode.leftChild != nil {
                    currentNode = currentNode.leftChild!
                }
                else {
                    return nil
                }
            }
            else {
                break
            }
        }
        
        return currentNode
    }

}
