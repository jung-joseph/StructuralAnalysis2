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
    @Environment(\.presentationMode) private var showDetail

    
    var body: some View {
        VStack {
            Text("ELEMENT PROPERTY DETAIL").font(.custom("Arial", size: 25))
          
            VStack(alignment: .leading) {
                Text("ID: \(elProperty.id)").font(.custom("Arial", size: 20))
                HStack {
                    Text("Area:").font(.custom("Arial", size: 20))
                    TextField("\(elProperty.area)", text:
                        $elPropertyStore.areaText).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                HStack {
                    Text("Izz:").font(.custom("Arial", size: 20))
                    TextField("\(elProperty.iZZ)", text:
                        $elPropertyStore.ixxText).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                HStack {
                    Text("Iyy:").font(.custom("Arial", size: 20))
                    TextField("\(elProperty.iYY)", text:
                        $elPropertyStore.iyyText).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                HStack {
                    Text("Ixy:").font(.custom("Arial", size: 20))
                    TextField("\(elProperty.iXY)", text:
                        $elPropertyStore.ixyText).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                HStack {
                    Text("IJ:").font(.custom("Arial", size: 20))
                    TextField("\(elProperty.iJ)", text:
                        $elPropertyStore.ijText).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
          }
            HStack {
                Spacer()
                 Button (action: {
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

#if DEBUG
struct ElPropertyView_Previews: PreviewProvider {
    static var previews: some View {
        ElPropertyView(elProperty: ElProperty(id: 0), elPropertyStore: ElPropertyStore())
    }
}
#endif
