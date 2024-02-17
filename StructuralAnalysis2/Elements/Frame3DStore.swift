//
//  Frame3DStore.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/7/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI
import Combine

@Observable
class Frame3DStore: Encodable, Decodable{
    
    var frame3DElements: [Frame3D] = []
//    var numFrame3DElements: Int = 0
//    var matIDText : String = ""
//    var propertyIDText : String = ""
//    var node1Text : String = ""    
//    var node2Text : String = ""

    init() {
        print("Initializing Frame3DStore")
    }
    private enum CodingKeys: CodingKey {
        case frame3DElements
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frame3DElements = try container.decode([Frame3D].self, forKey: .frame3DElements)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(frame3DElements, forKey: .frame3DElements)
    }
    func addFrame3DEl(element: Frame3D){
        frame3DElements.append(element)
//        self.numFrame3DElements += 1
    }
    
    func changeFrame3D(element: Frame3D){
        frame3DElements[element.id] = element
    }
    
    func printConnectivity() {
        print(" ")
        print("Frame2D Elements")
        print("id    node 1    node2")
        print()
        for i in 0...frame3DElements.count-1 {
            print("\(frame3DElements[i].id)    \(frame3DElements[i].node1)       \(frame3DElements[i].node2)")
        }
    }
}
