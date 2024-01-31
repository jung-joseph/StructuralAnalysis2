//
//  OneDStore.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/1/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Combine
import SwiftUI

@Observable
class Truss2DStore: Equatable{
    static func == (lhs: Truss2DStore, rhs: Truss2DStore) -> Bool {
        return lhs.truss2DElements.count == rhs.truss2DElements.count

    }
    
    
    var truss2DElements: [Truss2D] = []
//    var numTruss2DElements: Int = 0
//    var matID : Int = 0
//    var propertyID : Int = 0
//    var node1Text : String = ""
//    var node2Text : String = ""


    init() {
        print("Initializing Truss2DStore")
    }
    
    func addTruss2DEl(element: Truss2D){
        truss2DElements.append(element)
//        self.numTruss2DElements += 1
    }
    
    func changeTruss2D(element: Truss2D){
        truss2DElements[element.id] = element
    }
    
    func printConnectivity() {
        print(" ")
        print("Truss2D Elements")
        print("id    node 1    node2")
        print()
        for i in 0...truss2DElements.count-1 {
            print("\(truss2DElements[i].id)    \(truss2DElements[i].node1)       \(truss2DElements[i].node2)")
        }
    }
}
