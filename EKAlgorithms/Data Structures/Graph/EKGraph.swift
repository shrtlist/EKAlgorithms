//
//  EKGraph.swift
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 12.11.13.
//  Swiftified by Marco Abundo on 02/04/16.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

import Foundation

class EKGraph: NSObject {
    var firstVertex: EKVertex?
    var indegree: [String : Int]?
    var vertices: [EKVertex]

    // MARK: Initializer

    init(startVertex: EKVertex?, vertices: [EKVertex]) {
        self.firstVertex = startVertex
        self.vertices = vertices
        super.init()
    }
    
    convenience init(vertices: [EKVertex]) {
        self.init(startVertex: nil, vertices: vertices)
    }

    // MARK: -
    
    func isUndirectedGraph() -> Bool {
        assert(vertices.count > 0, "No any vertex in graph")
        
        for vertex in vertices {
            if !hasOppositeEdge(vertex) {
                return false
            }
        }
        return true
    }

    func hasOppositeEdge(vertex: EKVertex) -> Bool {
        if let adjacentEdges = vertex.adjacentEdges {
            for eachEdge in adjacentEdges {
                for edge in eachEdge.adjacentTo.adjacentEdges! {
                    if edge.adjacentTo == vertex {
                        return true
                    }
                }
            }
        }
        return false
    }

    // MARK: Prim Algorithm

    func primMST(start: EKVertex) {
        let startVertex  = start
        var parent = [EKEdge]()
        
        clearVisitHistory()
        
        startVertex.wasVisited = true
        
        while visitedVertices().count != vertices.count {
            if let minimumEdge = EKGraph.minimumWeightEdgeInVertices(visitedVertices()) {
                parent.append(minimumEdge)
                minimumEdge.adjacentTo.wasVisited = true
            }
        }
        
        for edge in parent {
            NSLog("From \(edge.adjacentFrom.label), To \(edge.adjacentTo.label), Weight \(edge.weight)")
        }
    }

    static func minimumWeightEdgeInVertices(vertices: [EKVertex]) -> EKEdge? {
        var minimumEdge: EKEdge?
        
        for vertex in vertices {
            if let adjacentEdges = vertex.adjacentEdges {
                for edge in adjacentEdges {
                    if minimumEdge == nil {
                        if !edge.adjacentTo.wasVisited {
                            minimumEdge = edge
                        }
                    }
                    else {
                        if minimumEdge!.weight > edge.weight && !edge.adjacentTo.wasVisited {
                            minimumEdge = edge
                        }
                    }
                }
            }
        }
        return minimumEdge
    }

    func visitedVertices() -> [EKVertex] {
        var visited = [EKVertex]()
        
        for vertex in vertices {
            if vertex.wasVisited {
                visited.append(vertex)
            }
        }
        
        return visited
    }

    // MARK: Kruskal Algorithm

    func kruskalMST() {
        var edges = [EKEdge]()
        
        for vertex in vertices {
            if let adjacentEdges = vertex.adjacentEdges {
                for edge in adjacentEdges {
                    edges.append(edge)
                }
            }
        }
        
        var forestCount = vertices.count
        
        while (forestCount > 1) {
            if let e = EKGraph.minimumWeightUnusedEdgeInEdges(edges) {
                if !hasPathBetweenVertices([e.adjacentFrom, e.adjacentTo]) {
                    e.used = true
                    EKGraph.oppositeEdge(e, inEdges: edges)!.used = true
                    forestCount -= 1
                }
                else {
                    edges.removeAtIndex(edges.indexOf(e)!)
                    edges.removeAtIndex(edges.indexOf(EKGraph.oppositeEdge(e, inEdges: edges)!)!)
                }
            }
        }
        
        for edge in edges {
            if edge.used {
                NSLog("\(edge.adjacentFrom.label) -- Weight: \(edge.weight) --> \(edge.adjacentTo.label)")
            }
        }
    }

    static func minimumWeightUnusedEdgeInEdges(edges: [EKEdge]) -> EKEdge? {
        var minEdge: EKEdge?
        
        for edge in edges {
            if !edge.used {
                if minEdge != nil {
                    if minEdge!.weight > edge.weight {
                        minEdge = edge
                    }
                }
                else {
                    minEdge = edge
                }
            }
        }
        
        return minEdge
    }

    func hasPathBetweenVertices(vertices: [EKVertex]) -> Bool {
        assert(vertices.count == 2, "Vertices Count must be two!")
        assert(vertices.first != vertices.last, "Vertices must be different!")
        
        let queue = EKQueue()
        clearVisitHistory()
        
        if let startVertex  = vertices.first {
            startVertex.wasVisited = true
            
            if let adjacentEdges = startVertex.adjacentEdges {
                for edge in adjacentEdges {
                    if edge.used {
                        queue.insertObject(edge.adjacentTo)
                    }
                }
            }
        }
        
        while !queue.isEmpty() {
            let peekVertex  = queue.removeFirstObject() as! EKVertex
            peekVertex.wasVisited = true
            
            if peekVertex == vertices.last {
                return true
            }
            else {
                if let adjacentEdges = peekVertex.adjacentEdges {
                    for edge in adjacentEdges {
                        if edge.used && !edge.adjacentTo.wasVisited {
                            queue.insertObject(edge.adjacentTo)
                        }
                    }
                }
            }
        }
        
        return false
    }

    static func oppositeEdge(edge: EKEdge, inEdges edges: [EKEdge]) -> EKEdge? {
        let startVertex = edge.adjacentFrom
        let endVertex   = edge.adjacentTo
        
        for e in edges {
            if e.adjacentFrom == endVertex && e.adjacentTo == startVertex && e.weight == edge.weight {
                return e
            }
        }
        return nil
    }

    // MARK: Dijkstra Algorithm

    func dijkstraSPTFrom(source: EKVertex, to target: EKVertex?) {
        let sourceVertex = source, targetVertex = target
        
        var dist     = [String: Int]()
        var previous = [String : EKVertex]()
        let Q             = vertices
        
        for vertex in Q {
            dist[vertex.label] = Int.max
            previous[vertex.label] = nil
        }
        dist[sourceVertex.label] = 0
        
        while Q.count > visitedVertices().count {
            let u = EKGraph.hasMinimumDistance(dist, inVertices: Q)
            if (u == targetVertex) {
                break
            }
    
            if dist[u.label] == Int.max {
                break
            }
            
            if let adjacentEdges = u.adjacentEdges {
                for edge in adjacentEdges {
                    let v   = edge.adjacentTo
                    let alt = NSNumber.sumOfNumbers([dist[u.label]!, edge.weight]).integerValue
                    
                    if alt < dist[v.label] {
                        dist[v.label] = alt
                        previous[v.label] = u
                    }
                }
            }
            u.wasVisited = true
        }
        
        for (label, _) in previous {
            if previous[label] != nil {
                NSLog("\(label) previous node --> \(previous[label]!.label)")
            }
            else {
                NSLog("\(label) has no previous node")
            }
        }
    }

    static func hasMinimumDistance(dist: [String: Int], inVertices Q: [EKVertex]) -> EKVertex {
        var minDist: Int?
        var index  = 0
        
        for vertex in Q {
            if !vertex.wasVisited {
                let label = vertex.label
                if minDist == nil {
                    minDist = dist[label]
                    index   = Q.indexOf(vertex)!
                }
                else {
                    if minDist > dist[label] {
                        minDist = dist[label]
                        index   = Q.indexOf(vertex)!
                    }
                }
            }
        }
        
        return Q[index]
    }

    // MARK: Topsort

    func topSort() {
        var topNum = [EKVertex]()
        let queue = EKQueue()
        
        for _ in 0 ..< vertices.count {
            if let vertex = findNewVertexOfIndegreeZero(vertices) {
                queue.insertObject(vertex)
            }
        }
        assert(!queue.isEmpty(), "Graph has a cycle!")
        
        while !queue.isEmpty() {
            let V = queue.removeFirstObject() as! EKVertex
            topNum.append(V)
            
            if let adjacentEdges = V.adjacentEdges {
                for edge in adjacentEdges {
                    indegree?.selfDecreaseValueForKey(edge.adjacentTo.label)
                    if indegree![edge.adjacentTo.label] == 0 {
                        queue.insertObject(edge.adjacentTo)
                    }
                }
            }
        }
        
        for vertex in topNum {
            NSLog("Topsort \(topNum.indexOf(vertex)!) --> \(vertex.label)")
        }
    }

    func findNewVertexOfIndegreeZero(vertices: [EKVertex]) -> EKVertex? {
        if indegree == nil {
            // Graph should not change at runtime
            indegree = [String : Int]()
            clearVisitHistory()
            
            for vertex in vertices {
                indegree![vertex.label] = 0
            }
            
            for vertex in vertices {
                if let adjacentEdges = vertex.adjacentEdges {
                    for edge in adjacentEdges {
                        let adjTo = edge.adjacentTo
                        indegree![adjTo.label] = indegree![adjTo.label]!+1
                    }
                }
            }
        }
        
        for vertex in vertices {
            if indegree![vertex.label] == 0 && !vertex.wasVisited {
                vertex.wasVisited = true
                return vertex
            }
        }
        return nil
    }

    // MARK: DFS

    func depthFirstSearch() {
        assert(vertices.count > 0, "No any vertex in graph")
        
        if let startVertex = self.firstVertex {
            startVertex.label      = "Start vertex"
            startVertex.wasVisited = true
            displayVisitedVertex(startVertex)
            
            let stack = EKStack()
            stack.push(startVertex)
            
            while !stack.isEmpty() {
                // We can unwrap when peeking since the stack is not empty
                let lastVertex = stack.peek()!
                var isAddNewVertex = false
                
                if let adjacentEdges = lastVertex.adjacentEdges {
                    for adjacentEdge in adjacentEdges! {
                        if !adjacentEdge.adjacentTo.wasVisited {
                            stack.push(adjacentEdge.adjacentTo)
                            adjacentEdge.adjacentTo.wasVisited = true
                            isAddNewVertex = true
                            displayVisitedVertex(adjacentEdge.adjacentTo)
                            break
                        }
                    }

                    if !isAddNewVertex {
                        stack.popLastObject()
                    }
                }
            }
        
            clearVisitHistory()
        }
    }

    func depthFirstSearchRecursive(vertex: EKVertex) {
        assert(vertices.count > 0, "No vertices in graph")
        
        vertex.wasVisited = true
        displayVisitedVertex(vertex)
        
        if let adjacentEdges = vertex.adjacentEdges {
            for edge in adjacentEdges {
                if !edge.adjacentTo.wasVisited {
                    depthFirstSearchRecursive(edge.adjacentTo)
                }
            }
        }
    }

    func displayVisitedVertex(visitedVertex: EKVertex) {
        NSLog("%@ - was visited", visitedVertex.label)
    }

    // MARK: BFS

    func breadthFirstSearch() {
        assert(vertices.count > 0, "No any vertex in graph")
        
        if let startVertex = self.firstVertex {
            startVertex.label      = "Start vertex"
            startVertex.wasVisited = true
            displayVisitedVertex(startVertex)
            
            let queue = EKQueue()
            queue.insertObject(startVertex)
            
            while !queue.isEmpty() {
                let foo = queue.removeFirstObject() as! EKVertex
                
                if let adjacentEdges = foo.adjacentEdges {
                    for adjacentEdge in adjacentEdges {
                        if !adjacentEdge.adjacentTo.wasVisited {
                            queue.insertObject(adjacentEdge.adjacentTo)
                            adjacentEdge.adjacentTo.wasVisited = true
                            displayVisitedVertex(adjacentEdge.adjacentTo)
                        }
                    }
                }
            }
            
            clearVisitHistory()
        }
    }

    // MARK: Clear visit history

    func clearVisitHistory() {
        for vertex in vertices {
            if let adjacentEdges = vertex.adjacentEdges {
                for edge in adjacentEdges {
                    edge.used = false
                }
                vertex.wasVisited = false
            }
        }
    }

}
