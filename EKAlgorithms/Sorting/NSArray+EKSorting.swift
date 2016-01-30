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
            for (var j = 0; j <= i; j += 1) {
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
/*
    // MARK: Radix Sort

    - (NSMutableArray *)radixSortForBase:(NSInteger)base
    {
        int max = [[self valueForKeyPath:@"@max.intValue"] intValue];

        int numberOfSteps = (log(max) / log(base)) + 1;

        for (int i = 0; i < numberOfSteps; i++) {
            NSMutableArray *radixTable = [NSMutableArray makeRadixTableForArray:self forBase:base forDigit:i];

            [self setArray:[NSMutableArray makeArrayFromRadixTable:radixTable]];
        }

        return self;
    }

    + (NSMutableArray *)makeArrayFromRadixTable:(NSMutableArray *)radixTable
    {
        NSMutableArray *theArray = [NSMutableArray new];
        
        for (SSRadixNode *bucketNode in radixTable) {
            SSRadixNode *bucket = bucketNode.next;
            while (bucket) {
                [theArray addObject:@(bucket.data)];
                bucket = bucket.next;
            }
        }
        return theArray;
    }

    + (NSMutableArray *)makeRadixTableForArray:(NSMutableArray *)theArray forBase:(NSInteger)base forDigit:(NSInteger)digit
    {
        NSMutableArray *radixTable = [self getTableOfEmptyBucketsForSize:base];
        
        for (int i = 0; i < theArray.count; i++) {
            NSInteger value = [theArray[i] integerValue];
            NSInteger radixIndex = [self getExaminedNumber:value withBase:base atDigit:digit];
            SSRadixNode *current = (SSRadixNode *)radixTable[radixIndex];
            if (current.next) {
                while (current.next) {
                    current = [current next];
                }
            }
            SSRadixNode *newEntry = [SSRadixNode new];
            newEntry.data = [theArray[i] intValue];
            current.next = newEntry;
        }
        
        return radixTable;
    }

    + (NSMutableArray *)getTableOfEmptyBucketsForSize:(NSInteger)size
    {
        NSMutableArray *empty = [NSMutableArray new];
        
        for (NSInteger i = 0; i < size; i++) {
            [empty addObject:[SSRadixNode new]];
        }
        
        return empty;
    }

    + (NSInteger)getExaminedNumber:(NSInteger)number withBase:(NSInteger)base atDigit:(NSInteger)digit
    {
        NSInteger divisor = (digit == 0) ? 1 : (pow(base, digit));
        return (number / divisor) % base;
    }

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

    // MARK: Heap sort

    - (NSMutableArray *)heapSort
    {
        NSUInteger count = self.count;

        [self heapifyArrayWithSize:count];

        NSInteger end = count - 1;

        while (end > 0) {
            [self exchangeObjectAtIndex:end withObjectAtIndex:0];
            [self siftDownArrayWithStart:0 end:end - 1];
            end--;
        }
        
        return self;
    }

    @end


*/

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

        for i in 0 ..< count {
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
            for (k = m; k <= max; k += 1) {
                temporaryArray[i] = self[k]
                i += 1
            }
        }
        else {
            for (k = j; k <= mid; k += 1) {
                temporaryArray[i] = self[k]
                i += 1
            }
        }
        
        for (k = min; k <= max; k += 1) {
            self[k] = temporaryArray[k]
        }
    }
/*
    // MARK: Used in heap sort

    - (void)siftDownArrayWithStart:(NSInteger)startIndex end:(NSInteger)endIndex
    {
        NSInteger root = startIndex;

        while ((root * 2 + 1) <= endIndex) {
            NSInteger child = root * 2 + 1;

            if (child + 1 <= endIndex && [self[child] floatValue] < [self[child + 1] floatValue]) {
                child++;
            }

            if ([self[root] floatValue] < [self[child] floatValue]) {
                [self exchangeObjectAtIndex:root withObjectAtIndex:child];
                root = child;
            }
            else {
                return;
            }
        }
    }

    - (void)heapifyArrayWithSize:(NSInteger)size
    {
        NSInteger start = (size - 2) / 2;
        
        while (start >= 0) {
            [self siftDownArrayWithStart:start end:size - 1];
            start--;
        }
    }
*/
}
