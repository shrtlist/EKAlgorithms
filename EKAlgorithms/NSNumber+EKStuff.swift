//
//  NSNumber+EKStuff.swift
//  EKAlgorithms
//
//  Created by Vittorio Monaco on 26/11/13.
//  Swiftified by Marco Abundo on 02/02/16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

import Foundation

extension NSNumber {

    // MARK: Sieve of Eratosthenes

    static func primeNumbersFromSieveEratosthenesWithMaxNumber(maxNumber: Int) -> NSArray {
        var resultArray = [Int](count: maxNumber, repeatedValue: 0)
        
        for i in 0 ..< maxNumber {
            resultArray[i] = i
        }
        
        resultArray[1] = 0
        
        for s in 2 ..< maxNumber {
            if resultArray[s] != 0 {
                for var j = s * 2; j < maxNumber; j += s {
                    resultArray[j] = 0
                }
            }
        }
        
        let filtered = resultArray.filter({$0 != 0})
        
        return filtered as NSArray
    }

    // MARK: GCD

    func greatestCommonDivisorWithNumber(var secondNumber: UInt) -> UInt {
        var firstNumber = self.unsignedIntegerValue
        var c: UInt = 0
        
        while firstNumber != 0 {
            c            = firstNumber
            firstNumber  = secondNumber % firstNumber
            secondNumber = c
        }
        
        return secondNumber
    }

    // MARK: LCM

    func leastCommonMultipleWithNumber(secondNumber: UInt) -> UInt {
        let firstNumber = self.unsignedIntegerValue
        return firstNumber * secondNumber  / self.greatestCommonDivisorWithNumber(secondNumber)
    }

    // MARK: Factorial

    func factorial() -> UInt {
        var factorial: UInt = 1
        
        for i in 1...self.unsignedIntegerValue {
            factorial = factorial * i
        }
        
        return factorial
    }

    // MARK: Fibonacci

    /*
     Original implementation does only get Fibonaccis up to the 92nd.
     */
    static func fibonacciNumbersUpToNumber(number: UInt) -> [UInt] {
        var resultArray = [UInt]()
        
        resultArray.append(0)
        resultArray.append(1)
        
        for i in 2..<number {
            let foo  = resultArray[Int(i - 2)] + resultArray[Int(i - 1)]
            resultArray.append(foo)
        }
        
        return resultArray
    }
/*
    /*
     Very slow recursive Fibonacci alogrith.
     */
    + (long long int)recursiveFibonacci:(NSUInteger)index
    {
        if (index == 0) {
            return (long long int)0;
        }
        else if (index == 1) {
            return (long long int)1;
        }
        else {
            return [NSNumber recursiveFibonacci:index - 2] + [NSNumber recursiveFibonacci:index - 1];
        }
    }

    /*
     Very fast Fibonacci alogrithm. Uses unsigned long long to store numbers up to 
     2^64 = 1.8446744e+19 = 18446744073709551615. => 92 is the last index that should
     work with unsigned long long.
     */
    + (unsigned long long)fibonacciWithLongLong:(int)index
    {
            // this does not work because "last" can't hold a number larger than ULLONG_MAX...
        if (index > 93) {
            NSLog(@"Fibonacci at index %i would be too long for ULLONG", index);
        }
        
        unsigned long long beforeLast = 0, last = 1;
        
        while (index > 0) {
            last += beforeLast;
            beforeLast = last - beforeLast;
            --index;
        }
        
        if (index == 0) {
            return beforeLast;
        }
        
        return last;
    }
*/
    /*
     This one uses NSDecimalNumber and is correct until index 185.
     */
    static func fibonacciWithDecimal(var index: UInt) -> NSDecimalNumber {
        var beforeLast = NSDecimalNumber(mantissa: 0, exponent: 0, isNegative: false)
        var last       = NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: false)
        
        while index > 0 {
            last       = last.decimalNumberByAdding(beforeLast)
            beforeLast = last.decimalNumberBySubtracting(beforeLast)
            index -= 1
        }
        
        if (index == 0) {
            return beforeLast
        }
        
        return last
    }

    static func fibonacciAtIndex(index: UInt) -> UInt {
        let array = NSNumber.fibonacciNumbersUpToNumber(index + 1)
        return array[Int(index)]
    }

    // MARK: Sum of digits of a number

    func sumOfDigits() -> UInt {
        var number = self.unsignedIntegerValue
        var sum: UInt = 0
        
        while number != 0 {
            sum    = sum + number % 10
            number = number / 10
        }
        
        return sum
    }

    // MARK: Binary to decimal

    static func decimalNumberFromBinary(var binary: UInt) -> UInt {
        var decimalNumber: UInt = 0, j: UInt = 1, remainder: UInt = 0
        
        while binary != 0 {
            remainder     = binary % 10
            decimalNumber = decimalNumber + remainder * j
            j             = j * 2
            binary        = binary / 10
        }
        
        return decimalNumber;
    }

    // MARK: Decimal to binary

    static func binaryNumberFromDecimal(decimal: UInt) -> Int {
        var quotient: UInt = 0
        var binaryNumber = [UInt](count: 100, repeatedValue: 0)
        var i = 1
        quotient = decimal
        
        while quotient != 0 {
            binaryNumber[i++] = quotient % 2
            quotient          = quotient / 2
        }
        
        let result = NSMutableString()
        
        for var j = i - 1; j > 0; j -= 1 {
            result.appendString(NSString(format: "%d", binaryNumber[j]) as String)
        }
        
        return result.integerValue
    }

    // MARK: Fast exponentiation

    static func fastExpForNumber(var number: Int, var withPower power: Int) -> Int {
        var result = 1
        
        while power != 0 {
            if power % 2 == 1 {
                result *= number
            }
            power /= 2
            number *= number
        }
        
        return result
    }

    // MARK: Number reverse

    func reverseNumber() -> UInt {
        var numberToReverse = self.unsignedIntegerValue
        var rightDigit: UInt      = 0
        let fooString = NSMutableString()
        
        repeat {
            rightDigit = numberToReverse % 10
            fooString.appendString(NSString(format: "%d", rightDigit) as String)
            numberToReverse = numberToReverse / 10
        }
        while numberToReverse != 0
        
        return UInt(fooString.integerValue)
    }

    // MARK: Even/Odd check

    func isEven() -> Bool {
        /*
         NSUInteger remainder = 0;
         remainder = [self intValue] % 2;
         
         return (remainder == 0) ? YES : NO;
         */
        
        // Machine way of doing odd/even check is better than mathematical check above
        let evennessFlag = (self.intValue & 1) == 0
        
        return evennessFlag
    }

    // MARK: Leap year check

    func isLeapGivenYear() -> Bool {
        let givenYear = self.unsignedIntegerValue
        assert(givenYear > 0 && givenYear <= 9999, "Plz enter another year from 0001 - 10000 range")
        
        var remainder_4: UInt = 0, remainder_100: UInt = 0, remainder_400: UInt = 0
        remainder_4   = givenYear % 4
        remainder_100 = givenYear % 100
        remainder_400 = givenYear % 400
        
        return ((remainder_4 == 0 && remainder_100 != 0) || remainder_400 == 0) ? true : false
    }

    // MARK: Armstrong number check

    func isArmstrongNumber() -> Bool {
        var givenNumber = self.unsignedIntegerValue
        var s: UInt = 0, m: UInt = givenNumber, r: UInt = 0
        
        repeat {
            r           = givenNumber % 10
            givenNumber = givenNumber / 10
            s           = s + r * r * r
        }
        while givenNumber != 0
        
        return (s == m) ? true : false
    }

    // MARK: Prime Number Check

    func isPrime() -> Bool {
        let givenNumber = self.unsignedIntegerValue
        
        if givenNumber == 1 || givenNumber == 0 {
            return false
        }
        
        for var i = 2.0; i <= sqrt(Double(givenNumber)); i++ {
            if givenNumber % UInt(i) == 0 {
                return false
            }
        }
        
        return true
    }

    // MARK: Nth prime number

    static func nthPrime(n: UInt) -> UInt {
        var number: UInt = 1, count: UInt = 0, i: UInt = 0;
        
        while count < n {
            number = number + 1
            for i = 2; i <= number; i++ {
                if number % i == 0 {
                    break
                }
            }
            if i == number {
                count = count + 1
            }
        }
        
        return number
    }

    // MARK: Smart swap

    static func swapValueOfIntPointer(inout xPointer: Int, inout withValueOfIntPointer yPointer: Int) {        
        swap(&xPointer, &yPointer)
    }

    // MARK: Square root using Newton–Raphson algo

    func squareRoot() -> Float {
        if self.floatValue < 0 {
            return -1
        }
        
        let epsilon: Float = 0.00001
        var guess: Float = 1.0
        
        while NSNumber.absoluteValue(guess * guess - self.floatValue) >= epsilon {
            guess = (self.floatValue / guess + guess) / 2.0
        }
        
        return guess
    }

    static func absoluteValue(number: Float) -> Float {
        var absValue = number
        if absValue < 0 {
            absValue = -absValue
        }
        
        return absValue
    }

    // MARK: Convert integer to another numeral system (2, 8, 12, 16)

    func convertedNumberWithBase(var base: Int) -> AnyObject {
        if (base != 2 && base != 8 && base != 10 && base != 12 && base != 16) {
            NSLog("Bad base - base must be 2, 8, 10, 12 or 16 only")
            base = 10
        }
        
        let baseDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
        var numberToConvert = self.longValue
        var convertedNumber = [Int](count: 64, repeatedValue: 0)
        var nextDigit = 0, index = 0
        var resultOfConversion: AnyObject!
        let resultString = NSMutableString()
        
        repeat {
            convertedNumber[index] = numberToConvert % base
            index += 1
            numberToConvert = numberToConvert / base
        }
        while (numberToConvert != 0)
        
        for (--index; index >= 0; --index) {
            nextDigit = convertedNumber[index]
            resultString.appendString(String(baseDigits[nextDigit]))
        }
        
        if (base == 2 || base == 8 || base == 10) {
            let f = NSNumberFormatter()
            let myNumber   = f.numberFromString(resultString as String)
            resultOfConversion   = myNumber
        }
        else {
            resultOfConversion = resultString.copy() as! NSNumber
        }
        
        return resultOfConversion
    }

    // MARK: Fast inverse square root

    func fastInverseSquareRoot() -> Float
    {
        assert(self.floatValue > 0)
        
        var result = self.floatValue
        let halfOfResult = result * 0.5
        
        var i = result._toBitPattern()    // get bits for floating value
        i         = 0x5f3759df - (i >> 1)  // gives initial guess
        result    = Float._fromBitPattern(i)         // convert bits back to float
        
        for var idx = 0; idx < 4; idx++ {
            result = result * (1.5 - halfOfResult * result * result)  // Newton step, repeating increases accuracy
        }
        
        return result
    }

    // MARK: Number Type

    func numberType() -> CFNumberType {
        let ref = self as CFNumber
        return CFNumberGetType(ref)
    }

    // MARK: Quick Sum
    // FIXME: Switch logic

    static func sumOfNumbers(numbers: NSArray) -> NSNumber {
        // Be careful about number types, we will
        // return the same type as first object in array
        var sum = NSNumber()
        let count = numbers.count
        
        sum = NSNumber(int: (numbers.firstObject?.intValue)!)
        for i in 1..<count {
            sum = NSNumber(int: sum.intValue + numbers[i].intValue)
        }
        /*
        switch numbers.firstObject?.numberType() {
        case typeSInt32:
            print("d")
            case kCFNumberSInt32Type:
                sum = NSNumber(int: (numbers.firstObject?.intValue)!)
                for i in 1..<count {
                    sum = NSNumber(int: sum.intValue + numbers[i].intValue)
                }
                
            case kCFNumberSInt64Type:
                sum = NSNumber(integer: numbers.firstObject?.integerValue)
                for i in 1..<count {
                    sum = NSNumber(integer: sum.integerValue + numbers[i].integerValue)
                }
                
            case kCFNumberFloat32Type, kCFNumberFloat64Type:
                sum = NSNumber(float: numbers.firstObject?.floatValue)
                for i in 1..<count {
                    sum = NSNumber(float: sum.floatValue + numbers[i].floatValue)
                }
                
            default:
                assert(false, "Not recognized type, check CFNumberType!")
        }
    */
        return sum
    }
}
