//
//  main.swift
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 11.08.13.
//  Swiftified by Marco Abundo on 27.01.16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

// MARK: Array
        
// Init array with 5 random elements
var array = NSMutableArray()
for _ in 0 ..< 5 {
    array.addObject(Int(arc4random()) % 20)
}

// Max element of array
NSLog("Max element of created array \(array.debugDescription) equals \(array[Int(array.indexOfMaximumElement())]) and stored at index \(array.indexOfMaximumElement())")

// Get the Max and Min Simultaneously.
if let indexes = array.indexesOfMinimumAndMaximumElements() {
    NSLog("Min and max elements of created array \(array.debugDescription) equal to \(array[Int(indexes.indexOfMin)]) and \(array[Int(indexes.indexOfMax)]) and stored at indexes: \(indexes.indexOfMin), \(indexes.indexOfMax)")
}

// Longest string from array
if let longestString = ["Kiev", "Moscow", "Tokyo", "Saint-Petersburg", "SanFrancisco"].longestString() {
    NSLog("The longest string is \(longestString)")
}

// Shortest string from array
if let shortestString = ["DRY", "KISS", "YAGNI", "SOLID", "GRASP"].shortestString() {
    NSLog("The shortest string is \(shortestString)")
}

// Reverse of array
NSLog("Reversed array is %@", ["one", "two", "three", "four", "five"].reverse())

// Intersection of two arrays
NSLog("Intersection is %@", ["one", "two", "three"].intersectionWithArray(["two", "three", "four"]))

// Union of two arrays
NSLog("Union is %@", ["Honda", "Toyota"].unionWithoutDuplicatesWithArray(["Toyota", "Alfa Romeo"]))

// Union of two arrays for key
let someKey = "someKey"
let oneArray = NSMutableArray(capacity: 100)
let twoArray = NSMutableArray(capacity: 100)
for i in 0 ..< 100 {
    let currentDic = NSMutableDictionary()
    currentDic.setValue("EKAlgorithms\(i)", forKeyPath: someKey)
    oneArray.addObject(currentDic)
    twoArray.addObject(currentDic)
}
oneArray.addObject([someKey: "EKAlgorithms100"])
NSLog("Union some key is %@", oneArray.unionWithoutDuplicatesWithArray(twoArray, forKey:someKey))

// Find duplicates
NSLog("Result of finding duplicates is %@", ["foo", "bar", "buzz", "foo"].hasDuplicates() ? "YES" : "NO")

// Random object
NSLog("Random array %@", NSArray.randomObjectsWithArraySize(5, maxRandomValue: 6, uniqueObjects: true))

// Is sorted check
NSLog("Given array sorted? --> %@", [1.1, 1.5, 1.9, 2.5, 3, 4, 4].isSorted() ? "YES" : "NO")

// Array Shuffle (Fisherâ€“Yates)
NSLog("Array Shuffle of array: \(array) is: \(array.shuffle())")

// Sum of elements in array
NSLog("Sum is --> \([-5, -5, -5, -5, -5].sumOfElements())")

// Find occurrences of each element in array
NSLog("Occurrences is --> %@", [3, 3, 4, 5, 4, 1, 3, 8, 1].occurencesOfEachElementInArray_naive())
NSLog("Occurrences by using dictionary is --> %@", [NSArray(), NSDictionary(), "four", "five", "four", "one", "three", "eight", "one", "four"].occurencesOfEachElementInArray())
NSLog("Occurrences is --> %@", [3, 3, 4, 5, 4, 1, 3, 8, 1].occurencesOfEachElementInArray())
NSLog("Occurrences via Cocoa APIs is --> %@", [3, 3, 4, 5, 4, 1, 3, 8, 1].cocoaImplementationOfOccurencesOfEachElementInArray())

// MARK: Search
// SEARCH------------------------------------------------------------------------------------

// Linear search
NSLog("Linear search result: \([6, 9, 12, 13, 14, 29, 42].indexOfObjectViaLinearSearch(42))")

// Binary search
NSLog("Binary search result: \([6, 9, 12, 13, 14, 29, 42].indexOfObjectViaBinarySearch(42))")

// MARK: Search
// SORTING-----------------------------------------------------------------------------------

// Bubble sort
array.bubbleSort()
NSLog("Bubble sorted array \(array)")

// Shell sort
array = NSMutableArray(array: [2, 45, 8, 1, 27, 16, 5.3, -53.7])
array.shellSort()
NSLog("Shell sorted array \(array)")

// Merge sort
array = NSMutableArray(array: [21, 45, 87, 10, 273, 616, 0.2, -0.52])
array.mergeSort()
NSLog("Merge sorted array \(array)")

// Quick sort numbers
array = NSMutableArray(array: [2.1, 405, 817, 10, 2732, 616, 0.2, -0.52])
array.quickSortWithLeftIndex(0, withRightIndex: NSMutableArray(array: [21, 45, 87, 10, 273, 616, 0.2, -0.52]).count - 1)
NSLog("Quick sorted array \(array)")

// Insertion sort
array = NSMutableArray(array: [-23.0154, 46, 0.021, 42, 5, false, true])
array.insertionSort()
NSLog("Insertion sorted array \(array)")

// Selection sort
array = NSMutableArray(array: [160, 0.097, false, 89,  -61.001256, 7.5, true])
array.selectionSort()
NSLog("Selection sorted array \(array)")

// Radix sort
array = NSMutableArray(array: [160, 210, 997, 1222, 1334, 3411, 1])
array.radixSortForBase(10)
NSLog("Radix sorted array (BASE 10) \(array)")

// Heap sort
array = NSMutableArray(array: [9871523, 0.0987516, false, 89, -61.001256, 712.5, true, 384756])
array.heapSort()
NSLog("Heap sorted array \(array)")

// MARK: Strings
// STRINGS-----------------------------------------------------------------------------------

// Palindrome string
NSLog("Palindrome? Answer:%@", "Was it a car or a cat I saw".isPalindrome() ? "YES" : "NO")

NSLog("Palindrome? Answer:%@", "wasitacaroracatisaw".isPalindrome() ? "YES" : "NO")

// Reverse
NSLog("Reverse is: %@", "Lorem ipsum dolor".reversedString())

// Count words
NSLog("Words # %d", "fgf fgfdgfdg dfgfdgfd dfgfdgfd dfg".numberOfWordsInString())

// Permutations
NSString.allPermutationsOfString("ABC", withFirstCharacterPosition: 0, lastCharacterPosition: 2)

// Count each letter occurrence in string
"Hello World".countEachCharacterOccurrenceInString()

// Needle in haystack
NSLog("Needle %d", "Foo is a bar with foo bar foo".numberOfOccurrencesOfString("foo"))

// Random string
NSLog("Random string %@", NSString.randomStringWithLength(100))

// Concat
NSLog("Concat string is --> %@", "Hello".concatenateWithString("World!"))

// First occurance of needle in a haystack
NSLog("Index is --> %d", "Lorem ipsum dolor sit amet lorem ipsum".indexOfFirstOccurrenceOfNeedle("em"))

// Last occurance of needle in a haystack
NSLog("Index is --> %d", "Lorem ipsum dolor sit amet lorem ipsum".indexOfLastOccurrenceOfNeedle("or"))

// Longest common sequence
NSLog("Longest common sequence of abcdbceea and cabdefga is --> %@", "abcdbceea".LCS_WithString("cabdefga"))

// Levenshtein Distance
NSLog("Levenshtein Distance of levenshtein and meilenstein is --> %d", "levenshtein".LD_WithString("meilenstein"))

// KMP
NSLog("Index of KMP string match is --> %d", "bacbababaabcbab".KMPindexOfSubstringWithPattern("bab"))

// MARK: Numeric problems

// Sieve of Eratosf
NSLog("Primes from sieve %@", NSNumber.primeNumbersFromSieveEratosthenesWithMaxNumber(42).description)

// GCD
NSLog("Greatest common divisor of two numbers is %d", 42.greatestCommonDivisorWithNumber(84))

// LCM
NSLog("Least common multiple of two numbers is %d", 16.leastCommonMultipleWithNumber(20))

// Swap integer pointers without using a third element
var intValue1 = 12, intValue2 = 21
NSLog("Integer values before swap: %d, %d", intValue1, intValue2)
NSNumber.swapValueOfIntPointer(&intValue1, withValueOfIntPointer: &intValue2)
NSLog("Integer values after swap: %d, %d", intValue1, intValue2)

// Factorial
NSLog("Factorial is %d", 3.factorial())

// Fibonacci numbers
NSLog("Fibonacci series is %@", NSNumber.fibonacciNumbersUpToNumber(15))

for i: UInt in 91..<92 {
    NSLog("Fibonacci at index %i: %@", i, NSNumber.fibonacciAtIndex(i))         //limited by 92
}

for i: UInt in 298..<300 {
    NSLog("Fibonacci at index %i: %@", i, NSNumber.fibonacciWithDecimal(i))
}

// Find sum of digits
NSLog("Sum of digits is: %d", 1234.sumOfDigits())

// Binary to decimal convertion
NSLog("Decimal is: %d", NSNumber.decimalNumberFromBinary(1101))

// Decimal to binary
NSLog("Binary is %d", NSNumber.binaryNumberFromDecimal(3))

// Fast Exp
NSLog("Fast exp %ld", NSNumber.fastExpForNumber(2, withPower: 10))

// Number reverse
NSLog("Reversed number is %d", 123456789.reverseNumber())

// Even/Odd
NSLog("Given number even? - %@", 1234567.isEven() ? "YES" : "NO")

// Leap year check
NSLog("Is given year leap? - %@", 2000.isLeapGivenYear() ? "YES" : "NO")

// Armstrong number check
NSLog("Is given number Armstrong? --> %@", 407.isArmstrongNumber() ? "YES" : "NO")

// Prime Number Check
NSLog("Is given number Prime? --> %@", 23.isPrime() ? "YES" : "NO")

// Nth prime
NSLog("Nth prime is --> %d", NSNumber.nthPrime(101))

// Square root
NSLog("Square root is --> %f", NSNumber(double: -144.0).squareRoot())
NSLog("Square root is --> %f", NSNumber(double: 2.0).squareRoot())

// Conversion to another numeral system
NSLog("Converted number is --> \(42.convertedNumberWithBase(2))")

// Fast inverse square root
NSLog("FISR is --> \(5.fastInverseSquareRoot())")

// MARK: Data structures

// Stack
let stack = EKStack(size: 3)
stack.push("Hello")
stack.push("World")
stack.push("Programming is fun!")
NSLog("All objects from stack \(stack.allObjectsFromStack())")
stack.popLastObject()
NSLog("All objects from stack after POP \(stack.allObjectsFromStack())")
NSLog("PEEK \(stack.peek())")

// Queue
let queue = EKQueue()
queue.insertObject("Foo")
queue.insertObject("Bar")
queue.insertObject("HakunaMatata")
NSLog("All objects from queue \(queue.allObjectsFromQueue())")
queue.removeFirstObject()
NSLog("All objects from queue after REMOVE \(queue.allObjectsFromQueue())")
NSLog("PEEK object \(queue.peek())")

// Deque
let deque = EKDeque()
deque.insertObjectToFront("Foo")
deque.insertObjectToFront("Bar")
NSLog("All objects from deque \(deque.allObjectsFromDeque())")
deque.insertObjectToBack("Hi")
NSLog("All objects from deque \(deque.allObjectsFromDeque())")
NSLog("PEEK first object \(deque.peekFirstObject())")
deque.removeFirstObject()
NSLog("All objects from deque \(deque.allObjectsFromDeque())")
NSLog("PEEK last object \(deque.peekLastObject())")
deque.removeLastObject()
NSLog("All objects from deque \(deque.allObjectsFromDeque())")

// Binary Heap
let heap = EKBHeap()
heap.insertNumber(6)
heap.insertNumber(7)
heap.insertNumber(12)
heap.insertNumber(10)
heap.insertNumber(15)
heap.insertNumber(17)
heap.insertNumber(5)

NSLog("Minimum Number deleted: \(heap.deleteMin())")

// Graph stuff

// DFS
// Init vertices
let aV = EKVertex(label: "A vertex") // This is a start vertex
let bV = EKVertex(label: "B vertex")
let cV = EKVertex(label: "C vertex")
let dV = EKVertex(label: "D vertex")
let eV = EKVertex(label: "E vertex")
let fV = EKVertex(label: "F vertex")
let gV = EKVertex(label: "G vertex")

// Set adjacent vertices
aV.adjacentEdges = Set([EKEdge(adjacentFrom: aV, to: cV, andWeight: 4),
    EKEdge(adjacentFrom: aV, to: dV, andWeight: 1),
    EKEdge(adjacentFrom: aV, to: bV, andWeight: 2)])
    
bV.adjacentEdges = Set([EKEdge(adjacentFrom: bV, to: aV, andWeight: 2),
    EKEdge(adjacentFrom: bV, to: dV, andWeight: 3),
    EKEdge(adjacentFrom: bV, to: eV, andWeight: 10)])

cV.adjacentEdges = Set([EKEdge(adjacentFrom: cV, to: aV, andWeight: 4),
    EKEdge(adjacentFrom: cV, to: dV, andWeight: 2),
    EKEdge(adjacentFrom: cV, to: fV, andWeight: 5)])

dV.adjacentEdges = Set([EKEdge(adjacentFrom: dV, to: aV, andWeight: 1),
    EKEdge(adjacentFrom: dV, to: bV, andWeight: 3),
    EKEdge(adjacentFrom: dV, to: cV, andWeight: 2),
    EKEdge(adjacentFrom: dV, to: eV, andWeight: 7),
    EKEdge(adjacentFrom: dV, to: fV, andWeight: 8),
    EKEdge(adjacentFrom: dV, to: gV, andWeight: 4)])

eV.adjacentEdges = Set([EKEdge(adjacentFrom: eV, to: bV, andWeight: 10),
    EKEdge(adjacentFrom: eV, to: dV, andWeight: 7),
    EKEdge(adjacentFrom: eV, to: gV, andWeight: 6)])

fV.adjacentEdges = Set([EKEdge(adjacentFrom: fV, to: cV, andWeight: 5),
    EKEdge(adjacentFrom: fV, to: dV, andWeight: 8),
    EKEdge(adjacentFrom: fV, to: gV, andWeight: 1)])

gV.adjacentEdges = Set([EKEdge(adjacentFrom: gV, to: fV, andWeight: 1),
    EKEdge(adjacentFrom: gV, to: dV, andWeight: 4),
    EKEdge(adjacentFrom: gV, to: eV, andWeight: 6)])

// Init graph (see EKGraphPicture.png)
var graph = EKGraph(startVertex: aV, vertices: [aV, bV, cV, dV, eV, fV, gV])

// Is it a directed Graph
if graph.isUndirectedGraph() {
    NSLog("This graph is a undirected graph")
}
else {
    NSLog("This graph is a directed graph")
}

graph.depthFirstSearch()
graph.depthFirstSearchRecursive(aV)
graph.clearVisitHistory()

// BFS
graph.breadthFirstSearch()

// Prim
graph.primMST(aV)

// Kruskal
graph.kruskalMST()

// Dijkstra
graph.dijkstraSPTFrom(aV, to: nil)

// Topsort (see EKTopsort.png)
let c101V = EKVertex(label: "C101") // We simulate courses in university
let c102V = EKVertex(label: "C102")
let c103V = EKVertex(label: "C103")
let d211V = EKVertex(label: "D211")
let e107V = EKVertex(label: "E107")
let f110V = EKVertex(label: "F110")
let g201V = EKVertex(label: "G201")

c101V.adjacentEdges = Set([EKEdge(adjacentFrom: c101V, to: c103V, andWeight: 1)])
c103V.adjacentEdges = Set([EKEdge(adjacentFrom: c103V, to: g201V, andWeight: 1)])
c102V.adjacentEdges = Set([EKEdge(adjacentFrom: c102V, to: c103V, andWeight: 1),
    EKEdge(adjacentFrom: c102V, to: d211V, andWeight: 1),
    EKEdge(adjacentFrom: c102V, to: e107V, andWeight: 1)])
d211V.adjacentEdges = Set([EKEdge(adjacentFrom: d211V, to: g201V, andWeight: 1),
    EKEdge(adjacentFrom: d211V, to: f110V, andWeight: 1)])
e107V.adjacentEdges = Set([EKEdge(adjacentFrom: e107V, to: f110V, andWeight: 1)])

let topGraph = EKGraph(vertices: [c101V, c102V, c103V, d211V, e107V, f110V, g201V])

// Result may vary due to random order in Objective-C fast enumeration
topGraph.topSort()

// Linked list stuff
let list = EKLinkedList(head: 5)
list.addToFront(7)
list.addToFront(9)
list.addToFront(11)
list.addToFront(13)
list.addToFront(15)
list.addToBack(11)
list.addToBack(5)

NSLog("Head is \(list.head.value)")
NSLog("Nodes in list - \(list.count)")

list.printList()

list.reverseList()
NSLog("Nodes in list after reverse:")
list.printList()

list.removeObjectAtIndex(3)

NSLog("Nodes in list after remove - \(list.count)")
list.printList()

NSLog("Find number 3 in list, count: \(list.findObject(3).count)")
NSLog("Find number 11 in list, count: \(list.findObject(11).count)")

// BST stuff
let tree = EKBSTree(object: 4, compareSelector: "compare:")
tree.insertObject(9)
tree.insertObject(2)
tree.insertObject(10)
tree.insertObject(7)
tree.insertObject(-5)
tree.insertObject(-1)
tree.insertObject(2.5)
tree.insertObject(-5.5)

tree.printDescription()        // see EKBSTree.png picture

NSLog("Found %@", tree.find(7).object)        // find @7 and print it

NSLog("Deleted %@", tree.deleteObject(2))      // delete @2 node

tree.printDescription()

// AVL Tree stuff.

let avlt = EKAVLTree(object: 4, compareSelector: "compare:")
avlt.insertObject(9)
avlt.insertObject(2)
avlt.insertObject(10)
avlt.insertObject(7)
avlt.insertObject(-5)
avlt.insertObject(-1)
avlt.insertObject(2.5)
avlt.insertObject(-5.5)
avlt.insertObject(11)
avlt.insertObject(22)
avlt.insertObject(21)

avlt.printDescription()

avlt.deleteObject(11)

avlt.printDescription()

// Tree stuff
let forest1 = EKTree(object: "A")
let forest2 = EKTree(object: "D")

let nodeB = EKTreeNode(object: "B")
let nodeC = EKTreeNode(object: "C")
let nodeE = EKTreeNode(object: "E")
let nodeF = EKTreeNode(object: "F")
let nodeG = EKTreeNode(object: "G")
let nodeH = EKTreeNode(object: "H")
let nodeJ = EKTreeNode(object: "J")
let nodeK = EKTreeNode(object: "K")

forest1.insertNode(nodeB, leftSibling: nil, parent: forest1.root)
forest1.insertNode(nodeC, leftSibling: nodeB, parent: forest1.root)
forest1.insertNode(nodeK, leftSibling: nil, parent:nodeC)

forest2.insertNode(nodeE, leftSibling: nil, parent: forest2.root)
forest2.insertNode(nodeH, leftSibling: nil, parent: nodeE)
forest2.insertNode(nodeF, leftSibling: nodeE, parent: forest2.root)
forest2.insertNode(nodeJ, leftSibling: nil, parent: nodeF)
forest2.insertNode(nodeG, leftSibling: nodeF, parent: forest2.root)

forest1.printDescription()
forest2.printDescription()

EKTree.forestToBinaryTree([forest1, forest2])?.levelOrderTraversal()
/*
// MARK: Recursion
//RECURSION---------------------------------------------------------------------------------

//Tower of Hanoi
[EKRecursionStuff solveTowerOfHanoiWithDisksNumber:3 from:@"A" to:@"C" withExtraPin:@"B"];
*/
