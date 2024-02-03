//
//  BCStore.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI
import Combine

@Observable
class BCStore{
    
       var bcs: [BC] = []
//       var numBCs: Int
//       var bcNodeText: String = ""
//       var bcDirectionText: String = ""
//       var bcValueText: String = ""
    
    init() {
        
        print("Initializing bcStore")
//        numBCs = 0
        let bc1 = BC(id: 0, bcNode: 0, bcDirection: 0, bcValue: 0)
//        numBCs = 1
        bcs = [bc1]
        
    }
    
    func addBC(bc: BC) {
        bcs.append(bc)
//        self.numBCs += 1
    }
    
    func changeBC(bc: BC) {
        bcs[bc.id] = bc
    }
    
    func applyBoundaryConditions(system: Gauss, nodesStore: NodesStore) {

        for bcNum in 0...bcs.count - 1 {
            
            let node = self.bcs[bcNum].bcNode
            let startingDof = nodesStore.nodes[node].beginDofIndex
            


            var index = startingDof + (self.bcs[bcNum].bcDirection)
            
            if nodesStore.nodes[node].numDof == 3  &&  self.bcs[bcNum].bcDirection > 2{
                
                index = index - 3
            }
            
//            print("bcNum \(bcNum) startingDof \(startingDof) index \(index)")

            // place bc value in RHS vector
            system.matrix[index][system.neq] = bcs[bcNum].bcValue
            for i in 0...system.neq-1 {
                //Zero Row and Column
                system.matrix[i][index] = 0.0
                system.matrix[index][i] = 0.0
            }
            //place a 1.0 on the diagonal
            system.matrix[index][index] = 1.0

        }

        
    }
    
    func printBCs() {
        print()
        print("Boundary Conditions")
        print("id     Node    Direction     Value")
        print()
        for i in 0...bcs.count-1 {
            print(String(format: " %i     %i    %i     %.2f",bcs[i].id,bcs[i].bcNode, bcs[i].bcDirection, bcs[i].bcValue) )
        }
        print()
    }
}
