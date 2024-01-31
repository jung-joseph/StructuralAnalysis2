//
//  ElPropertyList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/30/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct ElPropertyList: View {
    

    @Bindable var elPropertyStore : ElPropertyStore
    @Environment(\.presentationMode) private var presentationMode

    
    var body: some View {
        NavigationView {
            
            VStack {

                
                List {
                                    
                                
                    ForEach(elPropertyStore.elProperties) {elProperty in
                        NavigationLink(destination: ElPropertyView(elProperty: elProperty, elPropertyStore: self.elPropertyStore)){
                            ElPropertyRow(elProperty: elProperty)
                        }
                    }.onDelete(perform: delete)
                }
                .navigationBarItems(
                
                    leading: Button("+") {
                        let newElProp = ElProperty(id: self.elPropertyStore.numElProperties)
                        self.elPropertyStore.areaText = "0"
                        self.elPropertyStore.ixxText = "0"
                        self.elPropertyStore.iyyText = "0"
                        self.elPropertyStore.ixyText = "0"
                        self.elPropertyStore.ijText = "0"
                        self.elPropertyStore.addElProperty(elProperty: newElProp)
                    }
                    .padding()
                    .foregroundColor(Color.blue)
                    .font(.title)
                    
                    ,trailing: EditButton())
                
                    .navigationBarTitle("Element Properties").font(.largeTitle)
                

//
                Spacer()
                
            }
            
        }
    
    }
    
//    func dismiss(){
//        self.presentationMode.value.dismiss()
//      }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            elPropertyStore.elProperties.remove(at: first)
        }
        
        elPropertyStore.numElProperties -= 1
       
        
        for index in 0...elPropertyStore.elProperties.count - 1{
            elPropertyStore.elProperties[index].id = index
        }
    }
}

#if DEBUG
struct ElPropertyList_Previews: PreviewProvider {
    static var previews: some View {
        ElPropertyList(elPropertyStore: ElPropertyStore())
    }
}
#endif
