//
//  LoadView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/16/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct LoadView: View {
    
    @Binding var scene: ModelScene
    var load: Load
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
    @State private var localLoadValue: Double? = nil
    
    @State private var pickerDirection: Int = 0

    var body: some View {
        VStack {
            Text("LOAD DETAIL").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                Text("ID: \(load.id)")
                HStack {
                    Text("Node:")
                    TextField("\(load.loadNode)", value:
                                $localNode, format: .number)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                HStack {
                    Text("Direction:")
                    Picker("", selection: $pickerDirection) {
                        Text("X").tag(0)
                        Text("Y").tag(1)
                        Text("Z").tag(2)
                        Text("XX").tag(3)
                        Text("YY").tag(4)
                        Text("ZZ").tag(5)
                    }.pickerStyle(SegmentedPickerStyle())
                        .font(.custom("Arial", size: 20))
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    
                    
                }
                
                HStack {
                    Text("Value:")
                    TextField(String(format: "%.2f", self.load.loadValue), value: $localLoadValue, format: .number)
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .font(.custom("Arial", size: 20))
            
            
            HStack {
                Spacer()
                Button (action: {
                    
                    //MARK: - Add new load
                    if !isEditing {
                        if localNode == nil {
                            localNode = 0
                        }
//                        if localDirection == nil {
                            localDirection = pickerDirection
//                        }
                        if localLoadValue == nil {
                            localLoadValue = 0.0
                        }
                        
                        let newLoad = Load(id:self.load.id, loadNode: localNode!, loadDirection: localDirection!, loadValue: localLoadValue!)
//                        let newLoad = Load(id:self.load.id)
                        self.loadStore.addLoad(load: newLoad)
                        
                        // MARK: -                           ReDraw entire model
                        scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                        isEditing.toggle()
                    
                    /*
                     var nodeTemp = Int(self.loadStore.loadNodeText)
                     if  nodeTemp == nil {
                         nodeTemp = self.loadStore.loads[self.load.id].loadNode
                     }

                    var loadDirectionTemp: Int
                    if         self.loadStore.loadDirectionText == "X" {
                        loadDirectionTemp = 0
                    } else if (self.loadStore.loadDirectionText == "Y") {
                        loadDirectionTemp = 1
                    } else if (self.loadStore.loadDirectionText == "Z") {
                        loadDirectionTemp = 2
                    } else if (self.loadStore.loadDirectionText == "XX") {
                        loadDirectionTemp = 3
                    } else if (self.loadStore.loadDirectionText == "YY") {
                        loadDirectionTemp = 4
                    } else if (self.loadStore.loadDirectionText == "ZZ") {
                        loadDirectionTemp = 5
                    } else {
                        loadDirectionTemp = 0
                    }
 
                     
                    var loadValueTemp = Double(self.loadStore.loadValueText)
                     if  loadValueTemp == nil {
                         loadValueTemp = self.loadStore.loads[self.load.id].loadValue
                     }
                    self.loadStore.loadValueText = ""
                    
                     let newLoad = Load(id:self.load.id, loadNode: nodeTemp!, loadDirection: loadDirectionTemp, loadValue: loadValueTemp!)
                     self.loadStore.changeLoad(load: newLoad)
                     self.loadStore.printLoads()
                   */
                        
                    } else {
                        //MARK: - Make changes to exisiting Load
                        if localNode == nil {
                            localNode = load.loadNode
                        }
                        if pickerDirection != load.loadDirection {
                            localDirection = pickerDirection
                        }else{
                            localDirection = load.loadDirection
                        }
                        if localLoadValue == nil {
                            localLoadValue = load.loadValue
                        }
                        
                        loadStore.loads[load.id].loadNode = localNode!
                        loadStore.loads[load.id].loadDirection = localDirection!
                        loadStore.loads[load.id].loadValue = localLoadValue!
                        
                        // MARK: -                           ReDraw entire model
                        
                        scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }
                    self.loadStore.printLoads()
                    
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
        .onAppear(perform: {
            pickerDirection = load.loadDirection
        })
    }// body
      
}

//#Preview(traits: .landscapeLeft) {
//    LoadView(load: Load(id:0 ,loadNode: 0, loadDirection: 0, loadValue: 0 ), loadStore: LoadStore() )
//}

/*
#if DEBUG
struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView(load: Load(id:0 ,loadNode: 0, loadDirection: 0, loadValue: 0 ), loadStore: LoadStore() )
    }
}
#endif
*/
