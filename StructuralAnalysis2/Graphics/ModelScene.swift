//
//  ModelScene.swift
//  StructuralAnalysis
//
//  Created by Joseph Jung on 1/23/24.
//
/*
 import Foundation
 import SwiftUI//
 //  Truss3DList.swift
 //  FrameStructuralAnalysis
 //
 //  Created by Joseph Jung on 9/5/19.
 //  Copyright © 2019 Joseph Jung. All rights reserved.
 //
 */
//import Combine

import SwiftUI
import SceneKit


class ModelScene: SCNScene {
    var modelNode: SCNNode?
    let drawModel = DrawModel(nodeRadius: CGFloat(0.1), elementRadius: CGFloat(0.075))
    
    override init() {
        
        super.init()
        
        addBackground()
        configureCamera()
        //         addModelNode()
        addOmniLight()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBackground() {
        background.contents = UIColor.black
    }
    func configureCamera() {
        let cameraNode = createCameraNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 5, y: 0, z: 10)
        cameraNode.camera?.automaticallyAdjustsZRange = true
        self.rootNode.addChildNode(cameraNode)
        //        self.rootNode.allowsCameraControl = true
        //        self.rootNode.position = SCNVector3(x: 0, y: 0, z: -10)
    }
    
    func addOmniLight() {
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light?.type = SCNLight.LightType.omni
        omniLightNode.light?.color = UIColor(white: 1, alpha: 1)
        omniLightNode.position = SCNVector3Make(50, 0, 30)
        self.rootNode.addChildNode(omniLightNode)
    }
    
    func addModelNode() {
        //        drawModel.viewNodes(nodesStore: nodeStore, dispStore: dispStore, magFactor: magFactor, scene: scene)
        let newSphere = SCNSphere(radius: CGFloat(1.0))
        newSphere.firstMaterial?.diffuse.contents = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1) // red, alpha = 1
        let newSCNNode = SCNNode(geometry: newSphere)
        newSCNNode.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        self.rootNode.addChildNode(newSCNNode)
        
    }
    func createCameraNode() -> SCNNode {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.automaticallyAdjustsZRange = true
        return cameraNode
    }
}
