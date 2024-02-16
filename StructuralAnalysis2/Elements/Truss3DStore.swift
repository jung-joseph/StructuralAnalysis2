//
//  Truss3DStore.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/5/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

//import Combine
import SwiftUI

@Observable
class Truss3DStore: Encodable{
    
    var truss3DElements: [Truss3D] = []
//    var numTruss3DElements: Int = 0
//    var matIDText : String = ""
//    var propertyIDText : String = ""
//    var node1Text : String = ""
//    var node2Text : String = ""

    init() {
        print("Initializing Truss2DStore")
    }
    
    func addTruss3DEl(element: Truss3D){
        truss3DElements.append(element)
//        self.numTruss3DElements += 1
    }
    
    func changeTruss3D(element: Truss3D){
        truss3DElements[element.id] = element
    }
    
    func printConnectivity() {
        print(" ")
        print("Truss3D Elements")
        print("id    node 1    node2")
        print()
        for i in 0...truss3DElements.count-1 {
            print("\(truss3DElements[i].id)    \(truss3DElements[i].node1)       \(truss3DElements[i].node2)")
        }
    }
}

