//
//  Frame3DRowElementRow.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 9/8/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Frame3DElementRow: View {
    
    var frame3DEl: Frame3D
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("#:    \(frame3DEl.id)").font(.custom("Arial", size: 20))
                Spacer()
                Text("MatID:          \(frame3DEl.matID)").font(.custom("Arial", size: 20))
                Spacer()
                Text("PropID:         \(frame3DEl.propertiesID)").font(.custom("Arial", size: 20))
                Spacer()
            }
            HStack{
            Text("Connectivity: " ).font(.custom("Arial", size: 20))
                if frame3DEl.pin1 {
                    Text("\(frame3DEl.node1)").foregroundColor(.red).font(.custom("Arial", size: 20))
                } else {
                    Text("\(frame3DEl.node1)").foregroundColor(.black).font(.custom("Arial", size: 20))
                }
                 if frame3DEl.pin2 {
                    Text("\(frame3DEl.node2)").foregroundColor(.red).font(.custom("Arial", size: 20))
                } else {
                    Text("\(frame3DEl.node2)").foregroundColor(.black).font(.custom("Arial", size: 20))
                }
            }
          
            
            
        }
    }
}

#if DEBUG
struct Frame3DElementRow_Previews: PreviewProvider {
    static var previews: some View {
        Frame3DElementRow(frame3DEl: Frame3D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 1, pin1: false, pin2: false, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), frame3DStore: Frame3DStore() ) )
    }
}
#endif
