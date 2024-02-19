//
//  NodeView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct NodeView : View {
    
    @Binding var scene: ModelScene
    var node: Node
    @Bindable var nodesStore : NodesStore
    @Bindable var truss2DStore: Truss2DStore
    @Bindable var frame2DStore: Frame2DStore
    @Bindable var truss3DStore: Truss3DStore
    @Bindable var frame3DStore: Frame3DStore
    @Bindable var dispStore: DispStore
    @Bindable var bcStore: BCStore
    @Bindable var loadStore: LoadStore
    
//    @Binding var isEditing: Bool
    
    @Environment(\.presentationMode) private var showDetail

    @State private var localX: Double?
    @State private var localY: Double?
    @State private var localZ: Double?
    

    var body: some View {
        
        VStack{
            Text("NODE DETAIL").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                Text("ID: \(node.id)").font(.custom("Arial", size: 20))
                HStack {
                    Text("X:")
                    TextField("\(node.xcoord)", value:  $localX, format:.number)
                        
                }.font(.custom("Arial", size: 20))
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                HStack {
                    Text("Y:")
                    TextField("\(node.ycoord)", value:  $localY, format:.number)

                }.font(.custom("Arial", size: 20))
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                HStack {
                    Text("Z:")
                    TextField("\(node.zcoord)", value:  $localZ, format:.number)

                }.font(.custom("Arial", size: 20))
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                
                HStack{
                    Spacer()
                    
                    Button (action: {
                        
                        if localX != nil {
                            nodesStore.nodes[node.id].xcoord = localX!
                        }
                        if localY != nil {
                            nodesStore.nodes[node.id].ycoord = localY!
                        }
                        if localZ != nil {
                            nodesStore.nodes[node.id].zcoord = localZ!
                        }
                        // MARK: -                           ReDraw entire model
                                                    scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                   

                        self.showDetail.wrappedValue.dismiss()
                        
                        
                    }) { Text ("Save Changes")}
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    Spacer()
                }

                
            }
            Spacer()
            
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
/*
#if DEBUG
struct NodeView_Previews : PreviewProvider {
    static var previews: some View {
        NodeView(node: Node(id: 0), nodesStore: NodesStore() )
    }
}
#endif
*/

