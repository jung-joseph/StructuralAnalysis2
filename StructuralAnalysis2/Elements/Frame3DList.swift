//
//  Frame3DList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/8/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Frame3DList: View {

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

    @State var showFrame3DView: Bool = false
    @State var node1IsOn:Bool = false
    @State var node2IsOn:Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
             

                
                List {
                    
                    ForEach(frame3DStore.frame3DElements) {frame3D in
                        NavigationLink(destination: Frame3DView(scene: $scene, frame3d: frame3D, nodesStore: self.nodesStore, truss2DStore: truss2DStore, frame2DStore: self.frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore,bcStore: bcStore, loadStore: loadStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, node1IsOn: $node1IsOn, node2IsOn: $node2IsOn)) {
                            Frame3DElementRow(frame3DEl: frame3D)

                        }
                    }.onDelete(perform: delete)
                }
                .navigationBarItems(
                
                leading: Button("+") {
//                    showFrame3DView.toggle()
                    let newFrame3d = Frame3D(id: self.frame3DStore.frame3DElements.count, matID: 0, propertiesID: 0, node1: 0, node2: 0,pin1: false, pin2: false, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, frame3DStore: frame3DStore)
                    self.frame3DStore.addFrame3DEl(element: newFrame3d)
                    /*
                    let newFrame3d = Frame3D(id: self.frame3DStore.numFrame3DElements, matID: 0, propertiesID: 0, node1: 0, node2: 0,pin1: false, pin2: false, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, frame3DStore: Frame3DStore())
                    self.frame3DStore.node1Text = "0"
                    self.frame3DStore.node2Text = "0"
                    self.frame3DStore.addFrame3DEl(element: newFrame3d)
                     */
                }
                .padding()
                .foregroundColor(Color.blue)
                .font(.title)
                
                ,trailing: EditButton())

                .navigationBarTitle("Frame 3D Elements").font(.largeTitle)


                Spacer()
                
            }
            .sheet(isPresented: $showFrame3DView) {
                let newFrame3D = Frame3D(id: self.frame3DStore.frame3DElements.count, matID: 0, propertiesID: 0, node1: 0, node2: 0, pin1: false, pin2: false, nodesStore: nodesStore, materialStore: materialStore, elPropertyStore: elPropertyStore, frame3DStore: frame3DStore)
                
                Frame3DView(scene: $scene, frame3d: newFrame3D, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore,  node1IsOn: $node1IsOn, node2IsOn: $node2IsOn)
            }
        } // Nav View
    }// View
    
    
//    func dismiss(){
//        self.presentationMode.value.dismiss()
//    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            frame3DStore.frame3DElements.remove(at: first)
        }
        
//        frame3DStore.numFrame3DElements -= 1
       
        if frame3DStore.frame3DElements.count > 0 {
            for index in 0...frame3DStore.frame3DElements.count - 1{
                frame3DStore.frame3DElements[index].id = index
            }
        }
        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
    }
}

//#if DEBUG
//struct Frame3DList_Previews: PreviewProvider {
//    static var previews: some View {
//        Frame3DList(frame3DStore: Frame3DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore())
//    }
//}
//#endif
