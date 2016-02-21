//
//  EKRecursionStuff.swift
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 26.01.14.
//  Swiftified by Marco Abundo on 21.02.16.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

class EKRecursionStuff {

    static func solveTowerOfHanoiWithDisksNumber(number: UInt, from fromPin: AnyObject, to toPin: AnyObject, withExtraPin extraPin: AnyObject) {
        if (number == 1) {
            NSLog("Move disk 1 from pin \(fromPin) to Pin \(toPin)")
            return
                //Minimal moves count should be equal to 2^number - 1
                //e.g 3 disks --> 2^3 - 1 = 7 moves
        }
        
        EKRecursionStuff.solveTowerOfHanoiWithDisksNumber(number - 1, from: fromPin, to: extraPin,  withExtraPin: toPin)
        
        NSLog("Move disk \(number) from pin \(fromPin) to pin \(toPin)")
        
        EKRecursionStuff.solveTowerOfHanoiWithDisksNumber(number - 1, from: extraPin, to: toPin, withExtraPin: fromPin)
    }

}
