//
//  Array+EKStuff.swift
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Swiftified by Marco Abundo on 24/11/16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

import Foundation

extension Array where Element : Comparable {

    // MARK: ARRAY STUFF
    // MARK: Max element in array

    func indexOfMaximumElement() -> UInt? {
        
        var indexOfMaximumValue: UInt?
        
        if count > 0 {
            var maximumValue = first!
            
            indexOfMaximumValue = 0
            
            for (index, value) in enumerate() {
                
                if UInt(index) == indexOfMaximumValue {
                    continue
                }
                else if value > maximumValue {
                    maximumValue = value
                    indexOfMaximumValue = UInt(index)
                }
            }
        }
        
        return indexOfMaximumValue
    }
}

extension CollectionType where Generator.Element == Int {
    func last(count:Int) -> [Self.Generator.Element] {
        let selfCount = count

        if selfCount <= count - 1 {
            return Array(self)
        }
        else {
            return Array(reverse()[0...count - 1].reverse())
        }
    }

    func indexesOfMinimumAndMaximumElements() -> (indexOfMin: UInt, indexOfMax: UInt)? {
        if count == 0 {
            return nil
        }
        
        var minimalValue = Int.max
        var maximalValue = Int.min
        
        var minimalValueIndex = 0
        var maximalValueIndex = 0
        
        // Machine way of doing odd/even check is better than mathematical count % 2
        let oddnessFlag = count & 1
        
        if oddnessFlag == 1 {
            maximalValue = last(1).first!
            minimalValue = maximalValue
            
            maximalValueIndex = count.toIntMax() - 1
            minimalValueIndex = maximalValueIndex
        }
        
        var idx = 0
        
        var iValue: Int?
        var ip1Value: Int?
        
        for element in self {
            if (idx++ & 1) == 0 {
                iValue = element
                
                continue;
            }
            else {
                ip1Value = element
            }
            
            let iidx = idx - 2
            let ip1idx = idx - 1
            
            if iValue < ip1Value {
                if minimalValue > iValue {
                    minimalValue      = iValue!
                    minimalValueIndex = iidx
                }
                
                if maximalValue < ip1Value {
                    maximalValue      = ip1Value!
                    maximalValueIndex = ip1idx
                }
            }
            else if iValue > ip1Value {
                if minimalValue > ip1Value {
                    minimalValue      = ip1Value!
                    minimalValueIndex = ip1idx
                }
                
                if maximalValue < iValue {
                    maximalValue      = iValue!
                    maximalValueIndex = iidx
                }
            }
            else {
                if minimalValue > iValue {
                    minimalValue      = iValue!
                    minimalValueIndex = iidx
                }
                
                if maximalValue < iValue {
                    maximalValue      = iValue!
                    maximalValueIndex = iidx
                }
            }
        }
        
        return (indexOfMin: UInt(minimalValueIndex), indexOfMax: UInt(maximalValueIndex))
    }
    
    // MARK: Sum of elements
    
    func sumOfElements() -> Int {
        var sum = 0
    
        for element in self {
            sum = sum + element
        }
        
        return sum
    }
}

extension CollectionType where Generator.Element == String {
    
    // MARK: Longest string in array
    
    func longestString() -> String? {
        var returnValue: String?
        
        for string in self {
            if (returnValue == nil || (string.characters.count > returnValue?.characters.count)) {
                returnValue = string
            }
        }
        
        return returnValue
    }

    // MARK: Shortest string in array

    func shortestString() -> String? {
        var returnValue: String?
        
        for string in self {
            if (returnValue == nil || (string.characters.count < returnValue?.characters.count)) {
                returnValue = string
            }
        }
        
        return returnValue
    }

/*
// MARK: SEARCH STUFF
// MARK: Linear search

- (NSInteger)indexOfObjectViaLinearSearch:(id)object
{
    NSUInteger count = [self count];

    for (NSUInteger i = 0; i < count; i++) {
        if ([object isEqual:self[i]]) {
            return i;
        }
    }

    return NSNotFound;
}

// MARK: Binary search

- (NSInteger)indexOfObjectViaBinarySearch:(id)object
{
    NSUInteger firstIndex = 0;
    NSUInteger uptoIndex  = [self count];

    while (firstIndex < uptoIndex) {
        NSUInteger mid = (firstIndex + uptoIndex) / 2;

        if ([object compare:self[mid]] == NSOrderedAscending) {
            uptoIndex = mid;
        }
        else if ([object compare:self[mid]] == NSOrderedDescending) {
            firstIndex = mid + 1;
        }
        else {
            return mid;
        }
    }
    
    return NSNotFound;
}
*/
}
