//
//  ElPropertyStore.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/30/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI
import Combine

@Observable
class ElPropertyStore: Decodable, Encodable {

    var elProperties: [ElProperty]
//    var numElProperties: Int

    private enum CodingKeys: CodingKey {
        case elProperties
//        case numElProperties
    }
    
    init() {
            print("Initialize ElPropertyStore")
//            numElProperties = 0
            var elProperty1 = ElProperty(id: 0)
            elProperty1.id = 0
            elProperty1.area = 1.0
            elProperty1.iZZ = 1.0
            elProperty1.iYY = 1.0
            elProperty1.iXY = 1.0
            elProperty1.iJ = 1.0
//            self.numElProperties = 1
            
            
            elProperties = [elProperty1]
            //
            self.printElProperties()
            //
        }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.elProperties = try container.decode([ElProperty].self, forKey: .elProperties)
//        self.numElProperties = try container.decode(Int.self, forKey: .numElProperties)
    
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(elProperties, forKey: .elProperties)
//        try container.encode(numElProperties, forKey: .numElProperties)
    }
    
    
    func addElProperty(elProperty: ElProperty) {
        elProperties.append(elProperty)
//        self.numElProperties += 1
    }
    
    func changeProperties(elProperty: ElProperty) {
        
        elProperties[elProperty.id] = elProperty
    }
    
    func printElProperties() {
        print(" ")
         print("Element Properties")
         print("id    area          IZZ          IYY          IXY          IJ")
         print()
        for  i in 0...elProperties.count - 1 {
             print("\(elProperties[i].id)   \(elProperties[i].area)          \(elProperties[i].iZZ)        \(elProperties[i].iYY)          \(elProperties[i].iXY)          \(elProperties[i].iJ)" )
         }
         print()
    }
    
    
    
    
    
}
