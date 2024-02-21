//
//  NodeList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct NodeList : View {
    
    @Binding var scene: ModelScene
    @Bindable var nodesStore : NodesStore
    @Bindable var truss2DStore: Truss2DStore
    @Bindable var frame2DStore: Frame2DStore
    @Bindable var truss3DStore: Truss3DStore
    @Bindable var frame3DStore: Frame3DStore
    @Bindable var dispStore: DispStore
    @Bindable var bcStore: BCStore
    @Bindable var loadStore: LoadStore
    
    @Environment(\.presentationMode) private var presentationMode

    @State var showNodeView: Bool = false
    
//    @State var isEditing: Bool = true
    
    var body: some View {
        
        NavigationStack {
            
            VStack {

                
                List {
                    
                    ForEach(nodesStore.nodes) {node in
                        NavigationLink(destination: NodeView(scene: $scene, node: node, nodesStore: self.nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore))
                        {
                            NodeRow(node: node)
                        }
                    }.onDelete(perform: delete)
                }// List
                .navigationBarItems(
                        leading: Button("+") {
//                            showNodeView.toggle()
                            let newNode = Node(id: self.nodesStore.nodes.count, xcoord: 0, ycoord: 0, zcoord: 0)
                            self.nodesStore.addNode(node: newNode)
//                            scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                            
                    }
                    .padding()
                    .foregroundColor(Color.blue)
                    .font(.title)
//                    ,trailing: EditButton()
                )
                    
                    .navigationBarTitle("Nodes").font(.largeTitle)
                

                
                Spacer()

            }// VStack
            .sheet(isPresented: $showNodeView) {
            
                let newNode = Node(id: nodesStore.nodes.count)
                
                NodeView(scene: $scene, node: newNode, nodesStore: self.nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore)
                    
            }
  
                
        }
    }
        

    

    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            nodesStore.nodes.remove(at: first)
        }
        
//        nodesStore.numNodes -= 1
       
        if nodesStore.nodes.count > 0{
            for index in 0...nodesStore.nodes.count - 1{
                nodesStore.nodes[index].id = index
            }
        }
        
        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)

    }
}
        
#Preview(traits: .landscapeLeft) {
    ContentView()
}
/*
 #if DEBUG
 struct NodeList_Previews : PreviewProvider {
 static var previews: some View {
 NodeList(nodesStore: NodesStore())
 }
 }
 #endif
 */
