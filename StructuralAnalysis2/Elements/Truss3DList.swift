//
//  Truss3DList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/5/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Combine
import SwiftUI


struct Truss3DList: View {

//    @Binding var dismissFlag: Bool
    @Binding var scene: ModelScene
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
    
    @Environment(\.presentationMode) private var presentationMode

    @State var showTruss3DView: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                List {

                    ForEach(truss3DStore.truss3DElements) {truss3D in
                        NavigationLink(destination: Truss3DView(scene: $scene, truss3d: truss3D, nodesStore: self.nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore)){
                            Truss3DElementRow(truss3DEl: truss3D)
                        }
                    }.onDelete(perform: delete)
                    
                }
                .navigationBarItems(
                
                leading: Button("+") {
                    let newTruss3d = Truss3D(id: self.truss3DStore.truss3DElements.count, matID: 0, propertiesID: 0, node1: 0, node2: 0, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, truss3DStore: truss3DStore)
                    
                    self.truss3DStore.addTruss3DEl(element: newTruss3d)

                    
                    
                   

                }
                .padding()
                .foregroundColor(Color.blue)
                .font(.title)
                
                ,trailing: EditButton())

                .navigationBarTitle("Truss 3D Elements").font(.largeTitle)


                Spacer()
                
                
                
            }
//            .sheet(isPresented: $showTruss3DView) {
//                let newTruss3d = Truss3D(id: self.truss3DStore.truss3DElements.count, matID: 0, propertiesID: 0, node1: 0, node2: 0, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, truss3DStore: truss3DStore)
//                
//                Truss3DView(scene: $scene,  truss3d: newTruss3d, nodesStore: nodesStore, truss2DStore: truss2DStore,frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore)
//            }
            
        } // Nav View
    }// View
    
    
//    func dismiss(){
//        self.presentationMode.value.dismiss()
//    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            truss3DStore.truss3DElements.remove(at: first)
        }
        
//        truss3DStore.numTruss3DElements -= 1
       
        if truss3DStore.truss3DElements.count > 0 {
            for index in 0...truss3DStore.truss3DElements.count - 1{
                truss3DStore.truss3DElements[index].id = index
            }
        }
        scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
        
    }
}
//#Preview(traits: .landscapeLeft) {
//    Truss3DList(truss3DStore: Truss3DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore())
//}

