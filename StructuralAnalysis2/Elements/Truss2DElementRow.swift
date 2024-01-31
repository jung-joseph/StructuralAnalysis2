//
//  OneDElementRow.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/2/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Truss2DElementRow: View {
    
    var truss2DEl: Truss2D
    var body: some View {
        VStack (alignment: .leading) {
            HStack{
                Text("#:    \(truss2DEl.id)").font(.custom("Arial", size: 20))
                Spacer()
                Text("MatID:          \(truss2DEl.matID)").font(.custom("Arial", size: 20))
                Spacer()
                Text("PropID:         \(truss2DEl.propertiesID)").font(.custom("Arial", size: 20))
                Spacer()
            }

            Text("Connectivity:  \(truss2DEl.node1)  \(truss2DEl.node2)").font(.custom("Arial", size: 20))
          
        }
    }
}

#if DEBUG
struct OneDElementRow_Previews: PreviewProvider {
    static var previews: some View {
        Truss2DElementRow(truss2DEl: Truss2D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 1, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), truss2DStore: Truss2DStore() ) )
    }
}
#endif
