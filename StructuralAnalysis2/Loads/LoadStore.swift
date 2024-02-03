//
//  LoadStore.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/16/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI
import Combine

@Observable
class LoadStore: ObservableObject {

       var loads: [Load] = []
//       var numLoads: Int
//       var loadNodeText: String = ""
//       var loadDirectionText: String = ""    
//       var loadValueText: String = ""
    
    
    init() {
        
//        numLoads = 0
        print("Initializing loadStore")
    }
    
    func addLoad(load: Load) {
        loads.append(load)
//        self.numLoads += 1
    }
    
    func changeLoad(load: Load) {
        loads[load.id] = load
    }
    
    func applyLoads(system: Gauss, nodesStore: NodesStore) {

        if loads.count > 0 {
            for i in 0...loads.count - 1 {
                // place load value in RHS vector
                let node = self.loads[i].loadNode

                let startingDof = nodesStore.nodes[node].beginDofIndex

                var index =  startingDof + (self.loads[i].loadDirection)

                if nodesStore.nodes[node].numDof == 3  &&  self.loads[i].loadDirection > 2{
                     
                     index = index - 3
                 }
                
                    
                
                system.matrix[index][system.neq] = loads[i].loadValue

            }
        }

        
    }
    
    func printLoads() {
        print()
        print("Applied Loads")
        print("id     Node    Direction     Value")
        print()
        for i in 0...loads.count-1 {
            print(String(format: " %i     %i    %i     %.2f",loads[i].id,loads[i].loadNode, loads[i].loadDirection, loads[i].loadValue) )
        }
        print()
    }
}
