//
//  BCList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct BCList: View {
    
    @Bindable var bcStore : BCStore
    @Environment(\.presentationMode) private var presentationMode
    
    
    var body: some View {
        
        NavigationStack {
        
            VStack {
                
                List {
                    
                    ForEach(bcStore.bcs) {bc in
                        NavigationLink(destination: BCView(bc: bc, bcStore: self.bcStore)) {
                            BCRow(bc: bc)
                        }
                    }.onDelete(perform: delete)
                } //List
                    .navigationBarItems(
                    
                    leading: Button("+") {
                        let newBC = BC(id:self.bcStore.numBCs,bcNode: 0, bcDirection: 0, bcValue: 0)
                        self.bcStore.bcNodeText = "0"
                        self.bcStore.bcDirectionText = "X"
                        self.bcStore.bcValueText = "0"
                        self.bcStore.addBC(bc: newBC)
                    }
                    .padding()
                    .foregroundColor(Color.blue)
                    .font(.title)
                    
                    ,trailing: EditButton())
                
                    .navigationBarTitle("Boundary Conditions").font(.largeTitle)

                
                Spacer()
                
                
                
            } //VStack
            
        } // NavigationView
    } // body
    

    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            bcStore.bcs.remove(at: first)
        }
        
        bcStore.numBCs -= 1
       
        
        for index in 0...bcStore.bcs.count - 1{
            bcStore.bcs[index].id = index
        }
    }
    
    
    
    
}
#Preview(traits: .landscapeLeft) {
    BCList(bcStore: BCStore())
}
/*
#if DEBUG
struct BCList_Previews: PreviewProvider {
    static var previews: some View {
        BCList(bcStore: BCStore())
    }
}
#endif
*/
