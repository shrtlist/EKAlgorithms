//
//  EKVertex.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 12.11.13.
//  Swiftified by Marco Abundo on 02/03/16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

import Foundation

class EKVertex {
    var label: String
    var wasVisited = false
    var adjacentEdges: Set<EKEdge>?
    
    init(label: String) {
        self.label = label
    }
}
