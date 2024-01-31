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
class ElPropertyStore {

    var elProperties: [ElProperty]
    var numElProperties: Int
    var areaText : String = ""
    var ixxText : String = ""
    var iyyText : String = ""
    var ixyText : String = ""
    var ijText : String = ""
    
    init() {
            print("Initialize ElPropertyStore")
            numElProperties = 0
            var elProperty1 = ElProperty(id: 0)
            elProperty1.id = 0
            elProperty1.area = 1.0
            elProperty1.iZZ = 1.0
            elProperty1.iYY = 1.0
            elProperty1.iXY = 1.0
            elProperty1.iJ = 1.0
            self.numElProperties = 1
            
            
            elProperties = [elProperty1]
            //
            self.printElProperties()
            //
        }
    
    
    func addElProperty(elProperty: ElProperty) {
        elProperties.append(elProperty)
        self.numElProperties += 1
    }
    
    func changeProperties(elProperty: ElProperty) {
        
        elProperties[elProperty.id] = elProperty
    }
    
    func printElProperties() {
        print(" ")
         print("Element Properties")
         print("id    area          IZZ          IYY          IXY          IJ")
         print()
         for  i in 0...numElProperties-1 {
             print("\(elProperties[i].id)   \(elProperties[i].area)          \(elProperties[i].iZZ)        \(elProperties[i].iYY)          \(elProperties[i].iXY)          \(elProperties[i].iJ)" )
         }
         print()
    }
    
    
    
    
    
}
