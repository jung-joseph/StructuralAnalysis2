//
//  SolutionControlView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/17/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct SolutionControlView: View {
    
    
    @Bindable var nodesStore : NodesStore
    @Bindable var truss2DStore : Truss2DStore
    @Bindable var frame2DStore : Frame2DStore
    @Bindable var truss3DStore : Truss3DStore
    @Bindable var frame3DStore : Frame3DStore
    @Bindable var materialStore : MaterialStore
    @Bindable var elPropertyStore : ElPropertyStore
    @Bindable var bcStore: BCStore
    @Bindable var loadStore: LoadStore
    @Bindable var dispStore : DispStore // Create Displacement Store

    @State private var createdSystemMatrix = false
    @State private var formedElementStiffness = false
    @State private var formedSystemStiffness = false
    @State private var boundaryConditionsApplied = false
    @State private var loadsApplied = false
    @State private var equationsSolved = false
    @State private var debugFlag: Bool = false



    var body: some View {
            VStack {

                Button(action: {
                        
//                    let debugFlag: Bool = false  //debug Flag
                    
                        // Scan all elements to determine the number of dofs for each node, nodesStore.nodes[].numdof, and store the index for the first dof for each node
                    self.nodesStore.scanNodesForNumDof(nodesStore: self.nodesStore, truss2DStore: self.truss2DStore, frame2DStore: self.frame2DStore, truss3DStore: self.truss3DStore, frame3DStore: self.frame3DStore)
                    
                        // Create the system matrix
                    let systemMatrix = Gauss(neq: self.nodesStore.totalNumDofs)
                        
                        self.createdSystemMatrix = true
                        
                        print(" Created  \(systemMatrix.neq) Equations" )
                        
                        // Form element Stiffness matrices and assemble for truss2d elements
                    if self.truss2DStore.truss2DElements.count > 0 {
                        for i in 0...self.truss2DStore.truss2DElements.count - 1 {
                            let matid = self.truss2DStore.truss2DElements[i].matID
                            let youngsMod = self.materialStore.materials[matid].youngsModulus
                            let propid = self.truss2DStore.truss2DElements[i].propertiesID
                            let area = self.elPropertyStore.elProperties[propid].area
                            let node1 = self.truss2DStore.truss2DElements[i].node1
                            let node2 = self.truss2DStore.truss2DElements[i].node2
                            let node1Object = self.nodesStore.nodes[node1]
                            let node2Object = self.nodesStore.nodes[node2]
                            
                            if self.debugFlag {
                                print("truss2dElStiff \(i)")
                            }

                            let len = self.truss2DStore.truss2DElements[i].length
                        
                            let truss2dElStiff = self.truss2DStore.truss2DElements[i].elStiffMatrix(node1: node1Object, node2: node2Object, youngsM: youngsMod, crossArea: area, len: len)
                            
                            if self.debugFlag {
                                print("len \(len)")
                                print("\(truss2dElStiff)")
                            }

                            self.truss2DStore.truss2DElements[i].assemble(system: systemMatrix, elStiff: truss2dElStiff, nodesStore: self.nodesStore)
                        }
                    }
                    // Form element Stiffness matrices and assemble for frame2d elements
                    if self.frame2DStore.numFrame2DElements > 0 {
                        for i in 0...self.frame2DStore.numFrame2DElements - 1 {
                            let matid = self.frame2DStore.frame2DElements[i].matID
                            let youngsMod = self.materialStore.materials[matid].youngsModulus
                            let propid = self.frame2DStore.frame2DElements[i].propertiesID
                            let area = self.elPropertyStore.elProperties[propid].area
                            let izz = self.elPropertyStore.elProperties[propid].iZZ
                            let node1 = self.frame2DStore.frame2DElements[i].node1
                            let node2 = self.frame2DStore.frame2DElements[i].node2
                            let node1Object = self.nodesStore.nodes[node1]
                            let node2Object = self.nodesStore.nodes[node2]

                            let len = self.frame2DStore.frame2DElements[i].length
                        
                            let frame2DElStiff = self.frame2DStore.frame2DElements[i].elStiffMatrix(node1: node1Object, node2: node2Object, youngsM: youngsMod, crossArea: area, len: len, izz: izz)
                            
                            if self.debugFlag {
                                print("frame2dElStiff \(i)")
                                print("\(frame2DElStiff)")
                            }

                            
                            self.frame2DStore.frame2DElements[i].assemble(system: systemMatrix, elStiff: frame2DElStiff, nodesStore: self.nodesStore)
                            

                        }
                    }
                    
                        // Form element Stiffness matrices and assemble for truss3d elements
                    if self.truss3DStore.numTruss3DElements > 0 {
                        for i in 0...self.truss3DStore.numTruss3DElements - 1 {
                            let matid = self.truss3DStore.truss3DElements[i].matID
                            let youngsMod = self.materialStore.materials[matid].youngsModulus
                            let propid = self.truss3DStore.truss3DElements[i].propertiesID
                            let area = self.elPropertyStore.elProperties[propid].area
                            let node1 = self.truss3DStore.truss3DElements[i].node1
                            let node2 = self.truss3DStore.truss3DElements[i].node2
                            let node1Object = self.nodesStore.nodes[node1]
                            let node2Object = self.nodesStore.nodes[node2]
                            
                            if self.debugFlag {
                                print("truss3dElStiff \(i)")
                            }

                            let len = self.truss3DStore.truss3DElements[i].length
                        
                            let truss3dElStiff = self.truss3DStore.truss3DElements[i].elStiffMatrix(node1: node1Object, node2: node2Object, youngsM: youngsMod, crossArea: area, len: len)
                            
                            if self.debugFlag {
                                print("len \(len)")
                                print("\(truss3dElStiff)")
                            }

                            self.truss3DStore.truss3DElements[i].assemble(system: systemMatrix, elStiff: truss3dElStiff, nodesStore: self.nodesStore)
                        }
                    }
                    
                    // Form element Stiffness matrices and assemble for frame3d elements
                    if self.frame3DStore.numFrame3DElements > 0 {
                        for i in 0...self.frame3DStore.numFrame3DElements - 1 {
                            let matid = self.frame3DStore.frame3DElements[i].matID
                            let youngsMod = self.materialStore.materials[matid].youngsModulus
                            let G = self.materialStore.materials[matid].shearModulus
                            let propid = self.frame3DStore.frame3DElements[i].propertiesID
                            let area = self.elPropertyStore.elProperties[propid].area
                            let izz = self.elPropertyStore.elProperties[propid].iZZ
                            let iyy = self.elPropertyStore.elProperties[propid].iYY
                            let iJ = self.elPropertyStore.elProperties[propid].iJ
                            let node1 = self.frame3DStore.frame3DElements[i].node1
                            let node2 = self.frame3DStore.frame3DElements[i].node2
                            let node1Object = self.nodesStore.nodes[node1]
                            let node2Object = self.nodesStore.nodes[node2]

                            let len = self.frame3DStore.frame3DElements[i].length
                        
                            let frame3DElStiff = self.frame3DStore.frame3DElements[i].elStiffMatrix(node1: node1Object, node2: node2Object, youngsM: youngsMod, G: G, crossArea: area, len: len, izz: izz, iyy: iyy, ixx: iJ)
                            
                            if self.debugFlag {
                                print("frame3dElStiff \(i)")
                                print("\(frame3DElStiff)")
                            }

                            
                            self.frame3DStore.frame3DElements[i].assemble(system: systemMatrix, elStiff: frame3DElStiff, nodesStore: self.nodesStore)
                            

                        }
                    }
                    
                    if self.debugFlag {
                        print("SystemMatrix")
                        systemMatrix.printAMatrix()

                    }
                    
                        self.formedSystemStiffness = true

                        // Apply Boundary Conditions
                        
                    self.bcStore.applyBoundaryConditions(system: systemMatrix, nodesStore: self.nodesStore)
//                        self.bcStore.printBCs()
                        self.boundaryConditionsApplied = true

                    if self.debugFlag {
                        print("Boundary Conditions Applied")
                        systemMatrix.printAMatrix()
                        systemMatrix.printBVector()
                    }

                        
                        
                        // Apply Loads
                        
                    self.loadStore.applyLoads(system: systemMatrix, nodesStore: self.nodesStore)
//                        self.loadStore.printLoads()
                        self.loadsApplied = true
                    
                    if self.debugFlag {
                        print("Loads Applied")
                        systemMatrix.printAMatrix()
                        systemMatrix.printBVector()
                    }


                        // Solve Equations
                        
                        let x = systemMatrix.gaussSolve()
                        self.equationsSolved = true
                        
                    if self.debugFlag{
                        systemMatrix.printSolution()
                    }

                        
                        // pass solution to DispStore
                        

                    // if the displacement array has already been used, delete the displacments Array before filling it again with results
                    if self.dispStore.displacements != nil {
                        self.dispStore.displacements = nil
                    }
                        

                    self.dispStore.fillDispStore(x: x, nodesStore: self.nodesStore, truss2DStore: self.truss2DStore, frame2DStore: self.frame2DStore, truss3DStore: self.truss3DStore, frame3DStore: self.frame3DStore)
                    self.dispStore.printDispStore(numNodes: self.nodesStore.nodes.count)
                        
                        
                })  {Text ("Perform Solution Procedure").font(.title)}
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10  )
                HStack {
                    Spacer()
                    Toggle(isOn: $debugFlag){
                        Text("Debug Flag")
                    }
                }

                
                if(createdSystemMatrix) {
                    Text("Created  Equations" ).animation(Animation.linear(duration: 0.5).delay(0.0)).foregroundColor(.green)
                }
                if(formedElementStiffness) {
                    Text("Formed Element Stiffness Matrices " ).animation(Animation.linear(duration: 0.5).delay(0.5)).foregroundColor(.green)
                }
                if(formedSystemStiffness) {
                    Text("Formed System Stiffness Matrix " ).animation(Animation.linear(duration: 0.5).delay(1.5)).foregroundColor(.green)
                }
                if(boundaryConditionsApplied) {
                    Text("Boundary Conditions Applied " ).animation(Animation.linear(duration: 0.5).delay(2.0)).foregroundColor(.green)
                }
                if(loadsApplied) {
                    Text("Loads Applied " ).animation(Animation.linear(duration: 0.5).delay(2.5)).foregroundColor(.green)
                }
                if(equationsSolved) {
                    Text("Solution Found " ).animation(Animation.linear(duration: 0.5).delay(3.0)).foregroundColor(.green)
                }
                Spacer()
        }
        

    }
}

#if DEBUG
struct SolutionControlView_Previews: PreviewProvider {
    static var previews: some View {
        SolutionControlView(nodesStore: NodesStore(), truss2DStore: Truss2DStore(), frame2DStore: Frame2DStore(), truss3DStore: Truss3DStore(), frame3DStore: Frame3DStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), bcStore: BCStore(), loadStore: LoadStore(), dispStore: DispStore() )
    }
}
#endif
