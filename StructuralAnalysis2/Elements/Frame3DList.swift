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
    @Bindable var frame3DStore : Frame3DStore
    @Bindable var nodesStore : NodesStore
    @Bindable var materialStore : MaterialStore
    @Bindable var elPropertyStore : ElPropertyStore
    
    @Environment(\.presentationMode) private var presentationMode
//    @State var node1IsOn: Bool
//    @State var node2IsOn: Bool
    
    var body: some View {
        
        NavigationView {
            
            VStack {
             

                
                List {
                    
                    ForEach(frame3DStore.frame3DElements) {frame3D in
                        NavigationLink(destination: Frame3DView(frame3d: frame3D, frame3DStore: self.frame3DStore, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, node1IsOn: false, node2IsOn: false)){
                            Frame3DElementRow(frame3DEl: frame3D)
                        }
                    }.onDelete(perform: delete)
                }
                .navigationBarItems(
                
                leading: Button("+") {
                    let newFrame3d = Frame3D(id: self.frame3DStore.numFrame3DElements, matID: 0, propertiesID: 0, node1: 0, node2: 0,pin1: false, pin2: false, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, frame3DStore: Frame3DStore())
                    self.frame3DStore.node1Text = "0"
                    self.frame3DStore.node2Text = "0"
                    self.frame3DStore.addFrame3DEl(element: newFrame3d)
                }
                .padding()
                .foregroundColor(Color.blue)
                .font(.title)
                
                ,trailing: EditButton())

                .navigationBarTitle("Frame 3D Elements").font(.largeTitle)


                Spacer()
                
                
                
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
        
        frame3DStore.numFrame3DElements -= 1
       
        if frame3DStore.numFrame3DElements > 0 {
            for index in 0...frame3DStore.frame3DElements.count - 1{
                frame3DStore.frame3DElements[index].id = index
            }
        }

    }
}

#if DEBUG
struct Frame3DList_Previews: PreviewProvider {
    static var previews: some View {
        Frame3DList(frame3DStore: Frame3DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore())
    }
}
#endif
