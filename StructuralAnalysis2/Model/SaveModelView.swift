//
//  SaveModelView.swift
//  StructuralAnalysis2
//
//  Created by Joseph Jung on 2/13/24.
//

import SwiftUI

struct SaveModelView: View{
    @Bindable var nodesStore: NodesStore
    @Bindable var dispStore: DispStore
    @Bindable var materialStore: MaterialStore
    @Bindable var elPropertyStore: ElPropertyStore
    @Bindable var truss2DStore: Truss2DStore
    @Bindable var frame2DStore: Frame2DStore
    @Bindable var truss3DStore: Truss3DStore
    @Bindable var frame3DStore: Frame3DStore
    @Bindable var loadStore: LoadStore
    @Bindable var bcStore: BCStore
    
    @Binding var showSaveModel: Bool
    @State var filename: String = ""
    
    enum CodingKeys: CodingKey {
        case nodes
        case totalNumDofs
        case displacements
    }
    var body: some View {
        
        VStack{
            Text("Save Current Model")
            TextField("Enter filename", text: $filename)
                .cornerRadius(10)
                .textFieldStyle(.roundedBorder)
                .frame(width: 200, height: nil)
                .multilineTextAlignment(.center)

            Button {
                print("Executing Save Button")
                let filePath = self.getDocumentsDirectoryUrl().appendingPathComponent(filename, conformingTo: .plainText )
                print("filePath")
                // Encode Model
                let jsonEncoder = JSONEncoder()
                let model = Model(nodesStore: nodesStore, dispStore: dispStore, materialStore: materialStore, elPropertyStore: elPropertyStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, loadStore: loadStore, bcStore: bcStore)
                do {
                    let modelJson = try? jsonEncoder.encode(model)
//                    let modelJsonString = String(data: modelJson!, encoding: .utf8)
                    // write to file
 
                    try modelJson!.write(to: filePath)
                } catch {
                    print("Error writing JSOn file \(error)")
                }
//                let modelJson = try! jsonEncoder.encode(model)
//                let modelJsonString = String(data: modelJson, encoding: .utf8)
//                print("\(String(describing: modelJsonString))")
               
                
                
                /*
                let filePath = self.getDocumentsDirectoryUrl().appendingPathComponent(filename, conformingTo: .plainText )
                do {
                    
//                    var container = JSONEncoder().container(keyedBy: CodingKeys.self)
//                    try container.encode(nodesStore.nodes,forKey: .nodes)
//                    try container.encode(nodesStore.totalNumDofs, forKey: .totalNumDofs)
//        //            let tempEncodedData = String(data: jsonResultData!, encoding: .utf8)
//                    print(String(data: container))
//                    try container.write(to: filePath)
                    
                } catch {
                    print("Error writing JSON file \(error)")
                }
                 */
                showSaveModel = false
            } label: {
                Text("Save Model to Files")
            }

        }
    }
    func getDocumentsDirectoryUrl() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

//#Preview {
//    SaveModelView()
//}
