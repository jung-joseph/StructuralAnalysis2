//
//  Frame3DView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/8/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Frame3DView: View {
    
    @Binding var scene: ModelScene
    var frame3d: Frame3D
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
    
    @Binding var node1IsOn:Bool
    @Binding var node2IsOn:Bool
    
    @Environment(\.presentationMode) private var showDetail


    @State private var localMatID: Int?
    @State private var localPropID: Int?
    @State private var localNode1: Int?
    @State private var localNode2: Int?
    
    var body: some View {
        
        VStack {
            Text("Frame3D Element Detail").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                HStack{
                    Text("MatID:")
                    TextField("\(frame3d.matID)", value: $localMatID, format: .number)
                }
                HStack {
                    Text("PropertyID:")
                    TextField("\(frame3d.propertiesID)", value: $localPropID, format: .number)
                }
                HStack {
                    Text("Node1:")
                    TextField("\(frame3d.node1)", value: $localNode1, format: .number)
//                    Spacer()
                    Toggle(isOn: $node1IsOn) {
                        Text("Pin End")
                        if node1IsOn {
                            Text("ON")
                        }
//                        frame2DStore.frame2DElements[frame2d.id].pin1 = true
                        
                    }
                }
                HStack {
                    Text("Node2:")
                    TextField("\(frame3d.node2)", value: $localNode2, format: .number)
//                    Spacer()
                    Toggle(isOn: $node2IsOn) {
                        Text("Pin End")
                        if node2IsOn {
                            Text("ON")
                        }
//                        frame2DStore.frame2DElements[frame2d.id].pin2 = true

                    }
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .font(.custom("Arial", size: 20))
            
            HStack {
                Spacer()
                Button (action: {
                    
                    
                    if localMatID != nil {
                        frame3DStore.frame3DElements[frame3d.id].matID = localMatID!
                    }
                    if localPropID != nil {
                        frame3DStore.frame3DElements[frame3d.propertiesID].matID = localPropID!

                    }
                    if localNode1 != nil {
                        frame3DStore.frame3DElements[frame3d.id].node1 = localNode1!

                    }
                    if localNode2 != nil {
                        frame3DStore.frame3DElements[frame3d.id].node2 = localNode2!

                    }
                    let node1 = nodesStore.nodes[frame3DStore.frame3DElements[frame3d.id].node1]
                    let node2 = nodesStore.nodes[frame3DStore.frame3DElements[frame3d.id].node2]
                    frame3DStore.frame3DElements[frame3d.id].length = elementLength(node1: node1, node2: node2)
                    // MARK: -                           ReDraw entire model
                    
                    scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                

                    self.showDetail.wrappedValue.dismiss()

                     
                 }) { Text ("Save Changes")}
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(CGFloat(10))
                    .shadow(radius: CGFloat(10))
                
                Spacer()

            }
            Spacer()

        } // VStack
    }
}

//#if DEBUG
//struct Frame3DView_Previews: PreviewProvider {
//    @State var bind = false
//
//    static var previews: some View {
//        Frame3DView(frame3d: Frame3D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 0, pin1: false, pin2: false, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), frame3DStore: Frame3DStore() ), frame3DStore: Frame3DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), node1IsOn: bind, node2IsOn: bind )
//    }
//}
//#endif

