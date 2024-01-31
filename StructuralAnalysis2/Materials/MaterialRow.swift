//
//  MaterialRow.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/24/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct MaterialRow : View {
    var material: Material
    var body: some View {
        HStack {
            Text("#: \(material.id)").font(.custom("Arial", size: 20))
            Text(String(format: "Young's Modulus: %.2e",material.youngsModulus )).font(.custom("Arial", size: 20))
            Text(String(format: "Shear Modulus: %.2e",material.shearModulus )).font(.custom("Arial", size: 20))
            
        }
    }
}

#if DEBUG
struct MaterialRow_Previews : PreviewProvider {
    static var previews: some View {
        MaterialRow(material: Material(id: 0))
    }
}
#endif
