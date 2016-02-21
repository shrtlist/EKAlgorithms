//
//  EKBSTree.swift
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 14.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

class EKBSTree: NSObject {

    var root: EKBTreeNode
    
    init(obj: AnyObject, compareSelector selector: String) {
        self.root = EKBTreeNode()
        self.root.object          = obj;
        self.root.compareSelector = selector
        
        super.init()
    }

    func insertObject(newObj: AnyObject) {
        let treeNode    = EKBTreeNode()
        treeNode.object          = newObj
        treeNode.compareSelector = self.root.compareSelector
        
        var currentNode = self.root
        var parentNode  = self.root
        
        while true {
            let result = (NSComparisonResult)[newObj performSelector : currentNode.compareSelector withObject : currentNode.object];
            if (result >= 0) {
                if (!currentNode.rightChild) {
                    currentNode.rightChild = treeNode;
                    treeNode.parent        = parentNode;
                    break;
                }
                else {
                    currentNode = currentNode.rightChild;
                    parentNode = currentNode;
                }
            }
            else {
                if (!currentNode.leftChild) {
                    currentNode.leftChild = treeNode;
                    treeNode.parent       = parentNode;
                    break;
                }
                else {
                    currentNode = currentNode.leftChild;
                    parentNode  = currentNode;
                }
            }
        }
    }

    - (void)printDescription
    {
        [self.root printDescription];
    }

    - (EKBTreeNode *)deleteObject:(NSObject *)obj
    {
        EKBTreeNode *node = [self find:obj];
        
        if (node) {
            if (node.leftChild && node.rightChild) {
                    // Use in-order successor node
                EKBTreeNode *tmpCell = node.rightChild;
                while (tmpCell.leftChild) {
                    tmpCell = tmpCell.leftChild;
                }
                /*
                 // If you would like to use in-order predecessor node, uncomment this and comment code above
                 EKBTreeNode *tmpCell = node.leftChild;
                 while (tmpCell.rightChild) {
                 tmpCell = tmpCell.rightChild;
                 }
                 */
                NSObject *temp;
                temp            = [node.object copy];
                node.object     = [tmpCell.object copy];
                tmpCell.object  = temp;
                node.rightChild = [self deleteObject:temp];
            }
            else {
                if (node.leftChild != nil) {
                    node = node.leftChild;
                }
                else if (node.rightChild != nil) {
                    node = node.rightChild;
                }
                if ([node isLeftChildOfParent]) {
                    node.parent.leftChild = nil;
                }
                else {
                    node.parent.rightChild = nil;
                }
            }
        }
        
        return node;
    }

    - (EKBTreeNode *)find:(NSObject *)obj
    {
        EKBTreeNode *currentNode = self.root;
        
        while (YES) {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            NSComparisonResult result = (NSComparisonResult)[obj performSelector : currentNode.compareSelector withObject : currentNode.object];
    #pragma clang diagnostic pop
            if (result > 0) {
                if (currentNode.rightChild) {
                    currentNode = currentNode.rightChild;
                }
                else
                    return nil;
            }
            else if (result < 0) {
                if (currentNode.leftChild) {
                    currentNode = currentNode.leftChild;
                }
                else
                    return nil;
            }
            else {
                break;
            }
        }
        
        return currentNode;
    }

}
