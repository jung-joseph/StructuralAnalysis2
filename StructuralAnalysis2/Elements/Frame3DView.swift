//
//  Frame3DView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/8/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Frame3DView: View {
    
    var frame3d: Frame3D
    @Bindable var frame3DStore: Frame3DStore
    @Bindable var nodesStore: NodesStore
    @Bindable var materialStore: MaterialStore
    @Bindable var elPropertyStore: ElPropertyStore
    
    @Environment(\.presentationMode) private var showDetail
    
    @State var node1IsOn:Bool
    @State var node2IsOn:Bool

    
    var body: some View {
        
        VStack {
            Text("Frame3D Element Detail").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                HStack{
                    Text("MatID:").font(.custom("Arial", size: 20))
                    TextField("\(frame3d.matID)", text: $frame3DStore.matIDText).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                HStack {
                    Text("PropertyID:").font(.custom("Arial", size: 20))
                    TextField("\(frame3d.propertiesID)", text: $frame3DStore.propertyIDText).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                HStack {
                    Text("Node1:").font(.custom("Arial", size: 20))
                    TextField("\(frame3d.node1)", text: $frame3DStore.node1Text).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
//                    Spacer()
                    Toggle(isOn: $node1IsOn) {
                        Text("Pin End").font(.custom("Arial", size: 20))
                        if node1IsOn {
                            Text("ON").font(.custom("Arial", size: 20))
                        }
//                        frame2DStore.frame2DElements[frame2d.id].pin1 = true
                        
                    }
                }
                HStack {
                    Text("Node2:").font(.custom("Arial", size: 20))
                    TextField("\(frame3d.node2)", text: $frame3DStore.node2Text).textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
//                    Spacer()
                    Toggle(isOn: $node2IsOn) {
                        Text("Pin End").font(.custom("Arial", size: 20))
                        if node2IsOn {
                            Text("ON").font(.custom("Arial", size: 20))
                        }
//                        frame2DStore.frame2DElements[frame2d.id].pin2 = true

                    }
                }
            }
            
            HStack {
                Spacer()
                Button (action: {
                     var matIDtemp = Int(self.frame3DStore.matIDText)
                     if  matIDtemp == nil {
                         matIDtemp = self.frame3d.matID
                     }
                     self.frame3DStore.matIDText = ""
                    
                     var proptemp = Int(self.frame3DStore.propertyIDText)
                     if  proptemp == nil {
                         proptemp = self.frame3d.propertiesID
                     }
                     self.frame3DStore.propertyIDText = ""
                    
                     var node1temp = Int(self.frame3DStore.node1Text)
                     if  node1temp == nil {
                         node1temp = self.frame3d.node1
                     }
                    self.frame3DStore.node1Text = ""
                     
                     var node2temp = Int(self.frame3DStore.node2Text)
                     if  node2temp == nil {
                         node2temp = self.frame3d.node2
                     }
                    self.frame3DStore.node2Text = ""
                    
//                        print(" In Frame2DView ")
//                        print("node1IsOn \(self.node1IsOn) node2IsOn \(self.node2IsOn) ")
                    
                    let newFrame3D = Frame3D(id: self.frame3d.id, matID: matIDtemp!, propertiesID: proptemp!, node1: node1temp!, node2: node2temp!, pin1: self.node1IsOn, pin2: self.node2IsOn, nodesStore: self.nodesStore, materialStore: self.materialStore, elPropertyStore: self.elPropertyStore, frame3DStore: self.frame3DStore)
                     self.frame3DStore.changeFrame3D(element: newFrame3D)
                     self.frame3DStore.printConnectivity()
                    
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
//struct Frame3DView_Previews: PreviewProvider {
//    @State var bind = false
//
//    static var previews: some View {
//        Frame3DView(frame3d: Frame3D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 0, pin1: false, pin2: false, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), frame3DStore: Frame3DStore() ), frame3DStore: Frame3DStore(), nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), node1IsOn: bind, node2IsOn: bind )
//    }
//}
//#endif

