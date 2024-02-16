//
//  NodesStore.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Combine
import SwiftUI

@Observable
class NodesStore: Encodable {
        
    var nodes: [Node]
    var totalNumDofs : Int = 0
    

    
    init() {
        print("Intialize NodeStore")
//        self.numNodes = 0
        var node1 = Node(id: 0)
        node1.id = 0
        node1.xcoord = 0.0
        node1.ycoord = 0.0
        node1.zcoord = 0.0
 
        node1.numDof = 2
//        self.numNodes = 1
        var node2 = Node(id: 1)
        node2.id = 1
        node2.xcoord = 10.0
        node2.ycoord = 0.0
        node2.zcoord = 0.0

        node2.numDof = 2
//        self.numNodes = 2
        nodes = [node1,node2]
        //
//        self.printNodes()
        //
    }
//    func encodeNodeStore() -> Data?{
//        if let encodedNodesStore = try? JSONEncoder().encode(nodes)  {
//            print("nodes encoded")
//            return encodedNodesStore
//        } else {
//            print("nodes encoding failed")
//            return nil
//        }
//    }
    func addNode(node: Node) {
        nodes.append(node)
//        self.numNodes += 1
    }
    
    func changeCoordinates(node: Node) {
        
        nodes[node.id] = node
    }
    
    func printNodes() {
        print(" ")
        print(" \(nodes.count) Nodes")
        print("id    X          Y          Z")
        print()
        for  i in 0...nodes.count-1 {
            print("\(nodes[i].id)   \(nodes[i].xcoord)        \(nodes[i].ycoord)        \(nodes[i].zcoord)" )
        }
        print()
    }
  
    func scanNodesForNumDof (nodesStore: NodesStore,truss2DStore: Truss2DStore, frame2DStore: Frame2DStore, truss3DStore: Truss3DStore, frame3DStore: Frame3DStore) {
        
        // scan truss2d elements
        if truss2DStore.truss2DElements.count > 0 {
            for i in 0...truss2DStore.truss2DElements.count - 1 {
                let node1 = truss2DStore.truss2DElements[i].node1
                let node2 = truss2DStore.truss2DElements[i].node2
                nodesStore.nodes[node1].numDof = 2
                nodesStore.nodes[node2].numDof = 2
            }
        }
        // scan frame2d elements
        if frame2DStore.frame2DElements.count > 0 {
            for i in 0...frame2DStore.frame2DElements.count - 1 {
                let node1 = frame2DStore.frame2DElements[i].node1
                let node2 = frame2DStore.frame2DElements[i].node2
                nodesStore.nodes[node1].numDof = 3
                nodesStore.nodes[node2].numDof = 3
            }
        }
        
        // scan truss3d elements
        if truss3DStore.truss3DElements.count > 0 {
            for i in 0...truss3DStore.truss3DElements.count - 1 {
                let node1 = truss3DStore.truss3DElements[i].node1
                let node2 = truss3DStore.truss3DElements[i].node2
                nodesStore.nodes[node1].numDof = 3
                nodesStore.nodes[node2].numDof = 3
            }
        }
        
        // scan frame3d elements
        if frame3DStore.frame3DElements.count > 0 {
            for i in 0...frame3DStore.frame3DElements.count - 1 {
                let node1 = frame3DStore.frame3DElements[i].node1
                let node2 = frame3DStore.frame3DElements[i].node2
                nodesStore.nodes[node1].numDof = 6
                nodesStore.nodes[node2].numDof = 6
            }
        }
        
        nodesStore.nodes[0].beginDofIndex = 0
        
//        print("Scanning nodes for number of DoFs")
//        print("0 \(nodesStore.nodes[0].beginDofIndex )")
        
        for i in 1...nodesStore.nodes.count - 1 {
            let numDofOnPreviousNode = nodesStore.nodes[i - 1].numDof
            nodesStore.nodes[i].beginDofIndex = nodesStore.nodes[i - 1].beginDofIndex + numDofOnPreviousNode
            
//            print("\(i) \(nodesStore.nodes[i].beginDofIndex )")

        }
        
        self.totalNumDofs = nodesStore.nodes[nodesStore.nodes.count - 1].beginDofIndex + nodesStore.nodes[nodesStore.nodes.count - 1].numDof
    }
    
 
    
}
