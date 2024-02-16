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
    
    @Binding var isEditing:Bool
    
    @Environment(\.presentationMode) private var showDetail

    @State private var localYM: Double?
    @State private var localGM: Double?
    
    var body: some View {
        VStack{
            Text("MATERIAL DETAIL").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                Text("ID: \(material.id)").font(.custom("Arial", size: 20))
                HStack {
                    Text("Young's Modulus:").font(.custom("Arial", size: 20))
                    TextField("\(material.youngsModulus)", value: $localYM, format: .number)
                    TextField("\(material.shearModulus)", value: $localGM, format: .number)
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                    
                HStack {
                    Spacer ()
                    
                    
                    Button (action: {
                        if !isEditing {
                            if localYM == nil {
                                localYM = 0.0
                            }
                            if localGM == nil {
                                localGM = 0.0
                            }
                            let newMat = Material(id: self.material.id, youngsModulus: localYM!, shearModulus: localGM!)
                            self.materialStore.addMaterial(material: newMat)
                        } else {
                            if localYM == nil {
                                localYM = material.youngsModulus
                            }
                            if localGM == nil {
                                localGM = material.shearModulus
                            }
                            materialStore.materials[material.id].youngsModulus = localYM!
                            materialStore.materials[material.id].shearModulus = localGM!

                        }
//                        var ymTemp = Double(self.materialStore.textYM)
//                        if  ymTemp == nil {
//                            ymTemp = self.materialStore.materials[self.material.id].youngsModulus
//                        }
//                        self.materialStore.textYM = ""
//                        var gmTemp = Double(self.materialStore.textGM)
//                        if  gmTemp == nil {
//                            gmTemp = self.materialStore.materials[self.material.id].shearModulus
//                        }
//                        self.materialStore.textGM = ""
//                        
//                        let newMaterial = Material(id: self.material.id, youngsModulus: ymTemp!, shearModulus: gmTemp!)
//                        self.materialStore.changeMaterials(material: newMaterial)
//                        self.materialStore.printMaterials()
                        
                        self.showDetail.wrappedValue.dismiss()

                      
                        
                    }) { Text ("Save Changes")}
                    
                    Spacer()
                }
            }
            Spacer()
            

        }
    }
}

//#if DEBUG
//struct MaterialView_Previews : PreviewProvider {
//    static var previews: some View {
//        MaterialView(material: Material(id: 0), materialStore: MaterialStore(), isEditing: .constant(.false))
//    }
//}
//#endif

