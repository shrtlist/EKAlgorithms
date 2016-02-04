//
//  EKEdge.swift
//  EKAlgorithmsApp
//
//  Created by Yifei Zhou on 3/22/14.
//  Swiftified by Marco Abundo on 02/03/16.
//  Copyright (c) 2014 Evgeny Karkan. All rights reserved.
//

import Foundation

class EKEdge: NSObject {
    var adjacentFrom: EKVertex
    var adjacentTo: EKVertex
    var weight: NSNumber
    var used: Bool

    init(adjacentFrom vertexFrom: EKVertex, to vertexTo: EKVertex, andWeight weight: NSNumber) {
        adjacentFrom = vertexFrom
        adjacentTo   = vertexTo
        self.weight  = weight
        used         = false
        super.init()
    }
}
