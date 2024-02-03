//
//  BCView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct BCView: View {
    
    @Binding var scene: ModelScene
    var bc: BC
    @Bindable var nodesStore : NodesStore
    @Bindable var truss2DStore: Truss2DStore
    @Bindable var frame2DStore: Frame2DStore
    @Bindable var truss3DStore: Truss3DStore
    @Bindable var frame3DStore: Frame3DStore
    @Bindable var dispStore: DispStore
    @Bindable var bcStore: BCStore
    @Bindable var loadStore: LoadStore
    
    @Binding var isEditing: Bool
    
    @Environment(\.presentationMode) private var showDetail
    
    @State private var localNode: Int? = nil
    @State private var localDirection: Int? = nil
    @State private var localBCValue: Double? = nil
    
    @State private var pickerDirection: Int = 0
    
    var body: some View {
        VStack {
            Text(" BC DETAIL").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                Text("ID: \(bc.id)")
                HStack {
                    Text("Node:")
                    TextField("\(bc.bcNode)", value:
                                $localNode, format: .number)
                    
                }
                Text("Direction:")
                Picker("", selection: $pickerDirection) {
                    Text("X").tag(0)
                    Text("Y").tag(1)
                    Text("Z").tag(2)
                    Text("XX").tag(3)
                    Text("YY").tag(4)
                    Text("ZZ").tag(5)
                }.pickerStyle(SegmentedPickerStyle())
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                HStack {
                    Text("Value:")
                    TextField(String(format: "%.2f",self.bc.bcValue), value:
                                $localBCValue,format: .number)
                    
                }
            }
            
            HStack {
                Spacer()
                Button (action:{
                    
                    // MARK: - Add new bc
                    if !isEditing {
                        if localNode == nil {
                            localNode = 0
                        }
//                        if localDirection == nil {
                            localDirection = pickerDirection
//                        }
                        if localBCValue == nil {
                            localBCValue = 0.0
                        }
                    
                    
                    
                    let newBC = BC(id:self.bc.id, bcNode: localNode!, bcDirection: localDirection!, bcValue: localBCValue!)
                    self.bcStore.addBC(bc: newBC)
                    // MARK: -                           ReDraw entire model
                    scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    isEditing.toggle()
                    /*
                     var nodeTemp = Int(self.bcStore.bcNodeText)
                     if  nodeTemp == nil {
                     nodeTemp = self.bcStore.bcs[self.bc.id].bcNode
                     }
                     
                     var bcDirectionTemp: Int
                     if         self.bcStore.bcDirectionText == "X" {
                     bcDirectionTemp = 0
                     } else if (self.bcStore.bcDirectionText == "Y") {
                     bcDirectionTemp = 1
                     } else if (self.bcStore.bcDirectionText == "Z") {
                     bcDirectionTemp = 2
                     } else if (self.bcStore.bcDirectionText == "XX") {
                     bcDirectionTemp = 3
                     } else if (self.bcStore.bcDirectionText == "YY") {
                     bcDirectionTemp = 4
                     } else if (self.bcStore.bcDirectionText == "ZZ") {
                     bcDirectionTemp = 5
                     } else {
                     bcDirectionTemp = 0
                     }
                     
                     
                     
                     var bcValueTemp = Double(self.bcStore.bcValueText)
                     if  bcValueTemp == nil {
                     bcValueTemp = self.bcStore.bcs[self.bc.id].bcValue
                     }
                     self.bcStore.bcValueText = ""
                     
                     let newBC = BC(id:self.bc.id, bcNode: nodeTemp!, bcDirection: bcDirectionTemp, bcValue: bcValueTemp!)
                     self.bcStore.changeBC(bc: newBC)
                     self.bcStore.printBCs()
                     */
                } else {
                    //MARK: - Make changes to exisiting BC
                    if localNode == nil {
                        localNode = bc.bcNode
                    }
                    if pickerDirection != bc.bcDirection {
                        localDirection = pickerDirection
                    } else {
                        localDirection = bc.bcDirection
                    }
                    if localDirection != bc.bcDirection {
                        localDirection = pickerDirection
                    }
                    if localBCValue == nil {
                        localBCValue = bc.bcValue
                    }
                    
                    bcStore.bcs[bc.id].bcNode = localNode!
                    bcStore.bcs[bc.id].bcDirection = localDirection!
                    bcStore.bcs[bc.id].bcValue = localBCValue!
                    
                    // MARK: -                           ReDraw entire model
                    
                    scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    
                }
                    
                    self.bcStore.printBCs()

                    self.showDetail.wrappedValue.dismiss()
                    
                    
                }) { Text ("Save Changes")}
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                Spacer()
            }
            
            Spacer()
            
            
        }// Vstack
        .textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
    }// body
}
//#Preview(traits: .landscapeLeft) {
//    BCView(bc: BC(id:0 ,bcNode: 0, bcDirection: 0, bcValue: 0 ), bcStore: BCStore() )
//}
/*
 #if DEBUG
 struct BCView_Previews: PreviewProvider {
 static var previews: some View {
 BCView(bc: BC(id:0 ,bcNode: 0, bcDirection: 0, bcValue: 0 ), bcStore: BCStore() )
 }
 }
 #endif
 */
