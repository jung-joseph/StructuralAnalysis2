//
//  LoadView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/16/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct LoadView: View {
    
    var load: Load
    @Bindable var loadStore: LoadStore
    @Environment(\.presentationMode) private var showDetail

    
    var body: some View {
        VStack {
            Text("LOAD DETAIL").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                Text("ID: \(load.id)").font(.custom("Arial", size: 20))
                HStack {
                    Text("Node:").font(.custom("Arial", size: 20))
                    TextField("\(load.loadNode)", text:
                        $loadStore.loadNodeText)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                HStack {
                    Text("Direction:").font(.custom("Arial", size: 20))
                    Picker("", selection: self.$loadStore.loadDirectionText) {
                        Text("X").tag("X").font(.custom("Arial", size: 20))
                        Text("Y").tag("Y").font(.custom("Arial", size: 20))
                        Text("Z").tag("Z").font(.custom("Arial", size: 20))
                        Text("XX").tag("XX").font(.custom("Arial", size: 20))
                        Text("YY").tag("YY").font(.custom("Arial", size: 20))
                        Text("ZZ").tag("ZZ").font(.custom("Arial", size: 20))
                    }.pickerStyle(SegmentedPickerStyle())
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(radius: 10)

                }
                HStack {
                    Text("Value:").font(.custom("Arial", size: 20))
                    TextField("\(load.loadValue)", text:
                        $loadStore.loadValueText)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }            }
            
            
            HStack {
                Spacer()
                Button (action: {
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
    }// body
}

#Preview(traits: .landscapeLeft) {
    LoadView(load: Load(id:0 ,loadNode: 0, loadDirection: 0, loadValue: 0 ), loadStore: LoadStore() )
}

/*
#if DEBUG
struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView(load: Load(id:0 ,loadNode: 0, loadDirection: 0, loadValue: 0 ), loadStore: LoadStore() )
    }
}
#endif
*/
