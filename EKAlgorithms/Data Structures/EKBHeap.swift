//
//  EKBHeap.swift
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/30/14.
//  Swiftified by Marco Abundo on 02/03/16.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

class EKBHeap: NSObject {

    private var heap = [NSNumber]()

    override init() {
        heap.insert(-1, atIndex: 0)
        super.init()
    }

    func insertNumber(num: NSNumber) {
        heap.append(num)
        
        for var i = heap.count - 1; num.isLessThan(heap[i / 2]); i /= 2 {
            swap(&heap[i], &heap[i / 2])
        }
    }

    func deleteMin() -> AnyObject? {
        var child = 0, i = 0
        if isEmpty() {
            assert(heap.count > 1, "Binary heap is empty")
            return nil
        }
        else {
            let minNum  = heap[1]
            let lastNum = heap.last
            
            for i = 1; i * 2 <= heap.count - 1; i = child {
                child = i * 2
                
                if child != heap.count - 1 && heap[child + 1].isLessThan(heap[child]) {
                    child += 1
                }
                
                if lastNum!.isGreaterThan(heap[child]) {
                    swap(&heap[i], &heap[child])
                }
                else {
                    break
                }
            }
            heap[i] = lastNum!
            heap.removeLast()
            
            return minNum
        }
    }

    func isEmpty() -> Bool {
        return heap.count <= 1
    }
}
