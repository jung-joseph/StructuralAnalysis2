//
//  DispList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/21/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct DispList: View {
    
    @Bindable var dispStore : DispStore
    
    var body: some View {
             
             NavigationStack{
                 
                 VStack {
                     
                     if dispStore.displacements != nil{
                         List {
                             
                             ForEach(dispStore.displacements!) {nodalDisp in
                                 
                                 DispRow(nodalDisp: nodalDisp)
                             }
                         }
                     }// List
                     
                 }
 
                     
                     Spacer()
                     .navigationTitle("Displacements")
                 }// VStack
       
                     
             }
    }

#Preview(traits: .landscapeLeft) {
    DispList(dispStore: DispStore())
}

/*
struct DispList_Previews: PreviewProvider {
    static var previews: some View {
        DispList(dispStore: DispStore())
    }
}
*/
