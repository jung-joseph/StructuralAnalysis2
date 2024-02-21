//
//  Model.swift
//  StructuralAnalysis
//
//  Created by Joseph Jung on 1/29/24.
//

import Foundation
import SwiftUI


struct Model: Encodable, Decodable {
    
    
    
    let nodesStore: NodesStore
    //    let dispStore: DispStore
    let materialStore: MaterialStore
    let elPropertyStore: ElPropertyStore
    let truss2DStore: Truss2DStore
    let frame2DStore: Frame2DStore
    let truss3DStore: Truss3DStore
    let frame3DStore: Frame3DStore
    let loadStore: LoadStore
    let bcStore: BCStore
    
    enum CodingKeys: CodingKey {
        case nodesStore
        //        case dispStore
        case materialStore
        case elPropertyStore
        case truss2DStore
        case frame2DStore
        case truss3DStore
        case frame3DStore
        case loadStore
        case bcStore
        
    }
    
    init(nodesStore: NodesStore, materialStore: MaterialStore, elPropertyStore: ElPropertyStore, truss2DStore: Truss2DStore, frame2DStore: Frame2DStore, truss3DStore: Truss3DStore, frame3DStore: Frame3DStore, loadStore: LoadStore, bcStore: BCStore) {
        self.nodesStore = nodesStore
        //        self.dispStore = dispStore
        self.materialStore = materialStore
        self.elPropertyStore = elPropertyStore
        self.truss2DStore = truss2DStore
        self.frame2DStore = frame2DStore
        self.truss3DStore = truss3DStore
        self.frame3DStore = frame3DStore
        self.loadStore = loadStore
        self.bcStore = bcStore
    }
    
    init(from decoder: Decoder) throws {
        print("calling Model init decoder")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let tempNodesStore = try? container.decode(NodesStore.self,  forKey: .nodesStore) {
            print("nodeStore decoded")
            self.nodesStore = tempNodesStore
            print("nodes: \(nodesStore.nodes)")
        } else {
            fatalError("Unable to Decode nodestore")
        }
        //        self.dispStore = try container.decode(DispStore.self, forKey: .dispStore)
        //        self.dispStore = DispStore()
        
        if let tempMaterialStore = try? container.decode(MaterialStore.self,  forKey: .materialStore){
            print("materialStore decoded")
            self.materialStore = tempMaterialStore
            print("materials: \(materialStore.materials)")
        } else {
            fatalError("Unable to Decode materialstore")
        }
        //        self.materialStore = try container.decode(MaterialStore.self,  forKey: .materialStore)
        
        if let tempElPropertyStore = try? container.decode(ElPropertyStore.self,  forKey: .elPropertyStore){
            print("elPropertyStore decoded")
            self.elPropertyStore = tempElPropertyStore
            print("elProperties: \(elPropertyStore.elProperties)")
        } else {
            fatalError("Unable to Decode elPropertystore")
        }
        //        self.elPropertyStore = try container.decode(ElPropertyStore.self,  forKey: .elPropertyStore)
        
        if let tempTruss2DStore = try? container.decode(Truss2DStore.self,  forKey: .truss2DStore){
            print("truss2DStore decoded")
            self.truss2DStore = tempTruss2DStore
            print("truss2DStore: \(truss2DStore.truss2DElements)")
        } else {
            fatalError("Unable to Decode truss2Dstore")
        }
        //        self.truss2DStore = try container.decode(Truss2DStore.self,  forKey: .truss2DStore)
        
        if let tempFrame2DStore = try? container.decode(Frame2DStore.self,  forKey: .frame2DStore){
            print("frame2DStore decoded")
            self.frame2DStore = tempFrame2DStore
            print("frame2DStore: \(frame2DStore.frame2DElements)")
        } else {
            fatalError("Unable to Decode frame2Dstore")
        }
        //        self.frame2DStore = try container.decode(Frame2DStore.self,  forKey: .frame2DStore)
        
        if let tempTruss3DStore = try? container.decode(Truss3DStore.self,  forKey: .truss3DStore){
            print("truss3DStore decoded")
            self.truss3DStore = tempTruss3DStore
            print("truss3DStore: \(truss3DStore.truss3DElements)")
        } else {
            fatalError("Unable to Decode truss3Dstore")
        }
        //        self.truss3DStore = try container.decode(Truss3DStore.self,  forKey: .truss3DStore)
        
        if let tempFrame3DStore = try? container.decode(Frame3DStore.self,  forKey: .frame3DStore){
            print("frame3DStore decoded")
            self.frame3DStore = tempFrame3DStore
            print("frame3DStore: \(frame3DStore.frame3DElements)")
        } else {
            fatalError("Unable to Decode frame3Dstore")
        }
        //        self.frame3DStore = try container.decode(Frame3DStore.self,  forKey: .frame3DStore)
        
        if let tempLoadStore = try? container.decode(LoadStore.self,  forKey: .loadStore){
            print("loadStore decoded")
            self.loadStore = tempLoadStore
            print("loadStore: \(loadStore.loads)")
        } else {
            fatalError("Unable to Decode loadstore")
        }
        //        self.loadStore = try container.decode(LoadStore.self,  forKey: .loadStore)
        
        if let tempBCStore = try? container.decode(BCStore.self,  forKey: .bcStore){
            print("bcStore decoded")
            self.bcStore = tempBCStore
            print("bcStore: \(bcStore.bcs)")
        } else {
            fatalError("Unable to Decode bcstore")
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        print("In Model encode")
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nodesStore, forKey: .nodesStore)
        //        try container.encode(dispStore, forKey: .dispStore)
        try container.encode(materialStore, forKey: .materialStore)
        try container.encode(elPropertyStore, forKey: .elPropertyStore)
        try container.encode(truss2DStore, forKey: .truss2DStore)
        try container.encode(frame2DStore, forKey: .frame2DStore)
        try container.encode(truss3DStore, forKey: .truss3DStore)
        try container.encode(frame3DStore, forKey: .frame3DStore)
        try container.encode(loadStore, forKey: .loadStore)
        try container.encode(bcStore, forKey: .bcStore)
    }
}
    
    func loadDataFromLocalFile(url: URL!, nodesStore: NodesStore) {
        guard let url = url
        else {
            print("json file not found")
            return
        }
        
        if let data = try? Data(contentsOf: url) {
            print("Successful Data call")
            print(data)
            
            if let model = try? JSONDecoder().decode(Model.self, from: data) {
                print("Successful Decoder Call")
                nodesStore.nodes = model.nodesStore.nodes
                nodesStore.totalNumDofs = model.nodesStore.totalNumDofs
                print("nodes: \(nodesStore.nodes)")
                
            } else {
                print("Decoder Failure")
            }
        } else {
            print("Data call Failure")
        }
        
    }

