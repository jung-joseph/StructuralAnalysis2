//
//  OneDList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/2/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Truss2DList: View {

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

    @State var showTruss2DView: Bool = false
    @State var isEditing:Bool = true
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                List {

                    ForEach(truss2DStore.truss2DElements) {truss2D in
                        
                        NavigationLink(destination: Truss2DView(scene: $scene, truss2d: truss2D, nodesStore: self.nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore, isEditing: $isEditing))
                        {
                            Truss2DElementRow(truss2DEl: truss2D)
                        }
                        
                        
                       

                    }.onDelete(perform: delete)
                    
                }
                .navigationBarItems(
                
                leading: Button("+") {
                    showTruss2DView.toggle()
                    isEditing = false

                }
                .padding()
                .foregroundColor(Color.blue)
                .font(.title)
                
                ,trailing: EditButton())
                .navigationBarTitle("Truss 2D Elements").font(.largeTitle)


                Spacer()
                
                
                
            }
            .sheet(isPresented: $showTruss2DView) {
                let newTruss2d = Truss2D(id: self.truss2DStore.truss2DElements.count, matID: 0, propertiesID: 0, node1: 0, node2: 0, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, truss2DStore: truss2DStore)
                
                Truss2DView(scene: $scene,  truss2d: newTruss2d, nodesStore: nodesStore, truss2DStore: truss2DStore,frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore, isEditing: $isEditing)
                
                
            }
            
            
        } // Nav View
    }// View
    
    
//    func dismiss(){
//        self.presentationMode.value.dismiss()
//    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            truss2DStore.truss2DElements.remove(at: first)
        }
        
//        truss2DStore.numTruss2DElements -= 1
       
        if truss2DStore.truss2DElements.count > 0 {
            for index in 0...truss2DStore.truss2DElements.count - 1{
                truss2DStore.truss2DElements[index].id = index
            }
        }
        scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
        
    }
}
//#Preview(traits: .landscapeLeft) {
//    Truss2DList(truss2DStore: Truss2DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore())
//}
/*
#if DEBUG
struct OneDList_Previews: PreviewProvider {
    static var previews: some View {
        Truss2DList(truss2DStore: Truss2DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore())
    }
}
#endi*/
