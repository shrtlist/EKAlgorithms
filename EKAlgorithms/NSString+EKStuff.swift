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
        
        var i = 0, j = 0
        
        for i = 0; i < stringOne.count; i += 1 {
            result.insert(stringOne[i], atIndex: i)
        }
        
        for j = 0; j < stringTwo.count; j += 1 {            
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
        var i = 0, j = 0

        for i = 0; i < length; i++ {
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
/*
    // MARK: Longest common sequence

    static char arrayKey;

    enum decreaseDir {kInit = 0, kLeftUp, kUp, kLeft};

    - (NSArray *)LCS_WithString:(NSString *)other
    {
        if (other == nil) {
            return 0;
        }
        
        size_t m = self.length;
        size_t n = other.length;
        
        if (m == 0 || n == 0) {
            return 0;
        }
        
        NSMutableArray *c = [NSMutableArray arrayWithCapacity:m + 1];
        NSMutableArray *b = [NSMutableArray arrayWithCapacity:m + 1];
        
        for (int i = 0; i <= m; i++) {
            c[i] = [NSMutableArray arrayWithCapacity:n + 1];
            b[i] = [NSMutableArray arrayWithCapacity:n + 1];
            
            for (int j = 0; j <= n; j++) {
                c[i][j] = @(0);
                b[i][j] = @(kInit);
            }
        }
        
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if ([[self substringWithRange:NSMakeRange(i, 1)] isEqual:[other substringWithRange:NSMakeRange(j, 1)]]) {
                    c[i + 1][j + 1] = @([c[i][j] integerValue] + 1);
                    b[i + 1][j + 1] = @(kLeftUp); //↖
                }
                else if ([c[i][j + 1] integerValue] >= [c[i + 1][j] integerValue]) {
                    c[i + 1][j + 1] = @([c[i][j + 1] integerValue]);
                    b[i + 1][j + 1] = @(kUp);  //↑
                }
                else {
                    c[i + 1][j + 1] = @([c[i + 1][j] integerValue]);
                    b[i + 1][j + 1] = @(kLeft); //←
                }
            }
        }
        
        NSMutableArray *charArray = objc_getAssociatedObject(self, &arrayKey);
        if (charArray) {
            charArray = nil;
        }
        charArray = [NSMutableArray array];
        objc_setAssociatedObject(self, &arrayKey, charArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self LCS_Print:b withString:other row:m andColumn:n];
        
        return charArray;
    }

    /** Print a LCS of two strings
     * @param LCS_direction: a 2-dimension matrix which records the direction of LCS generation
     *                other: the second string
     *                  row: the row index in the matrix LCS_direction
     *                  col: the column index in the matrix LCS_direction
     **/
    - (void)LCS_Print:(NSArray *)direction
           withString:(NSString *)other
                  row:(NSInteger)i
            andColumn:(NSInteger)j
    {
        if (other == nil) {
            return;
        }
        
        size_t length1 = self.length;
        size_t length2 = other.length;
        
        if (length1 == 0 || length2 == 0 || i == 0 || j == 0) {
            return;
        }
        
        if ([direction[i][j] integerValue] == kLeftUp) {
            NSLog(@"%@ %@ ", self, [self substringWithRange:NSMakeRange(i - 1, 1)]);     //reverse
            
            NSMutableArray *charArray = objc_getAssociatedObject(self, &arrayKey);
            [charArray insertObject:[self substringWithRange:NSMakeRange(i - 1, 1)] atIndex:0];
            
            [self LCS_Print:direction withString:other row:i - 1 andColumn:j - 1];
        }
        else if ([direction[i][j] integerValue] == kUp) {
            [self LCS_Print:direction withString:other row:i - 1 andColumn:j];
        }
        else {
            [self LCS_Print:direction
                 withString:other
                        row:i
                  andColumn:j - 1];
        }
    }

    // MARK:  Levenshtein distance

    - (NSInteger)LD_WithString:(NSString *)other
    {
            //creating and retaining a matrix of size self.length+1 by other.length+1
        
        if (other == nil) {
            return self.length;
        }
        
        size_t m = self.length;
        size_t n = other.length;
        
        if (m == 0 || n == 0) {
            return abs((int)m - (int)n);
        }
        
        NSMutableArray *d = [NSMutableArray arrayWithCapacity:m + 1];
        
        for (int i = 0; i <= m; i++) {
            d[i] = [NSMutableArray arrayWithCapacity:n + 1];
            d[i][0] = @(i);
        }
        
        for (int j = 0; j <= n; j++) {
            d[0][j] = @(j);
        }
        
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                int cost = ![[self substringWithRange:NSMakeRange(i - 1, 1)] isEqual:[other substringWithRange:NSMakeRange(j - 1, 1)]];
                
                int min1 = [d[i - 1][j] intValue] + 1;
                int min2 = [d[i][j - 1] intValue] + 1;
                int min3 = [d[i - 1][j - 1] intValue] + cost;
                
                d[i][j] = @(MIN(MIN(min1, min2), min3));
            }
        }
        
        return [d[m][n] integerValue];
    }

    // MARK: KMP (Knuth-Morris-Prat)

    - (NSInteger)KMPindexOfSubstringWithPattern:(NSString *)pattern
    {
        NSParameterAssert(pattern != nil);
        
        NSUInteger selfLenght    = [self length];
        NSUInteger patternLenght = [pattern length];
        
        NSInteger *prefix = [self computePrefixFunctionForPattern:pattern];
        NSParameterAssert(prefix != NULL);
        
        const char *utf8Self        = [self UTF8String];
        size_t self_C_string_lenght = strlen(utf8Self) + 1;
        
        char haystack_C_array[self_C_string_lenght];
        memcpy(haystack_C_array, utf8Self, self_C_string_lenght);
        
        const char *utf8Pattern        = [pattern UTF8String];
        size_t pattern_C_string_lenght = strlen(utf8Pattern) + 1;
        
        char needle_C_array[pattern_C_string_lenght];
        memcpy(needle_C_array, utf8Pattern, pattern_C_string_lenght);
        
        NSInteger k = -1;
        
        for (NSUInteger i = 0; i < selfLenght; i++) {
            while (k > -1 && needle_C_array[k + 1] != haystack_C_array[i]) {
                k = prefix[k];
            }
            if (haystack_C_array[i] == needle_C_array[k + 1]) {
                k++;
            }
            if (k == patternLenght - 1) {
                free(prefix);
                return i - k;
            }
        }
        free(prefix);
        
        return -1;
    }

    - (NSInteger *)computePrefixFunctionForPattern:(NSString *)pattern
    {
        NSUInteger pattern_ObjC_string_lenght = [pattern length];
        
        const char *utf8Pattern        = [pattern UTF8String];
        size_t pattern_C_string_lenght = strlen(utf8Pattern) + 1;
        
        char pattern_C_Array[pattern_C_string_lenght];
        memcpy(pattern_C_Array, utf8Pattern, pattern_C_string_lenght);
        
        NSInteger *prefix = malloc(sizeof(NSInteger) * pattern_ObjC_string_lenght);
        NSParameterAssert(prefix != NULL);
        
        NSInteger k = -1;
        prefix[0] = k;
        
        for (NSUInteger i = 1; i < pattern_ObjC_string_lenght; i++) {
            while (k > -1 && pattern_C_Array[k + 1] != pattern_C_Array[i]) {
                k = prefix[k];
            }
            if (pattern_C_Array[i] == pattern_C_Array[k + 1]) {
                k++;
            }
            prefix[i] = k;
        }
        return prefix;
    }
 */
}
