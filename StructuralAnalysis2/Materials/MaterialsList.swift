//
//  MaterialsList.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/24/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI
import Combine

struct MaterialsList : View {
    
//    @Binding var dismissFlag: Bool
    @Bindable var materialStore : MaterialStore
    
    @Environment(\.presentationMode) private var presentationMode
   
    
    var body: some View {
        
        NavigationStack {
            
            VStack {

                List {

                    ForEach(materialStore.materials) {material in
                        NavigationLink(destination: MaterialView(material: material, materialStore: self.materialStore)){
                            MaterialRow(material: material)
                        }
                    }.onDelete(perform: delete)
                }
                     .navigationBarItems(
                     
                     leading: Button("+") {
                        let newMat = Material(id: self.materialStore.numMaterials)
                        self.materialStore.textYM = "0"
                        self.materialStore.textGM = "0"
                         self.materialStore.addMaterial(material: newMat)
                     }
                     .padding()
                     .foregroundColor(Color.blue)
                     .font(.title)
                     
                     ,trailing: EditButton())

//
                Spacer()
            }
            .navigationTitle("Materials")
        }
        
    }
    

    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            materialStore.materials.remove(at: first)
        }
        
        materialStore.numMaterials -= 1
        
        
        for index in 0...materialStore.materials.count - 1{
            materialStore.materials[index].id = index
        }
    }
}

#if DEBUG
struct MaterialsList_Previews : PreviewProvider {

 
    static var previews: some View {
        MaterialsList( materialStore: MaterialStore())
    }
}
#endif
