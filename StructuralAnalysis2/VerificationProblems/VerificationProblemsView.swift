//
//  VerificationProblemsView.swift
//  StructuralAnalysis2
//
//  Created by Joseph Jung on 9/2/24.
//

import SwiftUI
import SceneKit
import FilePicker


struct VerificationProblemsView: View {
    
//    @ObservedObject var verificationProblems = VerificationProblems()
    @State var  verificationProblems = VerificationProblems()
    
    @Binding var scene: ModelScene
    @Bindable var nodesStore : NodesStore
    @Bindable var truss2DStore: Truss2DStore
    @Bindable var frame2DStore: Frame2DStore
    @Bindable var truss3DStore: Truss3DStore
    @Bindable var frame3DStore: Frame3DStore
    @Bindable var materialStore: MaterialStore
    @Bindable var elPropertyStore: ElPropertyStore
    @Bindable var dispStore: DispStore
    @Bindable var bcStore: BCStore
    @Bindable var loadStore: LoadStore
    
    var body: some View {
        VStack {
            Spacer()
            Text("Verification and Example Problems")
                .bold()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .font(.system(size: 40))
            
            
            HStack{
                
                Button(action: {
                    
                    // clear displacements
                    dispStore.displacements = nil
                    
                    let verificationProblem = verificationProblems.oneElementBar
                    if let model = try? JSONDecoder().decode(Model.self, from: (verificationProblem!) ){
                        
                        truss2DStore.truss2DElements = model.truss2DStore.truss2DElements
                        frame2DStore.frame2DElements = model.frame2DStore.frame2DElements
                        truss3DStore.truss3DElements = model.truss3DStore.truss3DElements
                        frame3DStore.frame3DElements = model.frame3DStore.frame3DElements
                        nodesStore.nodes = model.nodesStore.nodes
                        materialStore.materials = model.materialStore.materials
                        elPropertyStore.elProperties = model.elPropertyStore.elProperties
                        bcStore.bcs = model.bcStore.bcs
                        loadStore.loads = model.loadStore.loads
                        
                        
                        // recalculate element lengths for models not created in the app, i.e, models created via a json file
                        
                        calElementLengths(truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, nodesStore: nodesStore)
                        
                        // refresh graphics
                        scene = ModelScene()
                        
                        
                        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }
                }, label: {
                    Text("One Element Bar ")
                })
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding()
                
                
                
                Button(action: {
                    
                    // clear displacements
                    dispStore.displacements = nil
                    
                    let verificationProblem = verificationProblems.twoElementBar
                    if let model = try? JSONDecoder().decode(Model.self, from: (verificationProblem!) ){
                        
                        truss2DStore.truss2DElements = model.truss2DStore.truss2DElements
                        frame2DStore.frame2DElements = model.frame2DStore.frame2DElements
                        truss3DStore.truss3DElements = model.truss3DStore.truss3DElements
                        frame3DStore.frame3DElements = model.frame3DStore.frame3DElements
                        nodesStore.nodes = model.nodesStore.nodes
                        materialStore.materials = model.materialStore.materials
                        elPropertyStore.elProperties = model.elPropertyStore.elProperties
                        bcStore.bcs = model.bcStore.bcs
                        loadStore.loads = model.loadStore.loads
                        
                        
                        // recalculate element lengths for models not created in the app, i.e, models created via a json file
                        
                        calElementLengths(truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, nodesStore: nodesStore)
                        
                        // refresh graphics
                        scene = ModelScene()
                        
                        
                        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }
                }, label: {
                    Text("Two Element Bar ")
                })
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding()
            }
            HStack{
                Button(action: {
                    
                    // clear displacements
                    dispStore.displacements = nil
                    
                    let verificationProblem = verificationProblems.threeSpanBeam
                    if let model = try? JSONDecoder().decode(Model.self, from: (verificationProblem!) ){
                        
                        truss2DStore.truss2DElements = model.truss2DStore.truss2DElements
                        frame2DStore.frame2DElements = model.frame2DStore.frame2DElements
                        truss3DStore.truss3DElements = model.truss3DStore.truss3DElements
                        frame3DStore.frame3DElements = model.frame3DStore.frame3DElements
                        nodesStore.nodes = model.nodesStore.nodes
                        materialStore.materials = model.materialStore.materials
                        elPropertyStore.elProperties = model.elPropertyStore.elProperties
                        bcStore.bcs = model.bcStore.bcs
                        loadStore.loads = model.loadStore.loads
                        
                        
                        // recalculate element lengths for models not created in the app, i.e, models created via a json file
                        
                        calElementLengths(truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, nodesStore: nodesStore)
                        
                        // refresh graphics
                        scene = ModelScene()
                        
                        
                        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }
                }, label: {
                    Text("Three Span Beam ")
                })
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding()
                
                
                Button(action: {
                    
                    // clear displacements
                    dispStore.displacements = nil
                    
                    let verificationProblem = verificationProblems.twoDTruss
                    if let model = try? JSONDecoder().decode(Model.self, from: (verificationProblem!) ){
                        
                        truss2DStore.truss2DElements = model.truss2DStore.truss2DElements
                        frame2DStore.frame2DElements = model.frame2DStore.frame2DElements
                        truss3DStore.truss3DElements = model.truss3DStore.truss3DElements
                        frame3DStore.frame3DElements = model.frame3DStore.frame3DElements
                        nodesStore.nodes = model.nodesStore.nodes
                        materialStore.materials = model.materialStore.materials
                        elPropertyStore.elProperties = model.elPropertyStore.elProperties
                        bcStore.bcs = model.bcStore.bcs
                        loadStore.loads = model.loadStore.loads
                        
                        
                        // recalculate element lengths for models not created in the app, i.e, models created via a json file
                        
                        calElementLengths(truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, nodesStore: nodesStore)
                        
                        // refresh graphics
                        scene = ModelScene()
                        
                        
                        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }
                }, label: {
                    Text("2D Truss ")
                })
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding()
            }
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    
                    // clear displacements
                    dispStore.displacements = nil
                    
                    let verificationProblem = verificationProblems.solleksRiverBridge
                    if let model = try? JSONDecoder().decode(Model.self, from: (verificationProblem!) ){
                        
                        truss2DStore.truss2DElements = model.truss2DStore.truss2DElements
                        frame2DStore.frame2DElements = model.frame2DStore.frame2DElements
                        truss3DStore.truss3DElements = model.truss3DStore.truss3DElements
                        frame3DStore.frame3DElements = model.frame3DStore.frame3DElements
                        nodesStore.nodes = model.nodesStore.nodes
                        materialStore.materials = model.materialStore.materials
                        elPropertyStore.elProperties = model.elPropertyStore.elProperties
                        bcStore.bcs = model.bcStore.bcs
                        loadStore.loads = model.loadStore.loads
                        
                        
                        // recalculate element lengths for models not created in the app, i.e, models created via a json file
                        
                        calElementLengths(truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, nodesStore: nodesStore)
                        
                        // refresh graphics
                        scene = ModelScene()
                        
                        
                        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }
                }, label: {
                    Text("SolleksRiverBridge ")
                })
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding()
                
                Spacer()
            }
            Spacer()
            Spacer()
        }
            
            
        
        
    }
}

//#Preview {
//    VerificationProblemsView()
//}
