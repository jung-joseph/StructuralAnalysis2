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
                    if localMatID != nil {
                        truss3DStore.truss3DElements[truss3d.id].matID = localMatID!
                    }
                    if localPropID != nil {
                        truss3DStore.truss3DElements[truss3d.id].propertiesID = localPropID!

                    }
                    if localNode1 != nil {
                        truss3DStore.truss3DElements[truss3d.id].node1 = localNode1!

                    }
                    if localNode2 != nil {
                        truss3DStore.truss3DElements[truss3d.id].node2 = localNode2!

                    }
                    
                    let node1 = nodesStore.nodes[truss3DStore.truss3DElements[truss3d.id].node1]
                    let node2 = nodesStore.nodes[truss3DStore.truss3DElements[truss3d.id].node2]
                    truss3DStore.truss3DElements[truss3d.id].length = elementLength(node1: node1, node2: node2)
                    
                    // MARK: -                           ReDraw entire model
                    scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)


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


