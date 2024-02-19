//
//  ElPropertyView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/30/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct ElPropertyView: View {
    
    var elProperty: ElProperty
    @Bindable var elPropertyStore : ElPropertyStore
    
//    @Binding var isEditing: Bool
    
    @Environment(\.presentationMode) private var showDetail

 
    @State private var localArea: Double?
    @State private var localIZZ: Double?
    @State private var localIYY: Double?
    @State private var localIXY: Double?
    @State private var localIJ: Double?

    
    var body: some View {
        VStack {
            Text("ELEMENT PROPERTY DETAIL").font(.custom("Arial", size: 25))
          
            VStack(alignment: .leading) {
                Text("ID: \(elProperty.id)")
                HStack {
                    Text("Area:")
                    TextField("\(elProperty.area)", value:
                                $localArea, format:.number)
                    
                }
                HStack {
                    Text("Izz:")
                    TextField("\(elProperty.iZZ)", value:
                                $localIZZ, format: .number)
                    
                }
                HStack {
                    Text("Iyy:")
                    TextField("\(elProperty.iYY)", value:
                                $localIYY, format: .number)
                    
                }
                HStack {
                    Text("Ixy:")
                    TextField("\(elProperty.iXY)", value:
                                $localIXY, format: .number)
                    
                }
                HStack {
                    Text("IJ:")
                    TextField("\(elProperty.iJ)", value:
                                $localIJ, format:.number)
                }
          }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .font(.custom("Arial", size: 18))
            
            HStack {
                Spacer()
                 Button (action: {
                     
                     if localArea != nil {
                         elPropertyStore.elProperties[elProperty.id].area = localArea!
                     }
                     if localIZZ != nil {
                         elPropertyStore.elProperties[elProperty.id].iZZ = localIZZ!
                     }
                     if localIYY != nil {
                         elPropertyStore.elProperties[elProperty.id].iYY = localIYY!
                     }
                     if localIXY != nil {
                         elPropertyStore.elProperties[elProperty.id].iXY = localIXY!
                     }
                     if localIJ != nil {
                         elPropertyStore.elProperties[elProperty.id].iJ = localIJ!
                     }
                     

                     

                    self.showDetail.wrappedValue.dismiss()


                 }) { Text ("Save Changes")}
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                 Spacer()

                
            }
            
        }
    }
}

//#if DEBUG
//struct ElPropertyView_Previews: PreviewProvider {
//    static var previews: some View {
//        ElPropertyView(elProperty: ElProperty(id: 0), elPropertyStore: ElPropertyStore())
//    }
//}
//#endif
