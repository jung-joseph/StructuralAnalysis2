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
class Frame2DStore: Encodable, Decodable {
    
    var frame2DElements: [Frame2D] = []
    
    private enum CodingKeys: CodingKey {
        case frame2DElements
    }
    
    init() {
        print("Initializing Frame2DStore")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frame2DElements = try container.decode([Frame2D].self, forKey: .frame2DElements)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(frame2DElements, forKey: .frame2DElements)

    }
    
    func addFrame2DEl(element: Frame2D){
        frame2DElements.append(element)
//        self.numFrame2DElements += 1
    }
    
    func changeFrame2D(element: Frame2D){
        frame2DElements[element.id] = element
    }
    
    func printConnectivity() {
        print(" ")
        print("Frame2D Elements")
        print("id    node 1    node2")
        print()
        for i in 0...frame2DElements.count-1 {
            print("\(frame2DElements[i].id)    \(frame2DElements[i].node1)       \(frame2DElements[i].node2)")
        }
    }
}

