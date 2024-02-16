//
//  Model.swift
//  StructuralAnalysis
//
//  Created by Joseph Jung on 1/29/24.
//

import Foundation
import SwiftUI


struct Model: Encodable {
    
   
    let nodesStore: NodesStore
    let dispStore: DispStore
    let materialStore: MaterialStore
    let elPropertyStore: ElPropertyStore
    let truss2DStore: Truss2DStore
    let frame2DStore: Frame2DStore
    let truss3DStore: Truss3DStore
    let frame3DStore: Frame3DStore
    let loadStore: LoadStore
    let bcStore: BCStore
    
    private enum CodingKeys: CodingKey {
        case nodesStore
        case dispStore
        case materialStore
        case elPropertyStore
        case truss2DStore
        case frame2DStore
        case truss3DStore
        case frame3DStore
        case loadStore
        case bcStore
       
    }
    func encode(to encoder: Encoder) throws {
        print("In Model encode")
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nodesStore, forKey: .nodesStore)
        try container.encode(dispStore, forKey: .dispStore)
        try container.encode(materialStore, forKey: .materialStore)
        try container.encode(truss2DStore, forKey: .truss2DStore)
        try container.encode(frame2DStore, forKey: .frame2DStore)
        try container.encode(truss3DStore, forKey: .truss3DStore)
        try container.encode(frame3DStore, forKey: .frame3DStore)
        try container.encode(loadStore, forKey: .loadStore)
        try container.encode(bcStore, forKey: .bcStore)
        
        


    }
    
}
/*
struct Model: Codable {
    
    enum CodingKeys: CodingKey {
        case nodes
        case totalNumDofs
        case dispStore
        case materialStore
        case elPropertyStore
        case truss2DStore
        case frame2DStore
        case truss3DStore
        case frame3DStore
        case loadStore
        case bcStore
    }
    
//    @Bindable var nodesStore: NodesStore
    var nodesStore: NodesStore
//    var dispStore: DispStore = DispStore()
//    var materialStore: MaterialStore = MaterialStore()
//    var elPropertyStore: ElPropertyStore = ElPropertyStore()
//    var truss2DStore: Truss2DStore = Truss2DStore()
//    var frame2DStore: Frame2DStore = Frame2DStore()
//    var truss3DStore: Truss3DStore = Truss3DStore()
//    var frame3DStore: Frame3DStore = Frame3DStore()
//    var loadStore: LoadStore = LoadStore()
//    var bcStore: BCStore = BCStore()
    
    init(nodeStore: NodesStore) {
        nodesStore = nodeStore
    }
    
//     init(from decoder: Decoder) throws {
//         let localNodesStore = NodesStore()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//         let localNodesStoreNodesDictionary = try container.decode([String:[Node]].self, forKey: .nodes)
//        let localtotalNumDofs = try container.decode(Int.self, forKey: .totalNumDofs)
//         
//         nodesStore.nodes = localNodesStoreNodesDictionary["nodes"]!
//         nodesStore.totalNumDofs = localtotalNumDofs
//    }
    
    required init(from decoder: Decoder) throws {
        fatalError("Decoder init not implemented")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(nodesStore.nodes, forKey: .nodes)
        try container.encode(nodesStore.totalNumDofs, forKey: .totalNumDofs)
    }
    
    func decode(url: URL?) {
        guard let url = url
        else {
            print("json file not found")
            return
        }
        
        if let data = try? Data(contentsOf: url) {
            print("Successful Data call")
            if let decodedNodes = try? JSONDecoder().decode([Node].self, from: data) {
                print("Successful Decoder Call")
                nodesStore.nodes = decodedNodes

            } else {
                print("Decoder Failure")
            }
        } else {
            print("Data call Failure")
        }
    }
}
*/

