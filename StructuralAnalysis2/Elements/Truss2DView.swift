//
//  OneDView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/2/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Truss2DView: View {
    
    @Binding var scene: ModelScene
    var truss2d: Truss2D
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
            Text("Truss2D Element Detail").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                HStack{
                    Text("MatID:")
                    TextField("\(truss2d.matID)", value: $localMatID, format: .number)
                }.padding()
                HStack {
                    Text("PropertyID:")
                    TextField("\(truss2d.propertiesID)", value: $localPropID, format: .number)
                }
                HStack {
                    Text("Node1:")
                    TextField("\(truss2d.node1)", value: $localNode1, format: .number)
                }
                HStack {
                    Text("Node2:")
                    TextField("\(truss2d.node2)", value: $localNode2, format: .number)
                }
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                .font(.custom("Arial", size: 20))
            
            HStack {
                Spacer()
                Button (action: {

                    
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
                        let newTruss2D = Truss2D(id: self.truss2d.id, matID: localMatID!, propertiesID: localPropID!, node1: localNode1!, node2: localNode2!, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, truss2DStore: self.truss2DStore)
                        
                        //                     self.truss2DStore.changeTruss2D(element: newTruss2D)
                        self.truss2DStore.addTruss2DEl(element: newTruss2D)
                        // MARK: -                           ReDraw entire model
                        scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                        isEditing.toggle()
                    } else {
                        // MARK: - Make changes to existing node
//                        print("truss Id: \(truss2d.id)")
                        if localMatID == nil {
                            localMatID = truss2d.matID
                        }
                        if localPropID == nil {
                            localPropID = truss2d.propertiesID
                        }
                        if localNode1 == nil {
                            localNode1 = truss2d.node1
                        }
                        if localNode2 == nil {
                            localNode2 = truss2d.node2
                        }

                        truss2DStore.truss2DElements[truss2d.id].matID = localMatID!
                        truss2DStore.truss2DElements[truss2d.id].propertiesID = localPropID!
                        truss2DStore.truss2DElements[truss2d.id].node1 = localNode1!
                        truss2DStore.truss2DElements[truss2d.id].node2 = localNode2!
                        // MARK: -                           ReDraw entire model

                        scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }
//                    self.truss2DStore.printConnectivity()
                    
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

//#if DEBUG
//struct OneDView_Previews: PreviewProvider {
//    static var previews: some View {
//        Truss2DView(truss2d: Truss2D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 0, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), truss2DStore: Truss2DStore() ), truss2DStore: Truss2DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore() , isEditing: .constant(true))
//    }
//}
//#endif
