//
//  EKNode.swift
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 07.11.13.
//  Swiftified by Marco Abundo on 02.06.16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

class EKNode: NSObject {
    
    var value: AnyObject
    var previous: EKNode?
    var next: EKNode?
 
    init(object: NSObject ) {
        value = object
        super.init()
    }

}
