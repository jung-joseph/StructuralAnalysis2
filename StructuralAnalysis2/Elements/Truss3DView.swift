//
//  Truss3DView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/5/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Truss3DView: View {
    
    @Binding var scene: ModelScene
    var truss3d: Truss3D
    @Bindable var nodesStore : NodesStore
    @Bindable var truss2DStore: Truss2DStore
    @Bindable var frame2DStore: Frame2DStore
    @Bindable var truss3DStore: Truss3DStore
    @Bindable var frame3DStore: Frame3DStore
    @Bindable var dispStore: DispStore
    @Bindable var bcStore: BCStore
    @Bindable var loadStore: LoadStore
    @Bindable var materialStore: MaterialStore
    @Bindable var elPropertyStore: ElPropertyStore
    
    @Binding var isEditing: Bool
    
    @Environment(\.presentationMode) private var showDetail

    @State private var localMatID: Int?
    @State private var localPropID: Int?
    @State private var localNode1: Int?
    @State private var localNode2: Int?
    
    var body: some View {
        
        VStack {
            Text("Truss3D Element Detail").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                HStack{
                    Text("MatID:")
                    TextField("\(truss3d.matID)", value: $localMatID, format: .number)
                }
                HStack {
                    Text("PropertyID:")
                    TextField("\(truss3d.propertiesID)", value: $localPropID, format: .number)
                }
                HStack {
                    Text("Node1:")
                    TextField("\(truss3d.node1)", value: $localNode1, format: .number)
                }
                HStack {
                    Text("Node2:")
                    TextField("\(truss3d.node2)", value: $localNode2, format: .number)
                }
            }.textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .font(.custom("Arial", size: 20))
            
            HStack {
                Spacer()
                Button (action: {
                    /*
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
*/
                    //MARK: - Add new element
                    if !isEditing{
                        if localMatID == nil {
                            localMatID = 0
                        }
                        if localPropID == nil {
                            localPropID = 0
                        }
                        if localNode1 == nil {
                            localNode1 = 0
                        }
                        if localNode2 == nil {
                            localNode2 = 0
                        }
                        
                        let newTruss3D = Truss3D(id: self.truss3d.id, matID: localMatID!, propertiesID: localPropID!, node1: localNode1!, node2: localNode2!, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, truss3DStore: self.truss3DStore)
                        
//                        self.truss3DStore.changeTruss3D(element: newTruss3D)
                        self.truss3DStore.addTruss3DEl(element: newTruss3D)
                        // MARK: -                           ReDraw entire model
                        scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                        isEditing.toggle()
                    } else {
                        // MARK: - Make changes to existing element
 
                        if localMatID == nil {
                            localMatID = truss3d.matID
                        }
                        if localPropID == nil {
                            localPropID = truss3d.propertiesID
                        }
                        if localNode1 == nil {
                            localNode1 = truss3d.node1
                        }
                        if localNode2 == nil {
                            localNode2 = truss3d.node2
                        }

                        truss3DStore.truss3DElements[truss3d.id].matID = localMatID!
                        truss3DStore.truss3DElements[truss3d.id].propertiesID = localPropID!
                        truss3DStore.truss3DElements[truss3d.id].node1 = localNode1!
                        truss3DStore.truss3DElements[truss3d.id].node2 = localNode2!
                        // MARK: -                           ReDraw entire model

                        scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }
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


