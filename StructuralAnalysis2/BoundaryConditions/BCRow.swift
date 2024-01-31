//
//  BCRow.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct BCRow: View {
    
    let directions = [0 : "X", 1 : "Y", 2 : "Z", 3 : "XX", 4 : "YY", 5 : "ZZ"]
    var bc: BC
    var body: some View {
        VStack {
            HStack {
                Text("#: \(bc.id)").font(.custom("Arial", size: 20))
                Spacer()
                Text("Node: \(bc.bcNode)").font(.custom("Arial", size: 20))
                Spacer()
            }
            HStack {
                Text("Direction: \(directions[bc.bcDirection]!)").font(.custom("Arial", size: 20))
                Spacer()
                Text("Value: " + String(format: "%.2f",self.bc.bcValue) ).font(.custom("Arial", size: 20))
                Spacer()
            }

        }
    }
}
#Preview(traits: .landscapeLeft) {
    BCRow(bc: BC(id: 0, bcNode: 0, bcDirection: 0, bcValue: 0))
}
/*
#if DEBUG
struct BCRow_Previews: PreviewProvider {
    static var previews: some View {
        BCRow(bc: BC(id: 0, bcNode: 0, bcDirection: 0, bcValue: 0))
    }
}
#endif
*/
