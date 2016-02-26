//
//  EKAVLTree.m
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/29/14.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

class EKAVLTree: NSObject {
    
    var root: EKAVLTreeNode

    init(object: NSObject) {
        self.root = EKAVLTreeNode(object: object)
    }

    func insertObject(object: NSObject) {
        self.insertObject(object, atNode: self.root)
    }

    func insertObject(object: NSObject, var atNode T: EKAVLTreeNode?) -> EKAVLTreeNode {
        if T == nil {
            T = EKAVLTreeNode(object: object)
        }
        else {
            if object.isLessThan(T!.object) {
                T!.leftChild = self.insertObject(object, atNode: T!.leftChild)
                
                if EKAVLTree.heightOfNode(T!.leftChild) - EKAVLTree.heightOfNode(T!.rightChild) == 2 {
                    if object.isGreaterThan(T!.leftChild!.object) {
                        T = EKAVLTree.singleRotateWithLeft(T!)
                    }
                    else {
                        T = EKAVLTree.doubleRotateWithLeft(T!)
                    }
                }
            }
            else if object.isGreaterThan(T!.object) {
                T!.rightChild = self.insertObject(object, atNode: T!.rightChild)
                if EKAVLTree.heightOfNode(T!.rightChild) - EKAVLTree.heightOfNode(T!.leftChild) == 2 {
                    if object.isGreaterThan(T!.rightChild!.object) {
                        T = EKAVLTree.singleRotateWithRight(T!)
                    }
                    else {
                        T = EKAVLTree.doubleRotateWithRight(T!)
                    }
                }
            }
            T!.height = max(EKAVLTree.heightOfNode(T!.leftChild), EKAVLTree.heightOfNode(T!.rightChild))+1
        }
        return T!
    }

    func printDescription() {
        self.root.printDescription()
    }

    func find(object: NSObject) -> EKAVLTreeNode? {
        var currentNode = self.root
        while (true) {
            if object.isGreaterThan(currentNode.object) {
                if currentNode.rightChild != nil {
                    currentNode = currentNode.rightChild!
                }
                else {
                    return nil
                }
            }
            else if object.isLessThan(currentNode.object) {
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

    func deleteObject(object: NSObject) {
        self.deleteObject(object, atNode: self.root)
    }

    func deleteObject(object: NSObject, var atNode T: EKAVLTreeNode?) -> EKAVLTreeNode? {
        if T == nil {
            return nil
        }

        if object.isEqualTo(T!.object) {
            if T!.rightChild == nil {
                //var temp = T
                T = T!.leftChild
                //temp = nil
            }
            else {
                var temp = T!.rightChild
                while temp!.leftChild != nil {
                    temp = temp!.leftChild
                }
                
                T!.object = temp!.object.copy() as! NSObject
                T!.rightChild = self.deleteObject(temp!.object, atNode: T!.rightChild)
                T!.height = max(EKAVLTree.heightOfNode(T!.leftChild), EKAVLTree.heightOfNode(T!.rightChild))+1
            }
            return T
        }
        else if object.isLessThan(T!.object) {
            T!.leftChild = self.deleteObject(object, atNode: T!.leftChild)
        }
        else {
            T!.rightChild = self.deleteObject(object, atNode: T!.rightChild)
        }
        
        T!.height = max(EKAVLTree.heightOfNode(T!.leftChild), EKAVLTree.heightOfNode(T!.rightChild))+1
        
        if T!.leftChild != nil {
            T!.leftChild = EKAVLTree.rotateSingleNode(T!.leftChild!)
        }
        
        if T!.rightChild != nil {
            T!.rightChild = EKAVLTree.rotateSingleNode(T!.rightChild!)
        }
        
        T = EKAVLTree.rotateSingleNode(T!)
        return T
    }

    class func heightOfNode(node: EKAVLTreeNode?) -> Int
    {
        if node == nil {
            return -1
        }
        else {
           return node!.height
        }
    }

    // MARK: AVL Rotation

    class func singleRotateWithLeft(K2: EKAVLTreeNode) -> EKAVLTreeNode {
        let K1 = K2.leftChild
        K2.leftChild  = K1!.rightChild
        K1!.rightChild = K2
        
        K2.height = max(EKAVLTree.heightOfNode(K2.leftChild), EKAVLTree.heightOfNode(K2.rightChild))+1
        K1!.height = max(EKAVLTree.heightOfNode(K1!.leftChild), EKAVLTree.heightOfNode(K1!.rightChild))+1
        
        return K1!
    }

    class func singleRotateWithRight(K2: EKAVLTreeNode) -> EKAVLTreeNode {
        let K1 = K2.rightChild
        K2.rightChild = K1!.leftChild
        K1!.leftChild  = K2
        
        K2.height = max(EKAVLTree.heightOfNode(K2.leftChild), EKAVLTree.heightOfNode(K2.rightChild))+1
        K1!.height = max(EKAVLTree.heightOfNode(K1!.leftChild), EKAVLTree.heightOfNode(K1!.rightChild))+1
        
        return K1!
    }

    class func doubleRotateWithLeft(K3: EKAVLTreeNode) -> EKAVLTreeNode {
        K3.leftChild = EKAVLTree.singleRotateWithRight(K3.leftChild!)
        return EKAVLTree.singleRotateWithLeft(K3)
    }

    class func doubleRotateWithRight(K3: EKAVLTreeNode) -> EKAVLTreeNode {
        K3.rightChild = EKAVLTree.singleRotateWithLeft(K3.rightChild!)
        return EKAVLTree.singleRotateWithRight(K3)
    }

    class func rotateSingleNode(var T: EKAVLTreeNode) -> EKAVLTreeNode {
        if EKAVLTree.heightOfNode(T.leftChild) - EKAVLTree.heightOfNode(T.rightChild) == 2 {
            if EKAVLTree.heightOfNode(T.leftChild!.leftChild) >= EKAVLTree.heightOfNode(T.leftChild!.rightChild) {
                T = EKAVLTree.singleRotateWithLeft(T)
            }
            else {
                T = EKAVLTree.doubleRotateWithLeft(T)
            }
        }
        
        if EKAVLTree.heightOfNode(T.rightChild) - EKAVLTree.heightOfNode(T.leftChild) == 2 {
            if EKAVLTree.heightOfNode(T.rightChild!.rightChild) >= EKAVLTree.heightOfNode(T.rightChild!.leftChild) {
                T = EKAVLTree.singleRotateWithRight(T)
            }
            else {
                T = EKAVLTree.doubleRotateWithRight(T)
            }
        }
        return T
    }

}
