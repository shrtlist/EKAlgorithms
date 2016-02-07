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
    var weight: Int
    var used: Bool

    init(adjacentFrom vertexFrom: EKVertex, to vertexTo: EKVertex, andWeight weight: Int) {
        self.adjacentFrom = vertexFrom
        self.adjacentTo   = vertexTo
        self.weight       = weight
        self.used         = false
        super.init()
    }
}
