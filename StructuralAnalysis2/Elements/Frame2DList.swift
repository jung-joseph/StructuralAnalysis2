//
//  Frame2DList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/26/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Frame2DList: View {

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
    
    @State var showFrame2DView: Bool = false
//    @State var isEditing:Bool = true
    @State var node1IsOn:Bool = false
    @State var node2IsOn:Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
             

                
                List {
                    
                    ForEach(frame2DStore.frame2DElements) {frame2D in
                        NavigationLink(destination: Frame2DView(scene: $scene, frame2d: frame2D, nodesStore: self.nodesStore, truss2DStore: truss2DStore, frame2DStore: self.frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore,bcStore: bcStore, loadStore: loadStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, node1IsOn: $node1IsOn, node2IsOn: $node2IsOn)){
                            Frame2DElementRow(frame2DEl: frame2D)
                        }
                    }.onDelete(perform: delete)
                }
                .navigationBarItems(
                
                leading: Button("+") {
                    let newFrame2d = Frame2D(id: self.frame2DStore.frame2DElements.count, matID: 0, propertiesID: 0, node1: 0, node2: 0,pin1: false, pin2: false, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, frame2DStore: frame2DStore)
                    self.frame2DStore.addFrame2DEl(element: newFrame2d)
                    
//                    showFrame2DView.toggle()
//                    isEditing = false
                    /*
                    let newFrame2d = Frame2D(id: self.frame2DStore.frame2DElements.count, matID: 0, propertiesID: 0, node1: 0, node2: 0,pin1: false, pin2: false, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, frame2DStore: Frame2DStore())
                    self.frame2DStore.node1Text = "0"
                    self.frame2DStore.node2Text = "0"
                    self.frame2DStore.addFrame2DEl(element: newFrame2d)
                     */
                }
                .padding()
                .foregroundColor(Color.blue)
                .font(.title)
                
//                ,trailing: EditButton()
                )

                .navigationBarTitle("Frame 2D Elements").font(.largeTitle)


                Spacer()
                
                
                
            }
            .sheet(isPresented: $showFrame2DView) {
                let newFrame2D = Frame2D(id: self.frame2DStore.frame2DElements.count, matID: 0, propertiesID: 0, node1: 0, node2: 0, pin1: false, pin2: false, nodesStore: nodesStore, materialStore: materialStore, elPropertyStore: elPropertyStore, frame2DStore: frame2DStore)
                
                Frame2DView(scene: $scene, frame2d: newFrame2D, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore, node1IsOn: $node1IsOn, node2IsOn: $node2IsOn)
            }
            
        } // Nav View
    }// View
    
    
//    func dismiss(){
//        self.presentationMode.value.dismiss()
//    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            frame2DStore.frame2DElements.remove(at: first)
        }
        
        //        frame2DStore.numFrame2DElements -= 1
        if frame2DStore.frame2DElements.count > 0 {
            if frame2DStore.frame2DElements.count > 0 {
                for index in 0...frame2DStore.frame2DElements.count - 1{
                    frame2DStore.frame2DElements[index].id = index
                }
            }
    }
        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
    }
}

//#if DEBUG
//struct Frame2DList_Previews: PreviewProvider {
//    static var previews: some View {
//        Frame2DList(frame2DStore: Frame2DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore())
//    }
//}
//#endif
