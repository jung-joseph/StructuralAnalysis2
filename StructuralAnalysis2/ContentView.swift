//
//  ContentView.swift
//  StructuralAnalysis
//
//  Created by Joseph Jung on 1/23/24.
//

import SwiftUI
import SceneKit
import FilePicker

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
    @State var showDisplacementsView: Bool = false
    @State var showModelView: Bool = false
    @State var showSaveModelView: Bool = false
    @State var showLoadModelView: Bool = false
    
    @State var showDisplacements: Bool = true
    
    enum CodingKeys: CodingKey {
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
    
    var body: some View {
        
            
        HStack{
            
            
                VStack(alignment: .leading) {
                    Text("Problem Definition")
                        .font(.largeTitle)
                        .frame(minWidth: 250)
                        .padding()

                    Button(action: {
                        materialStore = MaterialStore()
                        elPropertyStore = ElPropertyStore()
                        truss2DStore = Truss2DStore()
                        frame2DStore = Frame2DStore()
                        truss3DStore = Truss3DStore()
                        frame3DStore = Frame3DStore()
                        loadStore = LoadStore()
                        bcStore = BCStore()
                        dispStore = DispStore()
                        nodesStore = NodesStore()
                        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }, label: {
                        Text("Clear Model")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action: {
                        showNodesList.toggle()
                    }, label: {
                        Text("Nodes (\(nodesStore.nodes.count))")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action: {
                        showElLibraryList.toggle()
                    }, label: {
                        Text("Elements (\(truss2DStore.truss2DElements.count + frame2DStore.frame2DElements.count + truss3DStore.truss3DElements.count + frame3DStore.frame3DElements.count))")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action: {
                        showMaterialsList.toggle()
                    }, label: {
                        Text("Material Properties (\(materialStore.materials.count))")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })

 
                    Button(action: {
                        showElPropertiesList.toggle()
                    }, label: {
                        Text("Element Properties (\(elPropertyStore.elProperties.count))")
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
                        if dispStore.displacements != nil {
                            scene.drawModel.viewModelAll(showDisplacements: showDisplacements, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                        }
                    }, label: {
                        Text("Show Displaced Shape")
                            .foregroundColor((dispStore.displacements != nil) ? .green : .gray)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    Button(action: {
                        showDisplacementsView.toggle()
                    }, label: {
                        Text("Displacements")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button {
                        showSaveModelView = true
                    } label: {
                        Text("Save Model")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }

                    FilePicker(types: [.plainText], allowMultiple: false, title: "Load A Saved Model" ){ urls in
                        print("selected \(urls.count) file(s)")
                        print("URL: \(urls[0])")

//                       clear displacments
                        dispStore.displacements = nil
                        
                        let fileUrl = urls[0]
                        if let dataIn = try? Data(contentsOf: fileUrl){
                            print("Sucessful Data call")
                            if  let model = try? JSONDecoder().decode(Model.self, from: (dataIn) ){
                                
                                print("model nodes: \(model.nodesStore.nodes)")
                                self.nodesStore = model.nodesStore
                                self.materialStore = model.materialStore
                                self.elPropertyStore = model.elPropertyStore
                                self.truss2DStore = model.truss2DStore
                                self.frame2DStore = model.frame2DStore
                                self.truss3DStore = model.truss3DStore
                                self.frame3DStore = model.frame3DStore
                                self.loadStore = model.loadStore
                                self.bcStore = model.bcStore
// refresh graphics
                                scene = ModelScene()
                                
                                scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                            } else {
                                print("Decoder Failure")
                            }

                        } else {
                            print("Data call Failure")
                        }
                        
                        
                    }
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

                    Button(action: {
                        scene = ModelScene()
                        
                        scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                    }, label: {
                        Text("Refresh Model View")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    Spacer()
                }
               
            
            
            ModelView(scene: $scene, nodesStore: nodesStore, dispStore: dispStore, bcStore: bcStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, loadStore: loadStore)
                .onAppear(perform: {
                    print("ModelView appeared in ContentView")
                    
                })
                .onChange(of: scene.rootNode.geometry) {
                    print("scene geometry changed in ContentView")
                }
                .onChange(of: scene.rootNode.childNodes.count){
                    print("scene childNodes changed in ContentView")
                    scene = ModelScene()
                    
                    scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                }
            
                
            
            Spacer()
            Spacer()
        }
        
        .sheet(isPresented: $showMaterialsList, content: {
            MaterialsList(materialStore: materialStore)
            .presentationDragIndicator(.visible)})
               
        .sheet(isPresented: $showNodesList, content: {
            NodeList(scene: $scene,nodesStore: nodesStore,truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore)
                .onDisappear(perform: {
                    scene.drawModel.viewModelAll(showDisplacements: false, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
                })
                
            .presentationDragIndicator(.visible)})
        
        
        .sheet(isPresented: $showElPropertiesList, content: {
            ElPropertyList(elPropertyStore: elPropertyStore)
            .presentationDragIndicator(.visible)})
        
        .sheet(isPresented: $showElLibraryList, content: {
            ElementTypeView(scene: $scene, nodesStore: nodesStore, truss2DStore: truss2DStore,  frame2DStore: frame2DStore, truss3DStore: truss3DStore,frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore)
            .presentationDragIndicator(.visible)})
        
        .sheet(isPresented: $showBCList, content: {
            BCList(scene: $scene, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore)
                .presentationDragIndicator(.visible)
        })
        
        .sheet(isPresented: $showLoadsList, content: {
            LoadList(scene: $scene, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore)
            .presentationDragIndicator(.visible)})
        
        .sheet(isPresented: $showSolutionControl, content: {
            SolutionControlView(scene: $scene, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, materialStore: materialStore, elPropertyStore: elPropertyStore, bcStore: bcStore, loadStore: loadStore, dispStore: dispStore)
//                .onDisappear(perform: {
//                    print("viewModelAll called")
//                    scene.drawModel.viewModelAll(nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, scene: scene)
//                })
//        })
        .presentationDragIndicator(.visible)})
       
       
        
        .sheet(isPresented: $showDisplacementsView, content: {
            DispList(dispStore: dispStore)
            .presentationDragIndicator(.visible)})
        
        .sheet(isPresented: $showSaveModelView) {
            SaveModelView(nodesStore: nodesStore, dispStore: dispStore, materialStore: materialStore, elPropertyStore: elPropertyStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, loadStore: loadStore, bcStore: bcStore, showSaveModelView: $showSaveModelView)
        }
        

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
