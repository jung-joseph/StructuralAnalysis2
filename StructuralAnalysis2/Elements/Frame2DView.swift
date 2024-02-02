//
//  Frame2DView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/26/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Frame2DView: View {
    
    @Binding var scene: ModelScene
    var frame2d: Frame2D
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
    
    @Binding var isEditing: Bool
    @Binding var node1IsOn:Bool
    @Binding var node2IsOn:Bool
    
    @Environment(\.presentationMode) private var showDetail
    


    @State private var localMatID: Int?
    @State private var localPropID: Int?
    @State private var localNode1: Int?
    @State private var localNode2: Int?
    
    var body: some View {
        
        VStack {
            Text("Frame2D Element Detail").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                HStack{
                    Text("MatID:").font(.custom("Arial", size: 20))
                    TextField("\(frame2d.matID)", value: $localMatID, format: .number)
                }
                HStack {
                    Text("PropertyID:").font(.custom("Arial", size: 20))
                    TextField("\(frame2d.propertiesID)", value: $localPropID, format: .number)
                }
                HStack {
                    Text("Node1:").font(.custom("Arial", size: 20))
                    TextField("\(frame2d.node1)", value: $localNode1, format: .number)
                    Toggle(isOn: $node1IsOn) {
                        Text("Pin End").font(.custom("Arial", size: 20))
                        if node1IsOn {
                            Text("ON").font(.custom("Arial", size: 20))
                        }
//                        frame2DStore.frame2DElements[frame2d.id].pin1 = true
                        
                    }
                }
                
                HStack {
                    Text("Node2:")
                    TextField("\(frame2d.node2)", value: $localNode2, format: .number)
//                    Spacer()
                    Toggle(isOn: $node2IsOn) {
                        Text("Pin End").font(.custom("Arial", size: 20))
                        if node2IsOn {
                            Text("ON").font(.custom("Arial", size: 20))
                        }
//                        frame2DStore.frame2DElements[frame2d.id].pin2 = true

                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    .font(.custom("Arial", size: 20))
            }
            
            HStack {
                Spacer()
                Button (action: {
                    //MARK: - Add new element
                    if !isEditing{
                        if localMatID == nil {
                            localMatID = 0
                        }
                        if localPropID == nil {
                            localPropID = 0
                        }
                        if localNode1 == nil {
                            localNode1 = 0
                        }
                        if localNode2 == nil {
                            localNode2 = 0
                        }
                        let newFrame2D = Frame2D(id: self.frame2d.id, matID: localMatID!, propertiesID: localPropID!, node1: localNode1!, node2: localNode2!, pin1: node1IsOn, pin2: node2IsOn, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, frame2DStore: self.frame2DStore)
                        
                        //                     self.truss2DStore.changeTruss2D(element: newTruss2D)
                        self.frame2DStore.addFrame2DEl(element: newFrame2D)
                        // MARK: -                           ReDraw entire model
                        scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                        isEditing.toggle()
                    } else {
                        // MARK: - Make changes to existing node
                        //                        print("truss Id: \(truss2d.id)")
                        if localMatID == nil {
                            localMatID = frame2d.matID
                        }
                        if localPropID == nil {
                            localPropID = frame2d.propertiesID
                        }
                        if localNode1 == nil {
                            localNode1 = frame2d.node1
                        }
                        if localNode2 == nil {
                            localNode2 = frame2d.node2
                        }
                        /*
                         var matIDtemp = Int(self.frame2DStore.matIDText)
                         if  matIDtemp == nil {
                         matIDtemp = self.frame2d.matID
                         }
                         self.frame2DStore.matIDText = ""
                         
                         var proptemp = Int(self.frame2DStore.propertyIDText)
                         if  proptemp == nil {
                         proptemp = self.frame2d.propertiesID
                         }
                         self.frame2DStore.propertyIDText = ""
                         
                         var node1temp = Int(self.frame2DStore.node1Text)
                         if  node1temp == nil {
                         node1temp = self.frame2d.node1
                         }
                         self.frame2DStore.node1Text = ""
                         
                         var node2temp = Int(self.frame2DStore.node2Text)
                         if  node2temp == nil {
                         node2temp = self.frame2d.node2
                         }
                         self.frame2DStore.node2Text = ""
                         
                         //                        print(" In Frame2DView ")
                         //                        print("node1IsOn \(self.node1IsOn) node2IsOn \(self.node2IsOn) ")
                         
                         let newFrame2D = Frame2D(id: self.frame2d.id, matID: matIDtemp!, propertiesID: proptemp!, node1: node1temp!, node2: node2temp!, pin1: self.node1IsOn, pin2: self.node2IsOn, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, frame2DStore: self.frame2DStore)
                         self.frame2DStore.changeFrame2D(element: newFrame2D)
                         self.frame2DStore.printConnectivity()
                         */
                        frame2DStore.frame2DElements[frame2d.id].matID = localMatID!
                        frame2DStore.frame2DElements[frame2d.id].propertiesID = localPropID!
                        frame2DStore.frame2DElements[frame2d.id].node1 = localNode1!
                        frame2DStore.frame2DElements[frame2d.id].node2 = localNode2!
                        // MARK: -                           ReDraw entire model
                        
                        scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }
                    self.showDetail.wrappedValue.dismiss()

                     
                 }) { Text ("Save Changes")}
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(CGFloat(10))
                    .shadow(radius: CGFloat(10))
                
                Spacer()

            }
            Spacer()

        } // VStack
    }
}

//#if DEBUG
//struct Frame2DView_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var bind = false
//        Frame2DView(frame2d: Frame2D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 0, pin1: false, pin2: false, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), frame2DStore: Frame2DStore() ), frame2DStore: Frame2DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), node1IsOn: $bind, node2IsOn: $bind )
//    }
//}
//#endif
