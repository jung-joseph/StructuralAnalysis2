//
//  Draw.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/23/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

import UIKit
import SceneKit
//import QuartzCore


class DrawModel{
    
    var nodeRadius : CGFloat
    var nodeColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1) // red, alpha = 1
    var defnodeColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 0.5) // red + transparency
    var elementRadius : CGFloat
    
    var truss2DElementColor = UIColor(red: 0, green: 0, blue: 255/255, alpha: 1) // blue, alpha = 1
    var truss3DElementColor = UIColor(red: 0, green: 0, blue: 255/255, alpha: 1) // blue, alpha = 1

    var defTruss2DElementColor = UIColor(red: 0, green: 0, blue: 255/255, alpha: 0.75) // blue + transparency
    var defTruss3DElementColor = UIColor(red: 0, green: 0, blue: 255/255, alpha: 0.75) // blue + transparency
    
    var frame2DElementColor = UIColor(red: 128/255, green: 0, blue: 128/255, alpha: 1)// purple, alpha = 1
    var frame3DElementColor = UIColor(red: 128/255, green: 0, blue: 128/255, alpha: 1)// purple, alpha = 1
    
    var defFrame2DElementColor = UIColor(red: 128/255, green: 0, blue: 128/255, alpha: 0.75)// purple + transparency
    var defFrame3DElementColor = UIColor(red: 128/255, green: 0, blue: 128/255, alpha: 0.75)// purple + transparency

    
    var bcColor = UIColor(red:255/255, green: 255/255, blue: 0, alpha: 1) //yellow
    var loadColor = UIColor(red: 0, green: 255/255, blue: 0, alpha: 1) // green
    
    let debugFlag: Bool = false
    
    
    init(nodeRadius: CGFloat, elementRadius: CGFloat) {
        self.nodeRadius = nodeRadius
        self.elementRadius = elementRadius

    }
    
    


    func setMagFactor(dispStore: DispStore, maxDimension: Double, dx: Double, dy: Double, dz: Double, percent: Double) -> Double{
        
        // find max displacment
        var maxDispX = 0.0
        var maxDispY = 0.0
        var maxDispZ = 0.0
        var ratioX: Double = 0
        var ratioY: Double = 0
        var ratioZ: Double = 0
        let small = 1.0e-10
        var magFactor: Double = 0.0
        var maxRatio: Double = 0.0
        
        if dispStore.displacements?.count != nil {
            for i in 0...dispStore.displacements!.count - 1 {
                if abs(dispStore.displacements![i].u[0]) > maxDispX {
                    maxDispX = abs(dispStore.displacements![i].u[0])
                }
                if abs(dispStore.displacements![i].u[1]) > maxDispY {
                    maxDispY = abs(dispStore.displacements![i].u[1])
                }
                if abs(dispStore.displacements![i].u[2]) > maxDispZ {
                    maxDispZ = abs(dispStore.displacements![i].u[2])
                }
            }
            if dx > small {
                 ratioX = maxDispX / dx
            } else {
                ratioX = maxDispX / maxDimension
            }
            
            if dy > small {
                 ratioY = maxDispY / dy
            } else {
                ratioY = maxDispY / maxDimension
            }
            
            if dz > small {
                 ratioZ = maxDispZ / dz
            } else {
                ratioZ = maxDispZ / maxDimension
            }
            
            maxRatio = max(ratioX, ratioY, ratioZ)
            magFactor = percent / maxRatio
        }

        if debugFlag {
            print(" maxDispX \(maxDispX)  maxDispY \(maxDispY) maxDispZ \(maxDispZ)")
            print("dx \(dx) dy \(dy) dz \(dz)")
            print("ratioX \(ratioX) ratioY \(ratioY) ratioZ \(ratioZ)")
            print("maxRatio \(maxRatio)")
            print("magFactor \(magFactor)")
        }

        
        return magFactor
    }
 
    func characteristicModelDimensions(nodesStore: NodesStore) -> [Double] {
        
        var output: [Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        var minX : Double = nodesStore.nodes[0].xcoord
        var maxX : Double = nodesStore.nodes[0].xcoord
        var minY : Double = nodesStore.nodes[0].ycoord
        var maxY : Double = nodesStore.nodes[0].ycoord
        var minZ : Double = nodesStore.nodes[0].zcoord
        var maxZ : Double = nodesStore.nodes[0].zcoord
        
        for i in 0...nodesStore.nodes.count - 1 {
            if nodesStore.nodes[i].xcoord < minX {
                minX = nodesStore.nodes[i].xcoord
            }
            if nodesStore.nodes[i].xcoord > maxX {
                maxX = nodesStore.nodes[i].xcoord
            }
            if nodesStore.nodes[i].ycoord < minY {
                minY = nodesStore.nodes[i].ycoord
            }
            if nodesStore.nodes[i].ycoord > maxY {
                maxY = nodesStore.nodes[i].ycoord
            }
            if nodesStore.nodes[i].zcoord < minZ {
                minZ = nodesStore.nodes[i].zcoord
            }
            if nodesStore.nodes[i].zcoord > maxZ {
                maxZ = nodesStore.nodes[i].zcoord
            }
        }
        
        let dx = maxX - minX
        let dy = maxY - minY
        let dz = maxZ - minZ
        

        
        var maxDimension : Double
        
        if (dx > dy && dx > dz) {
            maxDimension = dx
        } else if ( dy > dx && dy > dz) {
            maxDimension = dy
        } else if ( dz > dx && dz > dy) {
            maxDimension = dz
        } else {
            maxDimension = 10
        }
        
        maxDimension = max(dx,dy,dz)
        
        output[0] = minX
        output[1] = maxX
        output[2] = minY
        output[3] = maxY
        output[4] = minZ
        output[5] = maxZ
        output[6] = maxDimension
        output[7] = dx
        output[8] = dy
        output[9] = dz
        
        if debugFlag {
            print("In characteristicModelDimensions")
            print("minX \(minX) maxX \(maxX)")
            print("minY \(minY) maxY \(maxY)")
            print("minZ \(minZ) maxZ \(maxZ)")
            print("maxDimension \(maxDimension)")
            print("dx \(dx) dy \(dy) dz \(dz)")

        }
        return output
        
    }

    func findViewPoint(nodesStore: NodesStore) -> SCNVector3 {
        
        var characteristicDimensions: [Double]
        
        characteristicDimensions = characteristicModelDimensions(nodesStore: nodesStore)
        
        let minX : Double = characteristicDimensions[0]
        let maxX : Double = characteristicDimensions[1]
        let minY : Double = characteristicDimensions[2]
        let maxY : Double = characteristicDimensions[3]
        let minZ : Double = characteristicDimensions[4]
        let maxZ : Double = characteristicDimensions[5]
        let maxDimension : Double = characteristicDimensions[6]

        
        let xViewPoint = (minX + maxX)/2
        let yViewPoint = (minY + maxY)/2

        let zViewPoint =  max(maxZ,minZ) + maxDimension

        if debugFlag {
            print(" in findViewPoint")
            print("xViewPoint \(xViewPoint) yViewPoint \(yViewPoint) zViewPoint \(zViewPoint)")
        }
        
        return SCNVector3(x: Float(xViewPoint), y: Float(yViewPoint), z: Float(zViewPoint))
    }
    
    
    func viewModelAll(nodesStore: NodesStore, truss2DStore: Truss2DStore, frame2DStore: Frame2DStore, truss3DStore: Truss3DStore, frame3DStore: Frame3DStore, dispStore: DispStore, bcStore: BCStore,  loadStore: LoadStore, scene:SCNScene) {
        
        
        let dimensions = self.characteristicModelDimensions(nodesStore: nodesStore)
        let magFactor = self.setMagFactor(dispStore: dispStore, maxDimension: dimensions[6], dx: dimensions[7], dy: dimensions[8], dz: dimensions[9], percent: 0.1)
        let maxDimension = dimensions[6]
        self.nodeRadius = CGFloat(0.1 * maxDimension/10)
        self.elementRadius = 0.75 * self.nodeRadius
        
        print("In viewModelAll")
//MARK: - REMOVING ALL NODES BEFORE REDRAWING
        scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        
        self.viewNodes(nodesStore: nodesStore, dispStore: dispStore, magFactor: magFactor, scene: scene)
        self.viewBCs(bcStore: bcStore, nodesStore: nodesStore, dims: dimensions, scene: scene)
        self.viewTruss2DElements(modelStore: truss2DStore, nodesStore: nodesStore, dispStore: dispStore, magFactor: magFactor, scene: scene)
        self.viewFrame2DElements(modelElements: frame2DStore, nodesStore: nodesStore, dispStore: dispStore, magFactor: magFactor, scene: scene)
        self.viewTruss3DElements(modelStore: truss3DStore, nodesStore: nodesStore, dispStore: dispStore, magFactor: magFactor, scene: scene)
        self.viewFrame3DElements(modelStore: frame3DStore, nodesStore: nodesStore, dispStore: dispStore, magFactor: magFactor, scene: scene)
        self.viewLoads(loadStore: loadStore, nodesStore: nodesStore, dims: dimensions, scene: scene)
        
    }
    
    
       func viewNodes(nodesStore: NodesStore, dispStore: DispStore, magFactor: Double, scene:SCNScene){
            for i in 0...nodesStore.nodes.count-1 {
               let newSphere = SCNSphere(radius: nodeRadius)
               newSphere.firstMaterial?.diffuse.contents = self.nodeColor
               let newSCNNode = SCNNode(geometry: newSphere)
               newSCNNode.position = SCNVector3(nodesStore.nodes[i].xcoord,nodesStore.nodes[i].ycoord,nodesStore.nodes[i].zcoord)
               scene.rootNode.addChildNode(newSCNNode)
               
               
               if dispStore.displacements?.count != nil {
                   let newDefSphere = SCNSphere(radius: nodeRadius)
                   newDefSphere.firstMaterial?.diffuse.contents = self.defnodeColor
                   let newDefSCNNode = SCNNode(geometry: newSphere)
            
                   newDefSCNNode.position =
                    SCNVector3(nodesStore.nodes[i].xcoord + magFactor * dispStore.displacements![i].u[0],
                               nodesStore.nodes[i].ycoord + magFactor * dispStore.displacements![i].u[1],
                               nodesStore.nodes[i].zcoord + magFactor * dispStore.displacements![i].u[2])
                
//                print("x positions \(nodesStore.nodes[i].xcoord + magFactor * dispStore.displacements![i].u[0])")
                
                   scene.rootNode.addChildNode(newDefSCNNode)

               }
           }
    
           
       }
 
    func viewBCs(bcStore: BCStore, nodesStore: NodesStore, dims: [Double], scene:SCNScene){
        
        
        if bcStore.bcs.count > 0 {
            for i in 0...bcStore.bcs.count - 1 {
                
                
                let direction = bcStore.bcs[i].bcDirection
                let node = bcStore.bcs[i].bcNode
                
                let newCylinder = SCNCylinder(radius: self.nodeRadius, height: 2 * self.nodeRadius)
                newCylinder.firstMaterial?.diffuse.contents = self.bcColor
                let newTorus = SCNTorus(ringRadius: 0.8 * self.nodeRadius, pipeRadius: 0.33 * self.nodeRadius)
                newTorus.firstMaterial?.diffuse.contents = self.bcColor
                let newDispSCNNode = SCNNode(geometry: newCylinder)
                let newRotSCNNode = SCNNode(geometry: newTorus)
                
                // find center of object
                let xCenter = (dims[1] - dims[0]) / 2.0
                let yCenter = (dims[3] - dims[2]) / 2.0
                let zCenter = (dims[5] - dims[4]) / 2.0

                
                let initialX = nodesStore.nodes[node].xcoord
                let initialY = nodesStore.nodes[node].ycoord
                let initialZ = nodesStore.nodes[node].zcoord
                
                
                let vecToCenter = SCNVector3(xCenter - initialX, yCenter - initialY, zCenter - initialZ)
                let shift = 2 * Double(nodeRadius)
                
                
                if direction == 0 {
                    if vecToCenter.x > 0 {
                        newDispSCNNode.position = SCNVector3(initialX - shift, initialY , initialZ)
                    } else {
                        newDispSCNNode.position = SCNVector3(initialX + shift, initialY , initialZ)
                    }
                    newDispSCNNode.rotation = SCNVector4(1.0, 0, 0, Double.pi/2)
                    scene.rootNode.addChildNode(newDispSCNNode)
                }
                
                else if direction == 1 {
                    if vecToCenter.y >= 0 {
                        newDispSCNNode.position = SCNVector3(initialX , initialY - shift, initialZ)
                    } else {
                        newDispSCNNode.position = SCNVector3(initialX , initialY + shift , initialZ)
                    }
                    newDispSCNNode.rotation = SCNVector4(1.0, 0, 0, Double.pi/2)
                    scene.rootNode.addChildNode(newDispSCNNode)
                }
                 else if direction == 2 {
                    if vecToCenter.z > 0 {
                        newDispSCNNode.position = SCNVector3(initialX , initialY , initialZ - shift)
                    } else {
                        newDispSCNNode.position = SCNVector3(initialX , initialY , initialZ + shift)
                    }
                    newDispSCNNode.rotation = SCNVector4(0, 0, 1.0, Double.pi/2)
                    scene.rootNode.addChildNode(newDispSCNNode)
                }
                else if direction > 2  && direction <= 5 {
                    newRotSCNNode.rotation = SCNVector4(1.0, 0, 0, Double.pi/2)
                    newRotSCNNode.position = SCNVector3(initialX, initialY, initialZ)
                    scene.rootNode.addChildNode(newRotSCNNode)
                }
    

                
                
            }
        }
    }
 

    func viewLoads(loadStore: LoadStore, nodesStore: NodesStore, dims: [Double], scene:SCNScene){
        
        
        if loadStore.loads.count > 0 {
            for i in 0...loadStore.loads.count - 1 {
                
                
                let direction = loadStore.loads[i].loadDirection
                let node = loadStore.loads[i].loadNode
                let value = loadStore.loads[i].loadValue
                
                let newCone = SCNCone(topRadius: 0, bottomRadius: self.nodeRadius, height: 2 * self.nodeRadius)
                newCone.firstMaterial?.diffuse.contents = self.loadColor
                
                let newLoadSCNNode = SCNNode(geometry: newCone)
                
                // find center of object
                let xCenter = (dims[1] - dims[0]) / 2.0
                let yCenter = (dims[3] - dims[2]) / 2.0
                let zCenter = (dims[5] - dims[4]) / 2.0
                
                
                let initialX = nodesStore.nodes[node].xcoord
                let initialY = nodesStore.nodes[node].ycoord
                let initialZ = nodesStore.nodes[node].zcoord
                
                
                let vecToCenter = SCNVector3(xCenter - initialX, yCenter - initialY, zCenter - initialZ)
                let shift = 2 * Double(nodeRadius)
                
                
                if direction == 0 {
                    if vecToCenter.x > 0 {
                        newLoadSCNNode.position = SCNVector3(initialX - shift, initialY , initialZ)
                    } else {
                        newLoadSCNNode.position = SCNVector3(initialX + shift, initialY , initialZ)
                    }
                    newLoadSCNNode.rotation = SCNVector4(0, 0, 1.0,  sign(-value) * Double.pi/2)
                    scene.rootNode.addChildNode(newLoadSCNNode)
                }
                    
                else if direction == 1 {
                    if vecToCenter.y >= 0 {
                        newLoadSCNNode.position = SCNVector3(initialX , initialY + shift, initialZ)
                    } else {
                        newLoadSCNNode.position = SCNVector3(initialX , initialY + shift , initialZ)
                    }
                    if sign(value) <= 0 {
                        newLoadSCNNode.rotation = SCNVector4(1.0, 0, 0, sign(-value) * Double.pi)
                    }
                    scene.rootNode.addChildNode(newLoadSCNNode)
                }
                else if direction == 2 {
                    if vecToCenter.z > 0 {
                        newLoadSCNNode.position = SCNVector3(initialX , initialY , initialZ - shift)
                    } else {
                        newLoadSCNNode.position = SCNVector3(initialX , initialY , initialZ + shift)
                    }
                    newLoadSCNNode.rotation = SCNVector4(1.0, 0, 0, sign(value) * Double.pi/2)
                    scene.rootNode.addChildNode(newLoadSCNNode)
                }
                
                
                
                
                
            }
        }
    }
        


    func viewTruss2DElements(modelStore: Truss2DStore, nodesStore: NodesStore, dispStore: DispStore, magFactor: Double, scene:SCNScene) {
        if modelStore.truss2DElements.count > 0 {
            for i in 0...modelStore.truss2DElements.count-1 {
                
                
//                print("Element: \(i)")

                let node1 = modelStore.truss2DElements[i].node1
                let node2 = modelStore.truss2DElements[i].node2
                
//                print("node1: \(node1) node2: \(node2)")
                
                var dx = nodesStore.nodes[node2].xcoord - nodesStore.nodes[node1].xcoord
                var dy = nodesStore.nodes[node2].ycoord - nodesStore.nodes[node1].ycoord
                var dz = nodesStore.nodes[node2].zcoord - nodesStore.nodes[node1].zcoord
                
                
                var len = CGFloat( sqrt( dx * dx + dy * dy + dz * dz ) )
                
                let newCylinder = SCNCylinder(radius: elementRadius, height: len)
                newCylinder.firstMaterial?.diffuse.contents = self.truss2DElementColor
                let newSCNNode = SCNNode(geometry: newCylinder)
                let angle = Float(angleOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0))
                let vector = axisOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0)
                newSCNNode.rotation = SCNVector4(vector.x,vector.y,vector.z,angle)
                newSCNNode.position = SCNVector3(
                    (nodesStore.nodes[node2].xcoord + nodesStore.nodes[node1].xcoord)/2,
                    (nodesStore.nodes[node2].ycoord + nodesStore.nodes[node1].ycoord)/2,
                    (nodesStore.nodes[node2].zcoord + nodesStore.nodes[node1].zcoord)/2)
                
//                print("angle: \(angle)")
//                print("vector: \(vector)")
//                print("rotation: \(newSCNNode.rotation)")
//                print("position: \(newSCNNode.position)")
                
                scene.rootNode.addChildNode(newSCNNode)
                
                
                if dispStore.displacements?.count != nil {
                    dx = (nodesStore.nodes[node2].xcoord + magFactor * dispStore.displacements![node2].u[0])
                        - (nodesStore.nodes[node1].xcoord + magFactor * dispStore.displacements![node1].u[0])
                    
                    dy = (nodesStore.nodes[node2].ycoord + magFactor * dispStore.displacements![node2].u[1])
                        - (nodesStore.nodes[node1].ycoord + magFactor * dispStore.displacements![node1].u[1])
                    
                    dz = nodesStore.nodes[node2].zcoord + magFactor * dispStore.displacements![node2].u[2]
                        - nodesStore.nodes[node1].zcoord + magFactor * dispStore.displacements![node1].u[2]
                    
                    
                    len = CGFloat( sqrt( dx * dx + dy * dy + dz * dz ) )
                    
                    
                    let newDefCylinder = SCNCylinder(radius: elementRadius, height: len)
                    newDefCylinder.firstMaterial?.diffuse.contents = self.defTruss2DElementColor
                    let newDefSCNNode = SCNNode(geometry: newDefCylinder)
                    let angle = Float(angleOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0))
                    let vector = axisOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0)
                    newDefSCNNode.rotation = SCNVector4(vector.x,vector.y,vector.z,angle)
                    newDefSCNNode.position = SCNVector3(
                        (nodesStore.nodes[node2].xcoord + magFactor * dispStore.displacements![node2].u[0] + nodesStore.nodes[node1].xcoord + magFactor * dispStore.displacements![node1].u[0])/2,
                        
                        (nodesStore.nodes[node2].ycoord + magFactor * dispStore.displacements![node2].u[1] + nodesStore.nodes[node1].ycoord + magFactor * dispStore.displacements![node1].u[1])/2,
                        
                        (nodesStore.nodes[node2].zcoord + magFactor * dispStore.displacements![node2].u[2] + nodesStore.nodes[node1].zcoord + magFactor * dispStore.displacements![node1].u[2])/2)
                    
                    scene.rootNode.addChildNode(newDefSCNNode)
                    
                }
                
            }
            
        }
    }
 
    
    func viewFrame2DElements(modelElements: Frame2DStore, nodesStore: NodesStore,dispStore: DispStore, magFactor: Double, scene:SCNScene) {
        if modelElements.frame2DElements.count > 0 {
            for i in 0...modelElements.frame2DElements.count-1 {
                        
                            let node1 = modelElements.frame2DElements[i].node1
                            let node2 = modelElements.frame2DElements[i].node2
                            
                            var dx = nodesStore.nodes[node2].xcoord - nodesStore.nodes[node1].xcoord
                            var dy = nodesStore.nodes[node2].ycoord - nodesStore.nodes[node1].ycoord
                            var dz = nodesStore.nodes[node2].zcoord - nodesStore.nodes[node1].zcoord


                            var len = CGFloat( sqrt( dx * dx + dy * dy + dz * dz ) )
                            
                            let newCylinder = SCNCylinder(radius: elementRadius, height: len)
                            newCylinder.firstMaterial?.diffuse.contents = self.frame2DElementColor
                            let newSCNNode = SCNNode(geometry: newCylinder)
                            let angle = Float(angleOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0))
                            let vector = axisOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0)
                            newSCNNode.rotation = SCNVector4(vector.x,vector.y,vector.z,angle)
                            newSCNNode.position = SCNVector3(
                              (nodesStore.nodes[node2].xcoord + nodesStore.nodes[node1].xcoord)/2,
                                (nodesStore.nodes[node2].ycoord + nodesStore.nodes[node1].ycoord)/2,
                                (nodesStore.nodes[node2].zcoord + nodesStore.nodes[node1].zcoord)/2)

                            scene.rootNode.addChildNode(newSCNNode)
                            
                            if dispStore.displacements?.count != nil {
                                dx = (nodesStore.nodes[node2].xcoord + magFactor * dispStore.displacements![node2].u[0])
                                    - (nodesStore.nodes[node1].xcoord + magFactor * dispStore.displacements![node1].u[0])
                                
                                dy = (nodesStore.nodes[node2].ycoord + magFactor * dispStore.displacements![node2].u[1])
                                    - (nodesStore.nodes[node1].ycoord + magFactor * dispStore.displacements![node1].u[1])
                                
                                dz = nodesStore.nodes[node2].zcoord + magFactor * dispStore.displacements![node2].u[2]
                                    - nodesStore.nodes[node1].zcoord + magFactor * dispStore.displacements![node1].u[2]


                                len = CGFloat( sqrt( dx * dx + dy * dy + dz * dz ) )
                                
//                                print("len \(len)")
                                
                                let newDefCylinder = SCNCylinder(radius: elementRadius, height: len)
                                newDefCylinder.firstMaterial?.diffuse.contents = self.defFrame2DElementColor
                                let newDefSCNNode = SCNNode(geometry: newDefCylinder)
                                let angle = Float(angleOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0))
                                let vector = axisOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0)
                                newDefSCNNode.rotation = SCNVector4(vector.x,vector.y,vector.z,angle)
                                newDefSCNNode.position = SCNVector3(
                                  (nodesStore.nodes[node2].xcoord + magFactor * dispStore.displacements![node2].u[0] + nodesStore.nodes[node1].xcoord + magFactor * dispStore.displacements![node1].u[0])/2,
                                  
                                  (nodesStore.nodes[node2].ycoord + magFactor * dispStore.displacements![node2].u[1] + nodesStore.nodes[node1].ycoord + magFactor * dispStore.displacements![node1].u[1])/2,
                                    
                                  (nodesStore.nodes[node2].zcoord + magFactor * dispStore.displacements![node2].u[2] + nodesStore.nodes[node1].zcoord + magFactor * dispStore.displacements![node1].u[2])/2)

                                scene.rootNode.addChildNode(newDefSCNNode)
                                
                            }
                            
                        }
                        
            }


    }
  
    
    func viewTruss3DElements(modelStore: Truss3DStore, nodesStore: NodesStore, dispStore: DispStore, magFactor: Double, scene:SCNScene) {
        if modelStore.truss3DElements.count > 0 {
            for i in 0...modelStore.truss3DElements.count-1 {
                
                let node1 = modelStore.truss3DElements[i].node1
                let node2 = modelStore.truss3DElements[i].node2
                
                var dx = nodesStore.nodes[node2].xcoord - nodesStore.nodes[node1].xcoord
                var dy = nodesStore.nodes[node2].ycoord - nodesStore.nodes[node1].ycoord
                var dz = nodesStore.nodes[node2].zcoord - nodesStore.nodes[node1].zcoord
                
                
                var len = CGFloat( sqrt( dx * dx + dy * dy + dz * dz ) )
                
                let newCylinder = SCNCylinder(radius: elementRadius, height: len)
                newCylinder.firstMaterial?.diffuse.contents = self.truss3DElementColor
                let newSCNNode = SCNNode(geometry: newCylinder)
                let angle = Float(angleOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0))
                let vector = axisOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0)
                newSCNNode.rotation = SCNVector4(vector.x,vector.y,vector.z,angle)
                newSCNNode.position = SCNVector3(
                    (nodesStore.nodes[node2].xcoord + nodesStore.nodes[node1].xcoord)/2,
                    (nodesStore.nodes[node2].ycoord + nodesStore.nodes[node1].ycoord)/2,
                    (nodesStore.nodes[node2].zcoord + nodesStore.nodes[node1].zcoord)/2)
                
                scene.rootNode.addChildNode(newSCNNode)
                
                
                if dispStore.displacements?.count != nil {
                    dx = (nodesStore.nodes[node2].xcoord + magFactor * dispStore.displacements![node2].u[0])
                        - (nodesStore.nodes[node1].xcoord + magFactor * dispStore.displacements![node1].u[0])
                    
                    dy = (nodesStore.nodes[node2].ycoord + magFactor * dispStore.displacements![node2].u[1])
                        - (nodesStore.nodes[node1].ycoord + magFactor * dispStore.displacements![node1].u[1])
                    
                    dz = nodesStore.nodes[node2].zcoord + magFactor * dispStore.displacements![node2].u[2]
                        - nodesStore.nodes[node1].zcoord + magFactor * dispStore.displacements![node1].u[2]
                    
                    
                    len = CGFloat( sqrt( dx * dx + dy * dy + dz * dz ) )
                    
                    
                    let newDefCylinder = SCNCylinder(radius: elementRadius, height: len)
                    newDefCylinder.firstMaterial?.diffuse.contents = self.defTruss3DElementColor
                    let newDefSCNNode = SCNNode(geometry: newDefCylinder)
                    let angle = Float(angleOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0))
                    let vector = axisOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0)
                    newDefSCNNode.rotation = SCNVector4(vector.x,vector.y,vector.z,angle)
                    newDefSCNNode.position = SCNVector3(
                        (nodesStore.nodes[node2].xcoord + magFactor * dispStore.displacements![node2].u[0] + nodesStore.nodes[node1].xcoord + magFactor * dispStore.displacements![node1].u[0])/2,
                        
                        (nodesStore.nodes[node2].ycoord + magFactor * dispStore.displacements![node2].u[1] + nodesStore.nodes[node1].ycoord + magFactor * dispStore.displacements![node1].u[1])/2,
                        
                        (nodesStore.nodes[node2].zcoord + magFactor * dispStore.displacements![node2].u[2] + nodesStore.nodes[node1].zcoord + magFactor * dispStore.displacements![node1].u[2])/2)
                    
                    scene.rootNode.addChildNode(newDefSCNNode)
                    
                }
                
            }
            
        }
    }

    
    func viewFrame3DElements(modelStore: Frame3DStore, nodesStore: NodesStore, dispStore: DispStore, magFactor: Double, scene:SCNScene) {
        if modelStore.frame3DElements.count > 0 {
            for i in 0...modelStore.frame3DElements.count-1 {
                
                let node1 = modelStore.frame3DElements[i].node1
                let node2 = modelStore.frame3DElements[i].node2
                
                var dx = nodesStore.nodes[node2].xcoord - nodesStore.nodes[node1].xcoord
                var dy = nodesStore.nodes[node2].ycoord - nodesStore.nodes[node1].ycoord
                var dz = nodesStore.nodes[node2].zcoord - nodesStore.nodes[node1].zcoord
                
                
                var len = CGFloat( sqrt( dx * dx + dy * dy + dz * dz ) )
                
                let newCylinder = SCNCylinder(radius: elementRadius, height: len)
                newCylinder.firstMaterial?.diffuse.contents = self.frame3DElementColor
                let newSCNNode = SCNNode(geometry: newCylinder)
                let angle = Float(angleOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0))
                let vector = axisOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0)
                newSCNNode.rotation = SCNVector4(vector.x,vector.y,vector.z,angle)
                newSCNNode.position = SCNVector3(
                    (nodesStore.nodes[node2].xcoord + nodesStore.nodes[node1].xcoord)/2,
                    (nodesStore.nodes[node2].ycoord + nodesStore.nodes[node1].ycoord)/2,
                    (nodesStore.nodes[node2].zcoord + nodesStore.nodes[node1].zcoord)/2)
                
                scene.rootNode.addChildNode(newSCNNode)
                
                
                if dispStore.displacements?.count != nil {
                    dx = (nodesStore.nodes[node2].xcoord + magFactor * dispStore.displacements![node2].u[0])
                        - (nodesStore.nodes[node1].xcoord + magFactor * dispStore.displacements![node1].u[0])
                    
                    dy = (nodesStore.nodes[node2].ycoord + magFactor * dispStore.displacements![node2].u[1])
                        - (nodesStore.nodes[node1].ycoord + magFactor * dispStore.displacements![node1].u[1])
                    
                    dz = nodesStore.nodes[node2].zcoord + magFactor * dispStore.displacements![node2].u[2]
                        - nodesStore.nodes[node1].zcoord + magFactor * dispStore.displacements![node1].u[2]
                    
                    
                    len = CGFloat( sqrt( dx * dx + dy * dy + dz * dz ) )
                    
                    
                    let newDefCylinder = SCNCylinder(radius: elementRadius, height: len)
                    newDefCylinder.firstMaterial?.diffuse.contents = self.defFrame3DElementColor
                    let newDefSCNNode = SCNNode(geometry: newDefCylinder)
                    let angle = Float(angleOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0))
                    let vector = axisOfRotation(a1: dx, a2: dy, a3: dz, b1: 0, b2: 1, b3: 0)
                    newDefSCNNode.rotation = SCNVector4(vector.x,vector.y,vector.z,angle)
                    newDefSCNNode.position = SCNVector3(
                        (nodesStore.nodes[node2].xcoord + magFactor * dispStore.displacements![node2].u[0] + nodesStore.nodes[node1].xcoord + magFactor * dispStore.displacements![node1].u[0])/2,
                        
                        (nodesStore.nodes[node2].ycoord + magFactor * dispStore.displacements![node2].u[1] + nodesStore.nodes[node1].ycoord + magFactor * dispStore.displacements![node1].u[1])/2,
                        
                        (nodesStore.nodes[node2].zcoord + magFactor * dispStore.displacements![node2].u[2] + nodesStore.nodes[node1].zcoord + magFactor * dispStore.displacements![node1].u[2])/2)
                    
                    scene.rootNode.addChildNode(newDefSCNNode)
                    
                }
                
            }
            
        }
    }
  

    
    func angleOfRotation(a1:Double, a2: Double, a3: Double, b1: Double, b2: Double, b3: Double) -> Double {
        let lena = sqrt(a1*a1 + a2*a2 + a3*a3)
        let lenb = sqrt(b1*b1 + b2*b2 + b3*b3)
        let angle = acos( (a1*b1 + a2*b2 + a3*b3)/(lena*lenb) )
        return -angle
        
    }
 
    
    func axisOfRotation(a1:Double, a2: Double, a3: Double, b1: Double, b2: Double, b3: Double) -> SCNVector3 {
        let lena = sqrt(a1*a1 + a2*a2 + a3*a3)
        let lenb = sqrt(b1*b1 + b2*b2 + b3*b3)
        let a1 = a1/lena
        let a2 = a2/lena
        let a3 = a3/lena
        let b1 = b1/lenb
        let b2 = b2/lenb
        let b3 = b3/lenb
        let c1 = (a2*b3 - a3*b2)
        let c2 = (a3*b1 - a1*b3)
        let c3 = (a1*b2 - a2*b1)
        let vec: SCNVector3 = SCNVector3(c1,c2,c3)
        return vec
        
    }
    


}
