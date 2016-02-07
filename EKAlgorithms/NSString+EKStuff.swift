//
//  NSString+EKStuff.m
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Swiftified by Marco Abundo on 29/01/16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

import Foundation

extension NSString {

    // MARK: Is string palindrome

    func isPalindrome() -> Bool {
        var result = false
        let nonWhitespacedBufferString = stringByReplacingOccurrencesOfString(" ", withString:"").lowercaseString
        let reverseString = reversedString()
        
        result = reverseString == nonWhitespacedBufferString ? true : false
        
        return result
    }

    // MARK: String reverse

    func reversedString() -> NSString {
        let result = NSMutableString()
        
        for var i = length - 1; i >= 0; i -= 1 {
            result.appendString(NSString(format: "%C", self.characterAtIndex(i)) as String)
        }
        
        return result.copy() as! NSString
    }

    // MARK: Words in string count

    func numberOfWordsInString() -> Int {
        let str = self as String
        let characters = str.characters
        var state = false
        var wordCounter = 0
    
        for char in characters {
            if char == " " || char == "\n" || char == "\t" {
                state = false
            }
            else if (state == false) {
                state = true
                wordCounter += 1
            }
        }
        
        return wordCounter
    }

    // MARK: Permutations of string
    
    static func allPermutationsOfString(string: String, withFirstCharacterPosition i: Int, lastCharacterPosition n: Int) {
        let characters = Array(string.characters)
        NSString.allPermutationsOfCharacters(characters, withFirstCharacterPosition: i, lastCharacterPosition: n)
    }

    static func allPermutationsOfCharacters(var characters: [Character], withFirstCharacterPosition i: Int, lastCharacterPosition n: Int) {
    
        if i == n {
            let string = String(characters)
            NSLog("Permutation is - %@\n", string)
        }
        else {
            for j in i...n {
                if i != j {
                    swap(&characters[i], &characters[j])
                }
                
                NSString.allPermutationsOfCharacters(characters, withFirstCharacterPosition: i + 1, lastCharacterPosition: n)
                
                if i != j {
                    swap(&characters[i], &characters[j])
                }
            }
        }
    }

    // MARK: Occurrences of each character

    func countEachCharacterOccurrenceInString() {
        let characters = Array(lowercaseString.characters)
        var count = [Int](count: 26, repeatedValue: 0)
        
        let s = String("a").unicodeScalars
        let aValue = s[s.startIndex].value
        
        for character in characters {
            if (character >= "a" && character <= "z") {
                let unicodeScalars = String(character).unicodeScalars
                let unicodeValue = unicodeScalars[unicodeScalars.startIndex].value
                let index = Int(unicodeValue - aValue)
                count[index] += 1
            }
        }
        
        for (index, char) in "abcdefghijklmnopqrstuvwxyz".characters.enumerate() {
            if count[index] != 0 {
                NSLog("\(char) occurs %d times in the entered string\n", count[index])
            }
        }
        //TODO: modify to handle uppercase and special characters
    }

    // MARK: Count needles in a haystack

    func numberOfOccurrenciesOfString(needle: NSString) -> UInt {
        var count: UInt = 0

        var range = NSMakeRange(0, length)
        
        while range.location != NSNotFound {
            range = rangeOfString(needle as String, options: NSStringCompareOptions.CaseInsensitiveSearch, range: range)
            if range.location != NSNotFound {
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length))
                count += 1
            }
        }
        
        return count
    }

    // MARK: Random string

    static func randomStringWithLength(length: Int) -> NSString {
        let possibleChars = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 !@#$%^&*()_-/?;:+=[]|~<>".characters)
        
        var characters = [Character]()
        
        for _ in 0 ..< length {
            characters.append(possibleChars[Int(arc4random_uniform(UInt32(possibleChars.count - 1)))])
        }
        
        return String(characters) as NSString
    }

    // MARK: Concatenation

    func concatenateWithString(secondString: NSString) -> NSString {
        let stringOne = Array((self as String).characters)
        let stringTwo = Array((secondString as String).characters)
        var result = [Character]()
        
        var i = 0
        
        for _ in 0 ..< stringOne.count {
            result.insert(stringOne[i], atIndex: i)
            i += 1
        }
        
        for j in 0 ..< stringTwo.count {
            result.insert(stringTwo[j], atIndex: i + j)
        }
        
        let objcString = String(result) as NSString

        return objcString
    }

    // MARK: First occurrence of needle in a haystack

    func indexOfFirstOccurrenceOfNeedle(needle: NSString) -> Int {
        assert(!needle.isEqualToString(""), "Needle should be valid")
        assert(!isEqualToString(""), "Haystack should be valid")
        assert(needle.length <= length, "Needle should be less or equal in compare with haystack")
        
        var indexOfFirstOccurrence = -1
        var j = 0

        for var i in 0 ..< length {
            if characterAtIndex(i) == needle.characterAtIndex(j) {
                if j == 0 {
                    indexOfFirstOccurrence = i
                }
                
                if j == needle.length - 1 {
                    return indexOfFirstOccurrence
                }
                j += 1
            }
            else if characterAtIndex(i) != needle.characterAtIndex(j) && j > 0 {
                i -= 1
                j = 0
                indexOfFirstOccurrence = -1
            }
        }
        
        return indexOfFirstOccurrence
    }

    // MARK: Last occurrence of needle in a haystack

    func indexOfLastOccurrenceOfNeedle(needle: NSString) -> Int {
        let reversedNeedle   = needle.reversedString()
        let reversedHaystack = self.reversedString()
        
        let firstOccurrenceInReversedString = reversedHaystack.indexOfFirstOccurrenceOfNeedle(reversedNeedle)
        
        var result = 0
        
        if firstOccurrenceInReversedString >= 0 {
            result = self.length - needle.length - firstOccurrenceInReversedString
        }
        else {
            result = -1
        }
        
        return result
    }

    // MARK: Longest common sequence

    private struct AssociatedKey {
        static var arrayKey: UInt8 = 0
    }

    enum DecreaseDir: Int { case kInit = 0, kLeftUp, kUp, kLeft }

    func LCS_WithString(other: NSString) -> NSArray {
        let n = other.length
        
        if (length == 0 || n == 0) {
            return NSArray()
        }
        
        var c = Array(count: length + 1, repeatedValue: Array(count: n + 1, repeatedValue: 0))
        var b = Array(count: length + 1, repeatedValue: Array(count: n + 1, repeatedValue: 0))
        
        for i in 0...length {
            for j in 0...n {
                c[i][j] = 0
                b[i][j] = DecreaseDir.kInit.rawValue
            }
        }
        
        for i in 0 ..< length {
            for j in 0 ..< n {
                if self.substringWithRange(NSMakeRange(i, 1)).isEqual(other.substringWithRange(NSMakeRange(j, 1))) {
                    c[i + 1][j + 1] = c[i][j] + 1
                    b[i + 1][j + 1] = DecreaseDir.kLeftUp.rawValue //↖
                }
                else if c[i][j + 1] >= c[i + 1][j] {
                    c[i + 1][j + 1] = c[i][j + 1]
                    b[i + 1][j + 1] = DecreaseDir.kUp.rawValue  //↑
                }
                else {
                    c[i + 1][j + 1] = c[i + 1][j]
                    b[i + 1][j + 1] = DecreaseDir.kLeft.rawValue //←
                }
            }
        }
        
        var charArray = objc_getAssociatedObject(self, &AssociatedKey.arrayKey)
        if charArray != nil {
            charArray = nil
        }
        charArray = NSMutableArray()
        objc_setAssociatedObject(self, &AssociatedKey.arrayKey, charArray, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        self.LCS_Print(b, withString: other, row: length, andColumn: n)
        
        return charArray as! NSArray
    }

    /** Print a LCS of two strings
     * @param LCS_direction: a 2-dimension matrix which records the direction of LCS generation
     *                other: the second string
     *                  row: the row index in the matrix LCS_direction
     *                  col: the column index in the matrix LCS_direction
     **/
    func LCS_Print(direction: NSArray, withString other: NSString, row i: NSInteger, andColumn j: NSInteger) {
        let length1 = length
        let length2 = other.length
        
        if (length1 == 0 || length2 == 0 || i == 0 || j == 0) {
            return;
        }
        
        if direction[i][j].integerValue == DecreaseDir.kLeftUp.rawValue {
            NSLog("%@ %@ ", self, self.substringWithRange(NSMakeRange(i - 1, 1)))     //reverse
            
            let charArray = objc_getAssociatedObject(self, &AssociatedKey.arrayKey)
            charArray.insertObject(self.substringWithRange(NSMakeRange(i - 1, 1)), atIndex: 0)
            
            self.LCS_Print(direction, withString: other, row: i - 1, andColumn: j - 1)
        }
        else if direction[i][j].integerValue == DecreaseDir.kUp.rawValue {
            self.LCS_Print(direction, withString: other, row: i - 1, andColumn: j)
        }
        else {
            self.LCS_Print(direction, withString: other, row: i, andColumn: j - 1)
        }
    }

    // MARK:  Levenshtein distance

    func LD_WithString(other: NSString) -> Int {
        //creating and retaining a matrix of size self.length+1 by other.length+1
        let n = other.length
        
        if length == 0 || n == 0 {
            return abs(length - n)
        }
        
        var d = Array(count: length + 1, repeatedValue: Array(count: n + 1, repeatedValue: 0))
        
        for i in 0...length {
            d[i][0] = i
        }
        
        for j in 0...n {
            d[0][j] = j
        }
        
        for i in 1...length {
            for j in 1...n {
                let cost = !self.substringWithRange(NSMakeRange(i - 1, 1)).isEqual(other.substringWithRange(NSMakeRange(j - 1, 1)))
                
                let min1 = d[i - 1][j] + 1
                let min2 = d[i][j - 1] + 1
                let min3 = d[i - 1][j - 1] + Int(cost)
                
                d[i][j] = min(min(min1, min2), min3)
            }
        }
        
        return d[length][n]
    }

    // MARK: KMP (Knuth-Morris-Prat)

    func KMPindexOfSubstringWithPattern(pattern: NSString) -> Int {
        let prefix = self.computePrefixFunctionForPattern(pattern)

        var k = -1
        
        for i in 0 ..< self.length {
            while k > -1 && pattern.characterAtIndex(k + 1) != self.characterAtIndex(i) {
                k = prefix[k]
            }
            
            if self.characterAtIndex(i) == pattern.characterAtIndex(k + 1) {
                k += 1
            }

            if k == pattern.length - 1 {
                return i - k
            }
        }
        
        return -1
    }

    func computePrefixFunctionForPattern(pattern: NSString) -> [Int] {
        var prefix = [Int](count: pattern.length, repeatedValue: 0)
        
        var k = -1
        prefix[0] = k
        
        for i in 1 ..< pattern.length {
            while k > -1 && pattern.characterAtIndex(k + 1) != pattern.characterAtIndex(i) {
                k = prefix[k]
            }
            
            if pattern.characterAtIndex(i) == pattern.characterAtIndex(k + 1) {
                k += 1
            }
            prefix[i] = k
        }
        return prefix
    }
}
