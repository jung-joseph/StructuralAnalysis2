//
//  BCList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct BCList: View {
    
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
    
    @State var showBCView: Bool = false
//    @State var isEditing: Bool = true
    
    var body: some View {
        
        NavigationStack {
        
            VStack {
                
                List {
                    
                    ForEach(bcStore.bcs) {bc in
                        NavigationLink(destination: BCView(scene: $scene, bc: bc, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore)) {
                            BCRow(bc: bc)
                        }
                    }.onDelete(perform: delete)
                } //List
                    .navigationBarItems(
                    
                    leading: Button("+") {
                        let newBC = BC(id: self.bcStore.bcs.count,bcNode: 0, bcDirection: 0, bcValue: 0)
                        self.bcStore.addBC(bc: newBC)

//                        showBCView.toggle()
                        
//                        isEditing = false
//                        let newBC = BC(id:self.bcStore.numBCs,bcNode: 0, bcDirection: 0, bcValue: 0)
//                        self.bcStore.bcNodeText = "0"
//                        self.bcStore.bcDirectionText = "X"
//                        self.bcStore.bcValueText = "0"
//                        self.bcStore.addBC(bc: newBC)
                    }
                    .padding()
                    .foregroundColor(Color.blue)
                    .font(.title)
                    
//                    ,trailing: EditButton()
                    )
                
                    .navigationBarTitle("Boundary Conditions").font(.largeTitle)

                
                Spacer()
                
                
                
            } //VStack
            .sheet(isPresented: $showBCView){
                let newBc = BC(id: bcStore.bcs.count, bcNode: 0, bcDirection: 0, bcValue: 0.0)
                
                BCView(scene: $scene, bc: newBc, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore)
            }
            
        } // NavigationView
    } // body
    

    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            bcStore.bcs.remove(at: first)
        }
        
        //        bcStore.numBCs -= 1
        
        if bcStore.bcs.count > 0{
        for index in 0...bcStore.bcs.count - 1{
            bcStore.bcs[index].id = index
        }
    }
        
        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)

    }
    
    
    
    
}
//#Preview(traits: .landscapeLeft) {
//    BCList(bcStore: BCStore())
//}
///*
//#if DEBUG
//struct BCList_Previews: PreviewProvider {
//    static var previews: some View {
//        BCList(bcStore: BCStore())
//    }
//}
//#endif
//*/
