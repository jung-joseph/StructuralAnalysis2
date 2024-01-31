//
//  ElPropertyRow.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/30/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct ElPropertyRow: View {
    
    var elProperty: ElProperty
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("#: \(elProperty.id)").font(.custom("Arial", size: 20))
                Spacer()
                Text("Area:  " + String(format: "%.2f",self.elProperty.area)).font(.custom("Arial", size: 20))
                Spacer()
            }
            HStack {
                Text("IZZ:   " + String(format: "%.2f",self.elProperty.iZZ) ).font(.custom("Arial", size: 20))
                Spacer()
                Text("IYY:   " + String(format: "%.2f",self.elProperty.iYY) ).font(.custom("Arial", size: 20))
                Spacer()
                Text("IXY:   " + String(format: "%.2f",self.elProperty.iXY) ).font(.custom("Arial", size: 20))
                Spacer()
                Text("J:      " + String(format: "%.2f", self.elProperty.iJ) ).font(.custom("Arial", size: 20))
                Spacer()
            }

            
        }
       
    }
}

#if DEBUG
struct ElPropertyRow_Previews: PreviewProvider {
    static var previews: some View {
        ElPropertyRow(elProperty: ElProperty(id: 0))
    }
}
#endif
