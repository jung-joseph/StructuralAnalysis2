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
                    if localMatID != nil {
                        truss2DStore.truss2DElements[truss2d.id].matID = localMatID!
                    }
                    if localPropID != nil {
                        truss2DStore.truss2DElements[truss2d.propertiesID].matID = localPropID!
                        
                    }
                    if localNode1 != nil {
                        truss2DStore.truss2DElements[truss2d.id].node1 = localNode1!
 
                    }
                    if localNode2 != nil {
                        truss2DStore.truss2DElements[truss2d.id].node2 = localNode2!

                    }
                    
                    let node1 = nodesStore.nodes[truss2DStore.truss2DElements[truss2d.id].node1]
                    let node2 = nodesStore.nodes[truss2DStore.truss2DElements[truss2d.id].node2]
                    truss2DStore.truss2DElements[truss2d.id].length = elementLength(node1: node1, node2: node2)
                    
                    // MARK: -                           ReDraw entire model
                    
                    scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    
                    
                    
                    
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
            
            
        }
        
    } // VStack
}

func elementLength(node1:Node, node2:Node) -> Double {
    let dx = node2.xcoord - node1.xcoord
    let dy = node2.ycoord - node1.ycoord
    let dz = node2.zcoord - node1.zcoord
    return sqrt(dx * dx + dy * dy + dz * dz)
}

//#if DEBUG
//struct OneDView_Previews: PreviewProvider {
//    static var previews: some View {
//        Truss2DView(truss2d: Truss2D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 0, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), truss2DStore: Truss2DStore() ), truss2DStore: Truss2DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore() , isEditing: .constant(true))
//    }
//}
//#endif
