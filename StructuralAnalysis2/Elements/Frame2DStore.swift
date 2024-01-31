//
//  Frame2DStore.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/26/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Combine
import SwiftUI

@Observable
class Frame2DStore {
    
    var frame2DElements: [Frame2D] = []
    var numFrame2DElements: Int = 0
    var matIDText : String = ""
    var propertyIDText : String = ""
    var node1Text : String = ""    
    var node2Text : String = ""

    init() {
        print("Initializing Frame2DStore")
    }
    
    func addFrame2DEl(element: Frame2D){
        frame2DElements.append(element)
        self.numFrame2DElements += 1
    }
    
    func changeFrame2D(element: Frame2D){
        frame2DElements[element.id] = element
    }
    
    func printConnectivity() {
        print(" ")
        print("Frame2D Elements")
        print("id    node 1    node2")
        print()
        for i in 0...numFrame2DElements-1 {
            print("\(frame2DElements[i].id)    \(frame2DElements[i].node1)       \(frame2DElements[i].node2)")
        }
    }
}

