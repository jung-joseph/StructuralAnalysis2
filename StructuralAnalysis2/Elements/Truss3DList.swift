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
    @Bindable var truss3DStore : Truss3DStore
    @Bindable var nodesStore : NodesStore
    @Bindable var materialStore : MaterialStore
    @Bindable var elPropertyStore : ElPropertyStore
    
    @Environment(\.presentationMode) private var presentationMode

    
    var body: some View {
        
        NavigationView {
            
            VStack {
                List {

                    ForEach(truss3DStore.truss3DElements) {truss3D in
                        NavigationLink(destination: Truss3DView(truss3d: truss3D, truss3DStore: self.truss3DStore, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore)){
                            Truss3DElementRow(truss3DEl: truss3D)
                        }
                    }.onDelete(perform: delete)
                    
                }
                .navigationBarItems(
                
                leading: Button("+") {
                    let newTruss3d = Truss3D(id: self.truss3DStore.numTruss3DElements, matID: 0, propertiesID: 0, node1: 0, node2: 0, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, truss3DStore: Truss3DStore())
                    self.truss3DStore.node1Text = "0"
                    self.truss3DStore.node2Text = "0"
                    self.truss3DStore.addTruss3DEl(element: newTruss3d)
                }
                .padding()
                .foregroundColor(Color.blue)
                .font(.title)
                
                ,trailing: EditButton())

                .navigationBarTitle("Truss 3D Elements").font(.largeTitle)


                Spacer()
                
                
                
            }
            
            
        } // Nav View
    }// View
    
    
//    func dismiss(){
//        self.presentationMode.value.dismiss()
//    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            truss3DStore.truss3DElements.remove(at: first)
        }
        
        truss3DStore.numTruss3DElements -= 1
       
        if truss3DStore.truss3DElements.count > 0 {
            for index in 0...truss3DStore.truss3DElements.count - 1{
                truss3DStore.truss3DElements[index].id = index
            }
        }
        
    }
}
//#Preview(traits: .landscapeLeft) {
//    Truss3DList(truss3DStore: Truss3DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore())
//}

