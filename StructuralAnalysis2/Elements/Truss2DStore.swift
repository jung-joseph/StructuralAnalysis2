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
class Truss2DStore: Encodable, Decodable, Equatable{
    static func == (lhs: Truss2DStore, rhs: Truss2DStore) -> Bool {
        return lhs.truss2DElements.count == rhs.truss2DElements.count

    }
    
    
    var truss2DElements: [Truss2D] = []

    private enum CodingKeys: CodingKey {
        case truss2DElements
    }


    init() {
        print("Initializing Truss2DStore")
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.truss2DElements = try container.decode([Truss2D].self, forKey: .truss2DElements)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(truss2DElements, forKey: .truss2DElements)
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
