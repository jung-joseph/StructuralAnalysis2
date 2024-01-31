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
    @Bindable var frame2DStore : Frame2DStore
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
                    
                    ForEach(frame2DStore.frame2DElements) {frame2D in
                        NavigationLink(destination: Frame2DView(frame2d: frame2D, frame2DStore: self.frame2DStore, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, node1IsOn: false, node2IsOn: false)){
                            Frame2DElementRow(frame2DEl: frame2D)
                        }
                    }.onDelete(perform: delete)
                }
                .navigationBarItems(
                
                leading: Button("+") {
                    let newFrame2d = Frame2D(id: self.frame2DStore.numFrame2DElements, matID: 0, propertiesID: 0, node1: 0, node2: 0,pin1: false, pin2: false, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, frame2DStore: Frame2DStore())
                    self.frame2DStore.node1Text = "0"
                    self.frame2DStore.node2Text = "0"
                    self.frame2DStore.addFrame2DEl(element: newFrame2d)
                }
                .padding()
                .foregroundColor(Color.blue)
                .font(.title)
                
                ,trailing: EditButton())

                .navigationBarTitle("Frame 2D Elements").font(.largeTitle)


                Spacer()
                
                
                
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
        
        frame2DStore.numFrame2DElements -= 1
       
        if frame2DStore.numFrame2DElements > 0 {
            for index in 0...frame2DStore.frame2DElements.count - 1{
                frame2DStore.frame2DElements[index].id = index
            }
        }

    }
}

#if DEBUG
struct Frame2DList_Previews: PreviewProvider {
    static var previews: some View {
        Frame2DList(frame2DStore: Frame2DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore())
    }
}
#endif
