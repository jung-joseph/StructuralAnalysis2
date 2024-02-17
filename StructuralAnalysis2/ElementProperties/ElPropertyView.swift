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
    
    @Binding var isEditing: Bool
    
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
            .font(.custom("Arial", size: 20))
            
            HStack {
                Spacer()
                 Button (action: {
                     
                     if !isEditing {
                         if localArea == nil {
                             localArea = 0.0
                         }
                         if localIZZ == nil {
                             localIZZ = 0.0
                         }
                         if localIYY == nil {
                             localIYY = 0.0
                         }
                         if localIXY == nil {
                             localIXY = 0.0
                         }
                         if localIJ == nil {
                             localIJ = 0.0
                         }
                         let newElProperty = ElProperty(id: self.elProperty.id, area: localArea!, iZZ: localIZZ!, iYY: localIYY!, iXY: localIXY!, iJ: localIJ!)
                         self.elPropertyStore.addElProperty(elProperty: newElProperty)
                     } else {
                         if localArea == nil {
                             localArea = elProperty.area
                         }
                         if localIZZ == nil {
                             localIZZ = elProperty.iZZ
                         }
                         if localIYY == nil {
                             localIYY = elProperty.iYY
                         }
                         if localIXY == nil {
                             localIXY = elProperty.iXY
                         }
                         if localIJ == nil {
                             localIJ = elProperty.iJ
                         }
                         elPropertyStore.elProperties[elProperty.id].area = localArea!
                         elPropertyStore.elProperties[elProperty.id].iZZ = localIZZ!
                         elPropertyStore.elProperties[elProperty.id].iYY = localIYY!
                         elPropertyStore.elProperties[elProperty.id].iXY = localIXY!
                         elPropertyStore.elProperties[elProperty.id].iJ = localIJ!


                     }
                     
                     
/*
                     var areatemp = Double(self.elPropertyStore.areaText)
                     if  areatemp == nil {
                         areatemp = self.elPropertyStore.elProperties[self.elProperty.id].area
                     }
                     self.elPropertyStore.areaText = ""
                    
                     var izztemp = Double(self.elPropertyStore.ixxText)
                     if  izztemp == nil {
                         izztemp = self.elPropertyStore.elProperties[self.elProperty.id].iZZ
                     }
                     self.elPropertyStore.ixxText = ""
                    
                     var iyytemp = Double(self.elPropertyStore.iyyText)
                     if  iyytemp == nil {
                         iyytemp = self.elPropertyStore.elProperties[self.elProperty.id].iYY
                     }
                    self.elPropertyStore.iyyText = ""
                    
                    var ixytemp = Double(self.elPropertyStore.ixyText)
                    if  ixytemp == nil {
                        ixytemp = self.elPropertyStore.elProperties[self.elProperty.id].iXY
                    }
                    self.elPropertyStore.ixyText = ""
                    
                    var ijtemp = Double(self.elPropertyStore.ijText)
                    if  ijtemp == nil {
                        ijtemp = self.elPropertyStore.elProperties[self.elProperty.id].iJ
                    }
                    self.elPropertyStore.ijText = ""
                
                     let newElProperty = ElProperty(id: self.elProperty.id, area: areatemp!, iZZ: izztemp!, iYY: iyytemp!, iXY: ixytemp!, iJ: ijtemp!)
                     self.elPropertyStore.changeProperties(elProperty: newElProperty)
                     self.elPropertyStore.printElProperties()
 */
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
