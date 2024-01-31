//
//  Truss3DElementRow.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/5/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Truss3DElementRow: View {
    
    var truss3DEl: Truss3D
    var body: some View {
        VStack (alignment: .leading) {
            HStack{
                Text("#:    \(truss3DEl.id)").font(.custom("Arial", size: 20))
                Spacer()
                Text("MatID:          \(truss3DEl.matID)").font(.custom("Arial", size: 20))
                Spacer()
                Text("PropID:         \(truss3DEl.propertiesID)").font(.custom("Arial", size: 20))
                Spacer()
            }

            Text("Connectivity:  \(truss3DEl.node1)  \(truss3DEl.node2)").font(.custom("Arial", size: 20))
          
        }
    }
}

#if DEBUG
struct Truss3DElementRow_Previews: PreviewProvider {
    static var previews: some View {
        Truss3DElementRow(truss3DEl: Truss3D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 1, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), truss3DStore: Truss3DStore() ) )
    }
}
#endif
