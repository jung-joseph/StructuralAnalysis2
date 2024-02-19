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
    
//    @Binding var isEditing:Bool
    
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
                    Text("Shear Modulus:")
                    TextField("\(material.shearModulus)", value: $localGM, format: .number)
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                    
                HStack {
                    Spacer ()
                    
                    
                    Button (action: {
                        
                        if localYM != nil {
                            materialStore.materials[material.id].youngsModulus = localYM!
                        }
                        if localGM != nil {
                            materialStore.materials[material.id].shearModulus = localGM!
                        }
                            

                        
                        self.showDetail.wrappedValue.dismiss()

                      
                        
                    }) { Text ("Save Changes")}
                        .background(.red)
                        .clipShape(.capsule)
                        
                    
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

