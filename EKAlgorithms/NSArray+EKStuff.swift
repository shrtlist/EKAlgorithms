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
            
            for (var i = 0; i < index; i++) {
                if mutableArray[i].valueForKey(currentKey as String) as! String == object.valueForKey(currentKey as String) as! String {
                    mutableArray.removeObjectAtIndex(index)
                    break
                }
            }
            index--
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
/*
// MARK: Sum of elements

- (NSNumber *)sumOfElements
{
    NSUInteger count = [self count];

    long long int sum = 0;
    
    for (NSUInteger i = 0; i < count; i++) {
        sum = sum + [self[i] longLongValue];
    }
    
    return @(sum);
}

// MARK: Occurrences of each element in array

- (NSDictionary *)occurencesOfEachElementInArray_naive
{
    NSUInteger count = [self count];
    NSMutableDictionary *registry = [NSMutableDictionary dictionaryWithCapacity:count];
    
    for (NSUInteger i = 0; i < count; i++) {
        NSUInteger counter = 0;
        
        for (NSUInteger j = 0; j < count; j++) {
            if ([self[i] isEqual:self[j]]) {
                counter++;
            }
        }
        
        registry[self[i]] = @(counter);
    }
    
    return registry;
}

- (NSDictionary *)occurencesOfEachElementInArray
{
    NSUInteger count              = [self count];
    NSMutableDictionary *registry = [NSMutableDictionary dictionaryWithCapacity:count];
    
    for (NSUInteger i = 0; i < count; i++) {
        
        id currentElement                = self[i];
        NSNumber *existingElementCounter = registry[currentElement];
        NSUInteger currentCount          = existingElementCounter ? existingElementCounter.unsignedIntegerValue : 0;
        
        currentCount++;
        
        registry[currentElement] = @(currentCount);
    }
    
    return registry;
}

- (NSDictionary *)CocoaImplementationOfOccurencesOfEachElementInArray
{
    NSCountedSet *countedSet        = [[NSCountedSet alloc] initWithArray:self];
    NSMutableDictionary *dictionary = [@{} mutableCopy];
    
    NSArray* setAllObjects = [countedSet allObjects];
    
    for (id object in setAllObjects) {
        dictionary[object] = @([countedSet countForObject:object]);
    }
    
    return dictionary;
}

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
