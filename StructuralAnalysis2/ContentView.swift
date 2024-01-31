//
//  ContentView.swift
//  StructuralAnalysis
//
//  Created by Joseph Jung on 1/23/24.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    @State var scene:ModelScene = ModelScene()
    @State var nodesStore: NodesStore = NodesStore()
    @State var dispStore: DispStore = DispStore()
    @State var materialStore: MaterialStore = MaterialStore()
    @State var elPropertyStore: ElPropertyStore = ElPropertyStore()
    @State var truss2DStore: Truss2DStore = Truss2DStore()
    @State var frame2DStore: Frame2DStore = Frame2DStore()
    @State var truss3DStore: Truss3DStore = Truss3DStore()
    @State var frame3DStore: Frame3DStore = Frame3DStore()
    @State var loadStore: LoadStore = LoadStore()
    @State var bcStore: BCStore = BCStore()
//    @State var magFactor: Double = 1.0
//    @State var drawModel: DrawModel = DrawModel(nodeRadius: CGFloat(0.1), elementRadius: CGFloat(0.1))
    
    @State var showMaterialsList: Bool = false
    @State var showNodesList: Bool = false
    @State var showElPropertiesList: Bool = false
    @State var showElLibraryList: Bool = false
    @State var showBCList: Bool = false
    @State var showLoadsList: Bool = false
    @State var showSolutionControl: Bool = false
    @State var showDisplacements: Bool = false
    @State var showModelView: Bool = false
    
    
    var body: some View {
        
            
        HStack{
            
            
                VStack(alignment: .leading) {
                    Text("Problem Definition")
                        .font(.largeTitle)
                        .frame(minWidth: 250)
                        .padding()
                    
                    Button(action: {
                        showMaterialsList.toggle()
                    }, label: {
                        Text("Material Properties (\(materialStore.materials.count))")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action: {
                        showNodesList.toggle()
                    }, label: {
                        Text("Nodes (\(nodesStore.nodes.count))")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
 
                    Button(action: {
                        showElPropertiesList.toggle()
                    }, label: {
                        Text("Element Properties (\(elPropertyStore.elProperties.count))")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action: {
                        showElLibraryList.toggle()
                    }, label: {
                        Text("Elements (\(truss2DStore.truss2DElements.count + frame2DStore.frame2DElements.count + truss3DStore.truss3DElements.count + frame3DStore.frame3DElements.count))")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action: {
                        showBCList.toggle()
                    }, label: {
                        Text("Boundary Conditions (\(bcStore.bcs.count))")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action: {
                        showLoadsList.toggle()
                    }, label: {
                        Text("Loads (\(loadStore.loads.count))")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action: {
                        showSolutionControl.toggle()
                    }, label: {
                        Text("Solution Control")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action: {
                        showDisplacements.toggle()
                    }, label: {
                        Text("Displacements")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action: {
                        showModelView.toggle()
                    }, label: {
                        Text("Model View")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Spacer()
                }
               
            
            
            ModelView(scene: $scene, nodesStore: nodesStore, dispStore: dispStore, bcStore: bcStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, loadStore: loadStore)
                .onAppear(perform: {
                    print("ModelView appeared")
                })
                
            
            Spacer()
            Spacer()
        }
        
        .sheet(isPresented: $showMaterialsList, content: {
            MaterialsList(materialStore: materialStore)
            .presentationDragIndicator(.visible)})
               
        .sheet(isPresented: $showNodesList, content: {
            NodeList(scene: $scene,nodesStore: nodesStore,truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore)
            .presentationDragIndicator(.visible)})
        
        .sheet(isPresented: $showElPropertiesList, content: {
            ElPropertyList(elPropertyStore: elPropertyStore)
            .presentationDragIndicator(.visible)})
        
        .sheet(isPresented: $showElLibraryList, content: {
            ElementTypeView(scene: $scene, nodesStore: nodesStore, truss2DStore: truss2DStore,  frame2DStore: frame2DStore, truss3DStore: truss3DStore,frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore)
            .presentationDragIndicator(.visible)})

        
        .sheet(isPresented: $showLoadsList, content: {
            LoadList(loadStore: loadStore)
            .presentationDragIndicator(.visible)})
        
        .sheet(isPresented: $showSolutionControl, content: {
            SolutionControlView(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, materialStore: materialStore, elPropertyStore: elPropertyStore, bcStore: bcStore, loadStore: loadStore, dispStore: dispStore)
//        })
        .presentationDragIndicator(.visible)})
        
        .sheet(isPresented: $showDisplacements, content: {
            DispList(dispStore: dispStore)
            .presentationDragIndicator(.visible)})
        
        .sheet(isPresented: $showModelView, content: {
            ModelView(scene: $scene, nodesStore: nodesStore, dispStore: dispStore, bcStore: bcStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, loadStore: loadStore)
            .presentationDragIndicator(.visible)})
    }
}
func createCameraNode() -> SCNNode {
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    cameraNode.camera?.automaticallyAdjustsZRange = true
    return cameraNode
}
#Preview(traits: .landscapeLeft) {
    ContentView()
}
