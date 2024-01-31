//
//  LoadList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/16/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct LoadList: View {
    
    @Bindable var loadStore : LoadStore
    @Environment(\.presentationMode) private var presentationMode
    
    
    var body: some View {
        
        NavigationView {
        
            VStack {
                
                List {
                    
                    ForEach(loadStore.loads) {load in
                        NavigationLink(destination: LoadView(load: load, loadStore: self.loadStore)) {
                            LoadRow(load: load)
                        }
                    }.onDelete(perform: delete)
                } //List
                    .navigationBarItems(
                    
                    leading: Button("+") {
                        let newLoad = Load(id:self.loadStore.numLoads,loadNode: 0, loadDirection: 0, loadValue: 0)
                        self.loadStore.loadNodeText = "0"
                        self.loadStore.loadDirectionText = "0"
                        self.loadStore.loadValueText = "0"
                        self.loadStore.addLoad(load: newLoad)
                    }
                    .padding()
                    .foregroundColor(Color.blue)
                    .font(.title)
                    
                    ,trailing: EditButton())
                    
                    .navigationBarTitle("Loads").font(.largeTitle)

                
                Spacer()
                
                
                
            } //VStack
            
        } // NavigationView
    } // body
    
//    func dismiss(){
//        self.presentationMode.value.dismiss()
//    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            loadStore.loads.remove(at: first)
        }
        
        loadStore.numLoads -= 1
       
        
        for index in 0...loadStore.loads.count - 1{
            loadStore.loads[index].id = index
        }
    }
    
    
    
    
}

#Preview(traits: .landscapeLeft) {
    LoadList(loadStore: LoadStore())
}

/*
 #if DEBUG
 struct LoadList_Previews: PreviewProvider {
 static var previews: some View {
 LoadList(loadStore: LoadStore())
 }
 }
 #endif
 */
