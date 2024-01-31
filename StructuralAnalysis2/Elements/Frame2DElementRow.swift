//
//  Frame2DElementRow.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/26/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct Frame2DElementRow: View {
    
    var frame2DEl: Frame2D
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("#:    \(frame2DEl.id)").font(.custom("Arial", size: 20))
                Spacer()
                Text("MatID:          \(frame2DEl.matID)").font(.custom("Arial", size: 20))
                Spacer()
                Text("PropID:         \(frame2DEl.propertiesID)").font(.custom("Arial", size: 20))
                Spacer()
            }
            HStack{
            Text("Connectivity: " ).font(.custom("Arial", size: 20))
                if frame2DEl.pin1 {
                    Text("\(frame2DEl.node1)").foregroundColor(.red).font(.custom("Arial", size: 20))
                } else {
                    Text("\(frame2DEl.node1)").foregroundColor(.black).font(.custom("Arial", size: 20))
                }
                 if frame2DEl.pin2 {
                    Text("\(frame2DEl.node2)").foregroundColor(.red).font(.custom("Arial", size: 20))
                } else {
                    Text("\(frame2DEl.node2)").foregroundColor(.black).font(.custom("Arial", size: 20))
                }
            }
          
            
            
        }
    }
}

#if DEBUG
struct Frame2DElementRow_Previews: PreviewProvider {
    static var previews: some View {
        Frame2DElementRow(frame2DEl: Frame2D(id:0, matID: 0, propertiesID: 0, node1: 0, node2: 1, pin1: false, pin2: false, nodesStore: NodesStore(), materialStore: MaterialStore(), elPropertyStore: ElPropertyStore(), frame2DStore: Frame2DStore() ) )
    }
}
#endif
