//
//  LinkedList.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 07.11.13.
//  Swiftified by Marco Abundo on 02.06.16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

class EKLinkedList {
    
    var head: EKNode
    var tail: EKNode?
    var current: EKNode?
    var count: Int
    
    init(head value: AnyObject) {
        head = EKNode(value)
        count = 1
    }

    func addToFront(value: AnyObject) {
        let node = EKNode(value)
        
        if self.tail == nil {
            var lastNode: EKNode?
            lastNode = self.head

            for _ in 1..<count {
                lastNode = lastNode!.next!
            }
            self.tail = lastNode
        
        }
        node.next          = self.head
        self.head.previous = node
        self.head          = node
        
        count += 1
    }

    func addToBack(value: AnyObject) {
        let node = EKNode(value)
        
        if self.tail == nil {
            var lastNode = self.head
            for _ in 1 ..< count {
                lastNode = lastNode.next!
            }
            self.tail = lastNode
        }
        node.previous  = self.tail
        self.tail?.next = node
        self.tail      = node
        
        count += 1
    }

    func insertObject(object: AnyObject, atIndex index: UInt) {
        var currentNode  = self.head
        var previousNode: EKNode?
        var nextNode: EKNode?
        
        for i in 1...index {
            currentNode = currentNode.next!
            if i == index - 1 {
                previousNode = currentNode
            }
            else if i == index {
                nextNode = currentNode
            }
        }
        
        let newNode = EKNode(object)
        
        if previousNode == nil {
            self.head = newNode
        }
        else {
            previousNode!.next = newNode
            newNode.previous  = previousNode
            
            nextNode!.previous = newNode
            newNode.next      = nextNode
        }
        count += 1
    }

    func first() -> AnyObject {
        return self.head.value
    }

    func currentValue() -> AnyObject {
        return self.current!.value
    }

    func next() -> AnyObject {
        self.current = self.current!.next
        
        return self.current!.value
    }

    func previous() -> AnyObject {
        self.current = self.current!.previous
        
        return self.current!.value
    }

    func objectAtIndex(index: UInt) -> AnyObject {
        var currentNode = self.head
        
        for _ in 1..<index {
            currentNode = currentNode.next!
        }
        
        return currentNode.value
    }

    // TODO: Fix when there's only 1 node
    func findObject(object: AnyObject) -> [AnyObject] {
        var result = [AnyObject]()
        var currentNode = self.head
        
        while currentNode.next != nil {
            if currentNode.value.isEqualTo(object) {
                result.append(currentNode)
            }
            currentNode = currentNode.next!
        }
        return result
    }

    func removeCurrent() -> Bool {
        // TODO: improve code below
        NSLog("\(self.currentValue())")
        
        var removed = false
        if self.current != nil {
            self.current!.previous!.next = self.current!.next
            removed = true
            count -= 1
        }
        else {
            removed = false
        }
        
        return removed
    }

    func removeObjectAtIndex(index: Int) -> Bool {
        if index < 1 || index > self.count {
            NSLog("You are trying to delete head or index out of list count")
            return false
        }
        
        var current = self.head
        
        for _ in 1..<index {
            if current.next == nil {
                return false
            }
            current = current.next!
        }
        
        current.next = current.next!.next
        count -= 1
        
        return true
    }

    func printList() {
        var node: EKNode?
            
        node = self.head
        
        while node != nil {
            NSLog("Node \(node!.value)")
            
            if let n = node!.next {
                node = n
            }
            else {
                node = nil
            }
        }
    }

    func reverseList() {
        self.current = self.head
        
        var previousNode: EKNode?
        var nextNode: EKNode?
        
        while self.current != nil {
            nextNode          = self.current!.next
            self.current!.next = previousNode
            
            previousNode      = self.current!
            self.current      = nextNode
        }
        
        self.head = previousNode!
    }

}
