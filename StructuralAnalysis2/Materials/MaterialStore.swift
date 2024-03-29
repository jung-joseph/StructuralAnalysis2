//
//  MaterialStore.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/24/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Combine
import SwiftUI

@Observable
class MaterialStore: Encodable,Decodable {
    

    
    var materials: [Material]
    
    private enum CodingKeys: CodingKey {
        case materials
    }
   
    
    init() {
        
        print("Initialize MaterialStore")
//        numMaterials = 0
        var material1 = Material(id: 0)
        material1.id = 0
        material1.youngsModulus = 30.0e6
        material1.shearModulus = 11.5e6
//        self.numMaterials = 1
        
        materials = [material1]
        //
        self.printMaterials()
        //
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.materials = try container.decode([Material].self, forKey: .materials)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(materials, forKey: .materials)

    }
    
    func addMaterial(material: Material) {
        materials.append(material)
//        self.numMaterials += 1
    }
    
    func changeMaterials(material: Material) {
        
        materials[material.id] = material
    }
    
    func printMaterials() {
        print(" ")
        print("Materials")
        print("numMaterials \(materials.count)")
        print("id    Youngs Modulus")
        print()
        for  i in 0...materials.count-1 {
            print("\(materials[i].id)   \(materials[i].youngsModulus)  " )
        }
        print()
    }
    
}
