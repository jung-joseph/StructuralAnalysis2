//
//  Truss3DView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/5/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Truss3DView: View {
    
    var truss3d: Truss3D
    @Bindable var truss3DStore: Truss3DStore
    @Bindable var nodesStore: NodesStore
    @Bindable var materialStore: MaterialStore
    @Bindable var elPropertyStore: ElPropertyStore
    
    @Environment(\.presentationMode) private var showDetail

    
    var body: some View {
        
        VStack {
            Text("Truss3D Element Detail").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                HStack{
                    Text("MatID:").font(.custom("Arial", size: 20))
                    TextField("\(truss3d.matID)", text: $truss3DStore.matIDText).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                HStack {
                    Text("PropertyID:").font(.custom("Arial", size: 20))
                    TextField("\(truss3d.propertiesID)", text: $truss3DStore.propertyIDText).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                HStack {
                    Text("Node1:").font(.custom("Arial", size: 20))
                    TextField("\(truss3d.node1)", text: $truss3DStore.node1Text).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                HStack {
                    Text("Node:").font(.custom("Arial", size: 20))
                    TextField("\(truss3d.node2)", text: $truss3DStore.node2Text).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
            }
            
            HStack {
                Spacer()
                Button (action: {
                     var matIDtemp = Int(self.truss3DStore.matIDText)
                     if  matIDtemp == nil {
                         matIDtemp = self.truss3d.matID
                     }
                    self.truss3DStore.matIDText = ""
                     
                     var proptemp = Int(self.truss3DStore.propertyIDText)
                     if  proptemp == nil {
                         proptemp = self.truss3d.propertiesID
                     }
                     self.truss3DStore.propertyIDText = ""
                    
                     var node1temp = Int(self.truss3DStore.node1Text)
                     if  node1temp == nil {
                         node1temp = self.truss3d.node1
                     }
                    self.truss3DStore.node1Text = ""
                     
                     var node2temp = Int(self.truss3DStore.node2Text)
                     if  node2temp == nil {
                         node2temp = self.truss3d.node2
                     }
                    self.truss3DStore.node2Text = ""

                    let newTruss3D = Truss3D(id: self.truss3d.id, matID: matIDtemp!, propertiesID: proptemp!, node1: node1temp!, node2: node2temp!, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, truss3DStore: self.truss3DStore)
                     self.truss3DStore.changeTruss3D(element: newTruss3D)
                     self.truss3DStore.printConnectivity()
                    
                    self.showDetail.wrappedValue.dismiss()

                     
                 }) { Text ("Save Changes")}
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                Spacer()

            }
            Spacer()

        } // VStack
    }
}

#if DEBUG
struct Truss3DView_Previews: PreviewProvider {
    static var previews: some View {
        Truss3DView(truss3d: Truss3D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 0, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), truss3DStore: Truss3DStore()),truss3DStore: Truss3DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore() )
    }
}
#endif
