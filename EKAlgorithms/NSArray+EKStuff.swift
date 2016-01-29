//
//  NSArray+EKStuff.swift
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Swiftified by Marco Abundo on 24/11/16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

import Foundation

extension NSArray {
    
    // MARK: ARRAY STUFF
    // MARK: Max element in array
    
    func indexOfMaximumElement() -> UInt {
        var maximumValue = firstObject
        
        var indexOfMaximumValue: UInt = 0
        
        for i in 1 ..< count {
            let value = self[i]
        
            if value.isGreaterThan(maximumValue) {
                maximumValue        = value
                indexOfMaximumValue = UInt(i)
            }
        }
    
        return indexOfMaximumValue
    }
    
    func indexesOfMinimumAndMaximumElements() -> (indexOfMin: UInt, indexOfMax: UInt)? {
        if count == 0 {
            return nil
        }
    
        var minimalValue = NSNumber(integer: Int.max)
        var maximalValue = NSNumber(integer: Int.min)
        
        var minimalValueIndex: UInt = 0
        var maximalValueIndex: UInt = 0
        
        // Machine way of doing odd/even check is better than mathematical count % 2
        let oddnessFlag = count & 1
        
        if oddnessFlag == 1 {
            maximalValue = lastObject as! NSNumber
            minimalValue = maximalValue
            
            maximalValueIndex = UInt(count.toIntMax() - 1)
            minimalValueIndex = maximalValueIndex
        }
        
        var idx: UInt = 0
        
        var iValue: NSNumber!
        var ip1Value: NSNumber!
        
        for element in self {
            if (idx++ & 1) == 0 {
                iValue = element as! NSNumber
                
                continue
            }
            else {
                ip1Value = element as! NSNumber
            }
            
            let iidx = idx - 2
            let ip1idx = idx - 1
        
            if iValue.isLessThan(ip1Value) {
                if minimalValue.isGreaterThan(iValue) {
                    minimalValue      = iValue
                    minimalValueIndex = iidx
                }
                
                if maximalValue.isLessThan(ip1Value) {
                    maximalValue      = ip1Value
                    maximalValueIndex = ip1idx
                }
            }
            else if iValue.isGreaterThan(ip1Value) {
                if minimalValue.isGreaterThan(ip1Value) {
                    minimalValue      = ip1Value
                    minimalValueIndex = ip1idx
                }
            
                if maximalValue.isLessThan(iValue) {
                    maximalValue      = iValue
                    maximalValueIndex = iidx
                }
            }
            else {
                if minimalValue.isGreaterThan(iValue) {
                    minimalValue      = iValue
                    minimalValueIndex = iidx
                }
            
                if maximalValue.isLessThan(iValue) {
                    maximalValue      = iValue
                    maximalValueIndex = iidx
                }
            }
        }
    
        return (indexOfMin: minimalValueIndex, indexOfMax: maximalValueIndex)
    }
    
    // MARK: Longest string in array
    
    func longestString() -> NSString? {
        var returnValue: NSString?
        
        for string in self as! [NSString] {
            if returnValue == nil || string.length > returnValue!.length {
                returnValue = string
            }
        }
        
        return returnValue
    }
    
    // MARK: Shortest string in array
    
    func shortestString() -> NSString? {
        var returnValue: NSString?
        
        for string in self as! [NSString] {
            if returnValue == nil || string.length < returnValue!.length {
                returnValue = string
            }
        }
        
        return returnValue
    }

    // MARK: Intersection of two arrays

    func intersectionWithArray(secondArray: NSArray) -> NSArray {
        let intersection = NSMutableSet(array: self as [AnyObject])
        intersection.intersectSet(NSSet(array: secondArray as [AnyObject]) as Set<NSObject>)

        return intersection.allObjects
    }

    // MARK: Union of two arrays

    func unionWithoutDuplicatesWithArray(secondArray: NSArray) -> NSArray {
        let firstSet  = NSSet(array: self as [AnyObject])
        let secondSet = NSSet(array: secondArray as [AnyObject])
        
        let resultSet = NSMutableSet(set: firstSet)
        resultSet.unionSet(secondSet as Set<NSObject>)
        
        return resultSet.allObjects
    }

    func unionWithoutDuplicatesWithArray(secondArray: NSArray, forKey currentKey: NSString) -> NSArray {
        let mutableArray = NSMutableArray(array: self)
        mutableArray.addObjectsFromArray(secondArray as [AnyObject])
        
        let copy = mutableArray.copy()
        var index = copy.count - 1

        for object in copy.reverseObjectEnumerator() {
            
            for i in 0 ..< index {
                if mutableArray[i].valueForKey(currentKey as String) as! String == object.valueForKey(currentKey as String) as! String {
                    mutableArray.removeObjectAtIndex(index)
                    break
                }
            }
            index -= 1
        }
        
        return mutableArray
    }

    // MARK: Find duplicates

    func hasDuplicates() -> Bool {
        let registry = NSMutableDictionary(capacity: count)

        for element in self {
            let elementHash = element.hash
            
            if let registryElement = registry[elementHash] {
                NSLog("-[NSArray hasDuplicates] found duplicate elements: \(registryElement) and \(element)")
                
                return true
            }
            else {
                registry[elementHash] = element
            }
        }
        
        return false
    }

    // MARK: Array with random NSNumber objects

    static func randomObjectsWithArraySize(arraySize: UInt, maxRandomValue maxValue: UInt, uniqueObjects unique: Bool) -> NSArray {
        assert(maxValue >= arraySize, "Max random value should not be less than array size")
        
        let objects = NSMutableArray()
        var randomObject: UInt = 0
        
        while UInt(objects.count) < arraySize {
            randomObject = UInt(arc4random()) % maxValue
            if unique && !objects.containsObject(randomObject) {
                objects.addObject(randomObject)
            }
            
            if (!unique) {
                objects.addObject(randomObject)
            }
        }
        
        return objects.copy() as! NSArray
    }
    
    // MARK: Sum of elements
    
    func sumOfElements() -> Int {
        var sum = 0
        
        for element in self {
            sum = sum + element.integerValue
        }
        
        return sum
    }

    // MARK: Occurrences of each element in array

    func occurencesOfEachElementInArray_naive() -> NSDictionary {
        let registry = NSMutableDictionary(capacity: count)
        
        for i in 0 ..< count {
            var counter = 0
            
            for j in 0 ..< count {
                if self[i].isEqual(self[j]) {
                    counter += 1
                }
            }
            
            registry[self[i] as! NSCopying] = counter
        }
        
        return registry
    }

    func occurencesOfEachElementInArray() -> NSDictionary {
        let registry = NSMutableDictionary(capacity: count)
        
        for currentElement in self {
            var currentCount: UInt = 0
            if let existingElementCounter = registry[currentElement as! NSCopying] {
                currentCount = existingElementCounter.unsignedIntegerValue
            }

            currentCount += 1

            registry[currentElement as! NSCopying] = currentCount
        }
        
        return registry
    }

    func cocoaImplementationOfOccurencesOfEachElementInArray() -> NSDictionary {
        let countedSet = NSCountedSet(array: self as [AnyObject])
        let dictionary = NSMutableDictionary()
        
        let setAllObjects = countedSet.allObjects
        
        for object in setAllObjects {
            dictionary[object as! NSCopying] = countedSet.countForObject(object)
        }
        
        return dictionary
    }

    // MARK: SEARCH STUFF
    // MARK: Linear search

    func indexOfObjectViaLinearSearch(object: AnyObject) -> Int {
        for i in 0 ..< count {
            if object.isEqual(self[i]) {
                return i
            }
        }

        return NSNotFound;
    }

    // MARK: Binary search

    func indexOfObjectViaBinarySearch(object: AnyObject) -> NSInteger {
        var firstIndex = 0
        var uptoIndex  = count

        while firstIndex < uptoIndex {
            let mid = (firstIndex + uptoIndex) / 2

            if object.isLessThan(self[mid]) {
                uptoIndex = mid
            }
            else if object.isGreaterThan(self[mid]) {
                firstIndex = mid + 1
            }
            else {
                return mid
            }
        }
        
        return NSNotFound
    }
}
