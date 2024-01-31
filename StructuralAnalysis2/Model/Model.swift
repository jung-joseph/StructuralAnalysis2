//
//  Model.swift
//  StructuralAnalysis
//
//  Created by Joseph Jung on 1/29/24.
//

import Foundation

@Observable
class Model {
    
    var nodesStore: NodesStore = NodesStore()
    var dispStore: DispStore = DispStore()
    var materialStore: MaterialStore = MaterialStore()
    var elPropertyStore: ElPropertyStore = ElPropertyStore()
    var truss2DStore: Truss2DStore = Truss2DStore()
    var frame2DStore: Frame2DStore = Frame2DStore()
    var truss3DStore: Truss3DStore = Truss3DStore()
    var frame3DStore: Frame3DStore = Frame3DStore()
    var loadStore: LoadStore = LoadStore()
    var bcStore: BCStore = BCStore()
}


