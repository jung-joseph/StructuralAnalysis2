//
//  ModelView.swift
//  StructuralAnalysis
//
//  Created by Joseph Jung on 1/23/24.
//

import SwiftUI
import SceneKit

struct ModelView: View {
    
//    @State var scene = ModelScene()

//    @State var cameraNode = createCameraNode()
    @Binding var scene: ModelScene
    @Bindable var nodesStore: NodesStore
    @Bindable var dispStore: DispStore
    @Bindable var bcStore: BCStore
    @Bindable var truss2DStore: Truss2DStore
    @Bindable var frame2DStore: Frame2DStore
    @Bindable var truss3DStore: Truss3DStore
    @Bindable var frame3DStore: Frame3DStore
    @Bindable var loadStore: LoadStore
    
//    @Binding var magFactor: Double
    
    var body: some View {
        SceneView(scene: scene, options:[.autoenablesDefaultLighting, .allowsCameraControl])
            .onAppear(perform: {
                print("SceneView appeared")
                
                scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)

            })
        
            .onChange(of: scene.rootNode.childNodes.count){
                
                print("number of nodes of scene of SceneView Changed")
                
            }
            .onChange(of: scene.rootNode.geometry) {
                print("geomety of scene of SceneView Changed")

            }
            .onChange(of: truss2DStore.truss2DElements.count) {
                print("truss2dStore changed")

            }
         
            .onChange(of: nodesStore.nodes.count) {
                print("detected nodesStore changed for SceneView")

            }
            
        
        
    }
    static func createCameraNode() -> SCNNode {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.automaticallyAdjustsZRange = true
        return cameraNode
    }
}


#Preview {
//    @State var scene = SCNScene()
//    return ModelView(scene: $scene)
    ContentView()
}
