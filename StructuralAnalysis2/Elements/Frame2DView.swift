//
//  Frame2DView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/26/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Frame2DView: View {
    
    @Binding var scene: ModelScene
    var frame2d: Frame2D
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
    
//    @Binding var isEditing: Bool
    @Binding var node1IsOn:Bool
    @Binding var node2IsOn:Bool
    
    @Environment(\.presentationMode) private var showDetail
    


    @State private var localMatID: Int?
    @State private var localPropID: Int?
    @State private var localNode1: Int?
    @State private var localNode2: Int?
    
    var body: some View {
        
        VStack {
            Text("Frame2D Element Detail").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                HStack{
                    Text("MatID:").font(.custom("Arial", size: 20))
                    TextField("\(frame2d.matID)", value: $localMatID, format: .number)
                }
                HStack {
                    Text("PropertyID:").font(.custom("Arial", size: 20))
                    TextField("\(frame2d.propertiesID)", value: $localPropID, format: .number)
                }
                HStack {
                    Text("Node1:").font(.custom("Arial", size: 20))
                    TextField("\(frame2d.node1)", value: $localNode1, format: .number)
                    Toggle(isOn: $node1IsOn) {
                        Text("Pin End").font(.custom("Arial", size: 20))
                        if node1IsOn {
                            Text("ON").font(.custom("Arial", size: 20))
                        }
                        
                    }
                }
                
                HStack {
                    Text("Node2:")
                    TextField("\(frame2d.node2)", value: $localNode2, format: .number)
//                    Spacer()
                    Toggle(isOn: $node2IsOn) {
                        Text("Pin End").font(.custom("Arial", size: 20))
                        if node2IsOn {
                            Text("ON").font(.custom("Arial", size: 20))
                        }

                    }
                }
                
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                .font(.custom("Arial", size: 20))
            
            HStack {
                Spacer()
                Button (action: {
                    
                    if localMatID != nil {
                        frame2DStore.frame2DElements[frame2d.id].matID = localMatID!
                    }
                    if localPropID != nil {
                        frame2DStore.frame2DElements[frame2d.propertiesID].matID = localPropID!

                    }
                    if localNode1 != nil {
                        frame2DStore.frame2DElements[frame2d.id].node1 = localNode1!

                    }
                    if localNode2 != nil {
                        frame2DStore.frame2DElements[frame2d.id].node2 = localNode2!

                    }
                    let node1 = nodesStore.nodes[frame2DStore.frame2DElements[frame2d.id].node1]
                    let node2 = nodesStore.nodes[frame2DStore.frame2DElements[frame2d.id].node2]
                    frame2DStore.frame2DElements[frame2d.id].length = elementLength(node1: node1, node2: node2)

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
//struct Frame2DView_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var bind = false
//        Frame2DView(frame2d: Frame2D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 0, pin1: false, pin2: false, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), frame2DStore: Frame2DStore() ), frame2DStore: Frame2DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), node1IsOn: $bind, node2IsOn: $bind )
//    }
//}
//#endif
