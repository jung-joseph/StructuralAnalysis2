//
//  LoadList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/16/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct LoadList: View {
    
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
    
    @State var showLoadsView: Bool = false
    
    var body: some View {
        
        NavigationStack {
        
            VStack {
                
                List {
                    
                    ForEach(loadStore.loads) {load in
                        NavigationLink(destination: LoadView(scene: $scene, load: load, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore)) {
                            LoadRow(load: load)
                        }
                    }.onDelete(perform: delete)
                } //List
                    .navigationBarItems(
                    
                    leading: Button("+") {
                        
                        let newLoad = Load(id:loadStore.loads.count,loadNode: 0, loadDirection: 0, loadValue: 0.0)
                        self.loadStore.addLoad(load: newLoad)
                        

                    }
                    .padding()
                    .foregroundColor(Color.blue)
                    .font(.title)
                    
                    )
                    
                    .navigationBarTitle("Loads").font(.largeTitle)

                
                Spacer()
                
                
                
            } //VStack
//            .sheet(isPresented: $showLoadsView){
//                let newLoad = Load(id:loadStore.loads.count,loadNode: 0, loadDirection: 0, loadValue: 0.0)
//                LoadView(scene: $scene, load: newLoad, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, isEditing: $isEditing)
//            }
            
        } // NavigationView
    } // body
    
//    func dismiss(){
//        self.presentationMode.value.dismiss()
//    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            loadStore.loads.remove(at: first)
        }
        
        //        loadStore.numLoads -= 1
        
        if loadStore.loads.count > 0{
            for index in 0...loadStore.loads.count - 1{
                loadStore.loads[index].id = index
            }
        }
    }
    
    
    
    
}

//#Preview(traits: .landscapeLeft) {
//    LoadList(loadStore: LoadStore())
//}

/*
 #if DEBUG
 struct LoadList_Previews: PreviewProvider {
 static var previews: some View {
 LoadList(loadStore: LoadStore())
 }
 }
 #endif
 */
