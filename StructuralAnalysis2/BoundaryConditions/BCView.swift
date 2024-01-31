//
//  BCView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct BCView: View {
    
    var bc: BC
    @Bindable var bcStore: BCStore
    @Environment(\.presentationMode) private var showDetail

    var body: some View {
        VStack {
            Text("DETAIL").font(.custom("Arial", size: 25))
            
            VStack(alignment: .leading) {
                Text("ID: \(bc.id)").font(.custom("Arial", size: 20))
                HStack {
                    Text("Node:").font(.custom("Arial", size: 20))
                    TextField("\(bc.bcNode)", text:
                        $bcStore.bcNodeText)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }
                Text("Direction:").font(.custom("Arial", size: 20))
                Picker("", selection: self.$bcStore.bcDirectionText) {
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

                HStack {
                    Text("Value:").font(.custom("Arial", size: 20))
                    TextField(String(format: "%.2f",self.bc.bcValue), text:
                        $bcStore.bcValueText)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 20))
                }            }
            
            HStack {
                Spacer()
                Button (action:{
                        
                        
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
    BCView(bc: BC(id:0 ,bcNode: 0, bcDirection: 0, bcValue: 0 ), bcStore: BCStore() )
}
/*
#if DEBUG
struct BCView_Previews: PreviewProvider {
    static var previews: some View {
        BCView(bc: BC(id:0 ,bcNode: 0, bcDirection: 0, bcValue: 0 ), bcStore: BCStore() )
    }
}
#endif
*/
