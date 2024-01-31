//
//  NodeRow.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct NodeRow : View {
    
    var node: Node
    var body: some View {
        HStack {
            Text("#: \(node.id)").font(.custom("Arial", size: 25))
            Spacer()
            Text("X: " + String(format: "%.2f",self.node.xcoord)).font(.custom("Arial", size: 20))
            Spacer()
            Text("Y: " + String(format: "%.2f",self.node.ycoord)).font(.custom("Arial", size: 20))
            Spacer()
            Text("Z: " + String(format: "%.2f",self.node.zcoord)).font(.custom("Arial", size: 20))
            Spacer()

            
        }
    }
}
#Preview(traits: .landscapeLeft) {
    ContentView()
}
/*
 #if DEBUG
 struct NodeRow_Previews : PreviewProvider {
 static var previews: some View {
 NodeRow(node: Node(id: 0))
 }
 }
 #endif
 */
