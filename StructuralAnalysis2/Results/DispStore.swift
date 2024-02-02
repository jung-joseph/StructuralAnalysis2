//
//  DispStore.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/21/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Combine
import SwiftUI

@Observable
class DispStore: ObservableObject {
    
    var displacements : [NodalDisp]?

    init() {
        print("Initializing DispStore")
    }
    
    func fillDispStore (x: [Double], nodesStore: NodesStore, truss2DStore: Truss2DStore, frame2DStore: Frame2DStore, truss3DStore: Truss3DStore, frame3DStore: Frame3DStore) {
        

        var u : [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        var newNodalDisp : NodalDisp
        
        for i in 0 ... nodesStore.nodes.count - 1 {
                
                if (displacements?.append(NodalDisp(id: i)) ) == nil {
                    displacements = [NodalDisp(id: i)]
                }
//                print("created displacments[\(i)]")
//                print("\(displacements![i] )")
            }
        
        if truss2DStore.truss2DElements.count > 0 {
            for i in 0...truss2DStore.truss2DElements.count - 1 {
                let node1 = truss2DStore.truss2DElements[i].node1
                let node2 = truss2DStore.truss2DElements[i].node2
                
                let startingDof1 = nodesStore.nodes[node1].beginDofIndex
                u[0] = x[startingDof1]
                u[1] = x[startingDof1 + 1]
                newNodalDisp = NodalDisp(id: node1, u: u)
                displacements![node1] = newNodalDisp

                let startingDof2 = nodesStore.nodes[node2].beginDofIndex
                u[0] = x[startingDof2]
                u[1] = x[startingDof2 + 1]
                newNodalDisp = NodalDisp(id: node2, u: u)
                displacements![node2] = newNodalDisp
            }
        }
        
        if frame2DStore.frame2DElements.count > 0 {
            for i in 0...frame2DStore.frame2DElements.count - 1 {
                let node1 = frame2DStore.frame2DElements[i].node1
                let node2 = frame2DStore.frame2DElements[i].node2
                
//                print("node1 \(node1) node2 \(node2)")
                
                let startingDof1 = nodesStore.nodes[node1].beginDofIndex
                
//                print("startingDof1 \(startingDof1)")
                
                u[0] = x[startingDof1]
                u[1] = x[startingDof1 + 1]
                u[5] = x[startingDof1 + 2]
              
                newNodalDisp = NodalDisp(id: node1, u: u)
                displacements![node1] = newNodalDisp

                let startingDof2 = nodesStore.nodes[node2].beginDofIndex
                
//                print("startingDof2 \(startingDof2)")

                u[0] = x[startingDof2]
                u[1] = x[startingDof2 + 1]
                u[5] = x[startingDof2 + 2]
                newNodalDisp = NodalDisp(id: node2, u: u)
                displacements![node2] = newNodalDisp
            }
        }
        
        if truss3DStore.truss3DElements.count > 0 {
            for i in 0...truss3DStore.truss3DElements.count - 1 {
                        let node1 = truss3DStore.truss3DElements[i].node1
                        let node2 = truss3DStore.truss3DElements[i].node2
                        
        //                print("node1 \(node1) node2 \(node2)")
                        
                        let startingDof1 = nodesStore.nodes[node1].beginDofIndex
                        
        //                print("startingDof1 \(startingDof1)")
                        
                        u[0] = x[startingDof1]
                        u[1] = x[startingDof1 + 1]
                        u[2] = x[startingDof1 + 2]
                      
                        newNodalDisp = NodalDisp(id: node1, u: u)
                        displacements![node1] = newNodalDisp

                        let startingDof2 = nodesStore.nodes[node2].beginDofIndex
                        
        //                print("startingDof2 \(startingDof2)")

                        u[0] = x[startingDof2]
                        u[1] = x[startingDof2 + 1]
                        u[2] = x[startingDof2 + 2]
                        newNodalDisp = NodalDisp(id: node2, u: u)
                        displacements![node2] = newNodalDisp
                    }
                }
        
        if frame3DStore.frame3DElements.count > 0 {
            for i in 0...frame3DStore.frame3DElements.count - 1 {
                        let node1 = frame3DStore.frame3DElements[i].node1
                        let node2 = frame3DStore.frame3DElements[i].node2
                        
        //                print("node1 \(node1) node2 \(node2)")
                        
                        let startingDof1 = nodesStore.nodes[node1].beginDofIndex
                        
        //                print("startingDof1 \(startingDof1)")
                        
                        u[0] = x[startingDof1]
                        u[1] = x[startingDof1 + 1]
                        u[2] = x[startingDof1 + 2]
                        u[3] = x[startingDof1 + 3]
                        u[4] = x[startingDof1 + 4]
                        u[5] = x[startingDof1 + 5]

                      
                        newNodalDisp = NodalDisp(id: node1, u: u)
                        displacements![node1] = newNodalDisp

                        let startingDof2 = nodesStore.nodes[node2].beginDofIndex
                        
        //                print("startingDof2 \(startingDof2)")

                        u[0] = x[startingDof2]
                        u[1] = x[startingDof2 + 1]
                        u[2] = x[startingDof2 + 2]
                        u[3] = x[startingDof2 + 3]
                        u[4] = x[startingDof2 + 4]
                        u[5] = x[startingDof2 + 5]
                        
                        
                        
                        newNodalDisp = NodalDisp(id: node2, u: u)
                        displacements![node2] = newNodalDisp
                    }
                }


    }
    
    func printDispStore(numNodes: Int) {
        print()
        print("Displacments")
        for i in 0...numNodes-1 {
            print(" \(self.displacements![i].id) \(self.displacements![i].u[0]), \(self.displacements![i].u[1]), \(self.displacements![i].u[2]), \(self.displacements![i].u[3]), \(self.displacements![i].u[4]), \(self.displacements![i].u[5])")
            
        }
    }
}
