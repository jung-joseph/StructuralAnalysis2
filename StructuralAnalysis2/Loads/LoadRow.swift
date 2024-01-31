//
//  LoadRow.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/16/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct LoadRow: View {
    
    let directions = [0 : "X", 1 : "Y", 2 : "Z", 3 : "XX", 4 : "YY", 5 : "ZZ"]
    var load: Load
    var body: some View {
        VStack {
            HStack{
                Text("#: \(load.id)").font(.custom("Arial", size: 20))
                Spacer()
                Text("Node: \(load.loadNode)").font(.custom("Arial", size: 20))
                Spacer()
            }
            HStack{
                Text("Direction: \(directions[load.loadDirection]!)").font(.custom("Arial", size: 20))
                Spacer()
                Text("Value: \(load.loadValue)").font(.custom("Arial", size: 20))
                Spacer()
            }

        }
    }
}
#Preview(traits: .landscapeLeft) {
    LoadRow(load: Load(id: 0, loadNode: 0, loadDirection: 0, loadValue: 0))
}
/*
#if DEBUG
struct LoadRow_Previews: PreviewProvider {
    static var previews: some View {
        LoadRow(load: Load(id: 0, loadNode: 0, loadDirection: 0, loadValue: 0))
    }
}
#endif
*/
