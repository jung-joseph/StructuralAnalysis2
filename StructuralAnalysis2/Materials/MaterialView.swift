//
//  MaterialView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/24/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct MaterialView : View {
    var material: Material
    @Bindable var materialStore : MaterialStore
    @Environment(\.presentationMode) private var showDetail

    
    var body: some View {
        VStack{
            Text("MATERIAL DETAIL").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                Text("ID: \(material.id)").font(.custom("Arial", size: 20))
                HStack {
                    Text("Young's Modulus:").font(.custom("Arial", size: 20))
                    TextField("\(material.youngsModulus)", text: $materialStore.textYM).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                    TextField("\(material.shearModulus)", text: $materialStore.textGM).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                    
                HStack {
                    Spacer ()
                    
                    

                    
                    Button (action: {
                        var ymTemp = Double(self.materialStore.textYM)
                        if  ymTemp == nil {
                            ymTemp = self.materialStore.materials[self.material.id].youngsModulus
                        }
                        self.materialStore.textYM = ""
                        var gmTemp = Double(self.materialStore.textGM)
                        if  gmTemp == nil {
                            gmTemp = self.materialStore.materials[self.material.id].shearModulus
                        }
                        self.materialStore.textGM = ""
                        
                        let newMaterial = Material(id: self.material.id, youngsModulus: ymTemp!, shearModulus: gmTemp!)
                        self.materialStore.changeMaterials(material: newMaterial)
                        self.materialStore.printMaterials()
                        
                        self.showDetail.wrappedValue.dismiss()

                      
                        
                    }) { Text ("Save Changes")}
                    
                    Spacer()
                }
            }
            Spacer()
            

        }
    }
}

#if DEBUG
struct MaterialView_Previews : PreviewProvider {
    static var previews: some View {
        MaterialView(material: Material(id: 0), materialStore: MaterialStore())
    }
}
#endif

