//
//  NSArray+EKSorting.m
//  EKAlgorithmsApp
//
//  Created by Stanislaw Pankevich on 31/03/14.
//  Swiftified by Marco Abundo on 27/01/16.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

extension NSArray {
    
    // MARK: Check if array is sorted
    
    func isSorted() -> Bool {
        let countMinusOne = count - 1
        
        for i in 0 ..< countMinusOne {
            if self[i].isGreaterThan(self[i + 1]) {
                return false
            }
        }
        
        return true
    }
    
    func CocoaImplementationOfReversedArray() -> NSArray {
        return self.reverseObjectEnumerator().allObjects
    }
}

extension NSMutableArray {
    
    // MARK: Array reverse

    func reverse() -> NSMutableArray {
        for i in 0 ..< count / 2 {
            self.exchangeObjectAtIndex(i, withObjectAtIndex: (count - 1 - i))
        }
        
        return self
    }
    
    // MARK: Array shuffle
    
    func shuffle() -> NSMutableArray {
        // empty and single-element collections don't shuffle
        if count > 1 {
            var i = count - 1
            
            while i >= 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(count)))
                
                guard i != randomIndex else {
                    continue
                }
                
                self.exchangeObjectAtIndex(randomIndex, withObjectAtIndex: i)
                i -= 1
            }
        }
        
        return self
    }

/*
    // MARK: Bubble sort

    - (NSMutableArray *)naiveBubbleSort
    {
        NSUInteger count = [self count];

        for (int i = 0; i < count; i++) {
            for (int j = 0; j < (count - 1); j++) {
                if ([self[j] compare:self[j + 1]] == NSOrderedDescending) {
                    [self exchangeObjectAtIndex:j withObjectAtIndex:(j + 1)];
                }
            }
        }

        return self;
    }
*/
    func bubbleSort() -> NSMutableArray {
        for (var i = (count - 2); i >= 0; i -= 1) {
            for j in 0...i {
                if self[j].isGreaterThan(self[j + 1]) {
                    self.exchangeObjectAtIndex(j, withObjectAtIndex: (j + 1))
                }
            }
        }
        
        return self
    }

    // MARK: Shell sort

    func shellSort() -> NSMutableArray {
        for (var i = count / 2; i > 0; i = i / 2) {
            for j in i ..< count {
                for (var k = j - i; k >= 0; k = k - i) {
                    if self[k + 1].isGreaterThanOrEqualTo(self[k]) {
                        break
                    }
                    else {
                        self.exchangeObjectAtIndex(k, withObjectAtIndex: (k + i))
                    }
                }
            }
        }

        return self
    }

    // MARK: Merge sort stuff

    func mergeSort() -> NSMutableArray {
        self.partitionArrayWithMinimalIndex(0, withMaximumIndex: (count - 1))
        
        return self
    }

    // MARK: Quick sort

    func quickSortWithLeftIndex(left: NSInteger, withRightIndex right: NSInteger) -> NSMutableArray {
        var i = left
        var j = right
        
        let pivotalElement = self[(left + right) / 2]
        
        repeat {
            while self[i].isLessThan(pivotalElement) && (i < right) {
                i += 1
            }
            while pivotalElement.isLessThan(self[j]) && (j > left) {
                j -= 1
            }
            
            if i <= j {
                self.exchangeObjectAtIndex(i, withObjectAtIndex: j)
                
                i += 1
                j -= 1
            }
        }
        while i <= j
        
        if left < j {
            self.quickSortWithLeftIndex(left, withRightIndex: j)
        }
        
        if (i < right) {
            self.quickSortWithLeftIndex(i, withRightIndex: right)
        }
        
        return self
    }

    // MARK: Insertion sort

    func insertionSort() -> NSMutableArray {
        for i in 1 ..< count {
            for var j = i; (j > 0) && self[j - 1].isGreaterThan(self[j]); j -= 1 {
                self.exchangeObjectAtIndex(j, withObjectAtIndex: (j - 1))
            }
        }

        return self
    }

    // MARK: Selection sort

    func selectionSort() -> NSMutableArray {
        for i in 0 ..< count {
            var min = i

            for j in i + 1 ..< count {
                if self[j].isLessThan(self[min]) {
                    min = j
                }
            }

            self.exchangeObjectAtIndex(i, withObjectAtIndex: min)
        }

        return self
    }

    // MARK: Radix Sort

    func radixSortForBase(base: Int) -> NSMutableArray {
        let max = self.valueForKeyPath("@max.intValue")!.intValue

        let numberOfSteps = Int((log(Double(max)) / log(Double(base))) + 1)

        for i in 0 ..< numberOfSteps {
            let radixTable = NSMutableArray.makeRadixTableForArray(self, forBase: base, forDigit: i)

            setArray(NSMutableArray.makeArrayFromRadixTable(radixTable) as [AnyObject])
        }

        return self
    }

    static func makeArrayFromRadixTable(radixTable: [SSRadixNode]) -> NSMutableArray {
        let theArray = NSMutableArray()
        
        for bucketNode in radixTable {
            var bucket = bucketNode.next
            while (bucket != nil) {
                theArray.addObject(bucket!.data)
                bucket = bucket!.next
            }
        }
        return theArray
    }

    static func makeRadixTableForArray(theArray: NSMutableArray, forBase base: Int, forDigit digit: Int) -> [SSRadixNode] {
        let radixTable = getTableOfEmptyBucketsForSize(base)
        
        for i in 0 ..< theArray.count {
            let value = theArray[i].integerValue
            let radixIndex = getExaminedNumber(value, withBase: base, atDigit: digit)
            var current = radixTable[radixIndex]
            if (current.next != nil) {
                while (current.next != nil) {
                    current = current.next!
                }
            }
            let newEntry = SSRadixNode()
            newEntry.data = theArray[i].integerValue
            current.next = newEntry
        }
        
        return radixTable
    }

    static func getTableOfEmptyBucketsForSize(size: NSInteger) -> [SSRadixNode] {
        var empty: [SSRadixNode] = []
        
        for _ in 0 ..< size {
            empty.append(SSRadixNode())
        }
        
        return empty
    }

    static func getExaminedNumber(number: NSInteger, withBase base: NSInteger, atDigit digit: NSInteger) -> NSInteger {
        let divisor = (digit == 0) ? 1 : pow(Double(base), Double(digit))
        return (number / Int(divisor)) % base
    }
/*
    // MARK: Partial Selection Sort

    - (NSMutableArray *)partialSelectionSort:(NSUInteger)K
    {
        NSUInteger count = self.count;
        NSParameterAssert(K <= count);
        
        NSUInteger minIndex;
        NSUInteger minValue;
        
        for (NSUInteger i = 0; i < K; i++) {
            minIndex = i;
            minValue = [self[i] unsignedIntegerValue];
            
            for (NSUInteger j = i + 1; j < count; j++) {
                NSUInteger el = [self[j] unsignedIntegerValue];
                
                if (el < minValue) {
                    minIndex = j;
                    minValue = el;
                }
            }
            
            [self exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
        }
        
        return self;
    }
*/
    // MARK: Heap sort

    func heapSort() -> NSMutableArray {

        heapifyArrayWithSize(count)

        var end = count - 1

        while end > 0 {
            exchangeObjectAtIndex(end, withObjectAtIndex: 0)
            siftDownArrayWithStart(0, end: end - 1)
            end -= 1
        }
        
        return self
    }

    // MARK: Used in merge sort

    func partitionArrayWithMinimalIndex(min: NSInteger, withMaximumIndex max: NSInteger) {
        var mid = 0
        
        if (min < max) {
            mid = (min + max) / 2;
            self.partitionArrayWithMinimalIndex(min, withMaximumIndex: mid)
            self.partitionArrayWithMinimalIndex(mid + 1, withMaximumIndex: max)
            self.mergeArrayWithMinimalIndex(min, withMediumIndex: mid, withMaximalIndex: max)
        }
    }

    func mergeArrayWithMinimalIndex(min: NSInteger, withMediumIndex mid: NSInteger, withMaximalIndex max: NSInteger) {
        let temporaryArray = NSMutableArray()

        for _ in 0 ..< count {
            temporaryArray.addObject(NSNull)
        }

        var i = 0, j = 0, k = 0, m = 0
        j = min
        m = mid + 1

        for (i = min; j <= mid && m <= max; i += 1) {
            if self[j].isLessThanOrEqualTo(self[m]) {
                temporaryArray[i] = self[j]
                j += 1
            }
            else {
                temporaryArray[i] = self[m]
                m += 1
            }
        }
        if j > mid {
            for k in m...max {
                temporaryArray[i] = self[k]
                i += 1
            }
        }
        else {
            for k in j...mid {
                temporaryArray[i] = self[k]
                i += 1
            }
        }
        
        for k in min...max {
            self[k] = temporaryArray[k]
        }
    }

    // MARK: Used in heap sort

    func siftDownArrayWithStart(startIndex: Int, end endIndex: Int) {
        var root = startIndex

        while (root * 2 + 1) <= endIndex {
            var child = root * 2 + 1

            if child + 1 <= endIndex && self[child].isLessThan(self[child + 1]) {
                child += 1
            }

            if self[root].isLessThan(self[child]) {
                exchangeObjectAtIndex(root, withObjectAtIndex: child)
                root = child
            }
            else {
                return
            }
        }
    }

    func heapifyArrayWithSize(size: Int) {
        var start = (size - 2) / 2
        
        while start >= 0 {
            siftDownArrayWithStart(start, end: size - 1)
            start -= 1
        }
    }
}
