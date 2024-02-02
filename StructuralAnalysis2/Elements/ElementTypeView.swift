//
//  ElementTypeView.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/6/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct ElementTypeView: View {
    @Binding var scene: ModelScene
    @Bindable var nodesStore : NodesStore
    @Bindable var truss2DStore : Truss2DStore
    @Bindable var frame2DStore : Frame2DStore
    @Bindable var truss3DStore : Truss3DStore
    @Bindable var frame3DStore : Frame3DStore
    @Bindable var dispStore: DispStore
    @Bindable var bcStore: BCStore
    @Bindable var loadStore: LoadStore
    @Bindable var materialStore: MaterialStore
    @Bindable var elPropertyStore: ElPropertyStore
    
    var body: some View {
        NavigationStack {
            List{
                
                NavigationLink(destination: Truss2DList(scene:$scene, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore))  {Text("Truss2D Elements (\(truss2DStore.truss2DElements.count))").foregroundColor(.blue)}
                
                
                NavigationLink(destination: Frame2DList(scene:$scene, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore))
                    {Text("Frame2D Elements (\(frame2DStore.frame2DElements.count))").foregroundColor(.blue)}
                
                NavigationLink(destination: Truss3DList(scene:$scene, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore))  {Text("Truss3D Elements (\(truss3DStore.truss3DElements.count))").foregroundColor(.blue)}
                
                
                NavigationLink(destination: Frame3DList(scene:$scene, nodesStore: nodesStore, truss2DStore: truss2DStore, frame2DStore: frame2DStore, truss3DStore: truss3DStore, frame3DStore: frame3DStore, dispStore: dispStore, bcStore: bcStore, loadStore: loadStore, materialStore: materialStore, elPropertyStore: elPropertyStore))  {Text("Frame3D Elements (\(frame3DStore.frame3DElements.count))").foregroundColor(.blue)}
                
                
            } // List
        } // navigation
        .navigationBarTitle(Text("Element Library"))

    } //body
}
#Preview(traits: .landscapeLeft) {
    ContentView()
}
/*
struct ElementTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ElementTypeView(nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), truss2DStore: Truss2DStore(), frame2DStore: Frame2DStore(), truss3DStore: Truss3DStore(), frame3DStore: Frame3DStore())
    }
}
*/
