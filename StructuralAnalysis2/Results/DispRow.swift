//
//  DispRow.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/21/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import SwiftUI

struct DispRow: View {
    
    var nodalDisp: NodalDisp
    
    var body: some View {
        VStack{
            HStack{
                Text("#: \(nodalDisp.id)").font(.custom("Arial", size: 20))
                Spacer()
            }
            HStack{
                Text("u:     " + String(format: "%.3e",self.nodalDisp.u[0])).font(.custom("Arial", size: 20))
                Spacer()
                Text("v:     " + String(format: "%.3e",self.nodalDisp.u[1])).font(.custom("Arial", size: 20))
                Spacer()
                Text("w:     " + String(format: "%.3e",self.nodalDisp.u[2])).font(.custom("Arial", size: 20))
                Spacer()
            }
            HStack{
                Text("thetaXX: " + String(format: "%.3e",self.nodalDisp.u[3])).font(.custom("Arial", size: 20))
                Spacer()
                Text("thetaYY: " + String(format: "%.3e",self.nodalDisp.u[4])).font(.custom("Arial", size: 20))
                Spacer()
                Text("thetaZZ: " + String(format: "%.3e",self.nodalDisp.u[5])).font(.custom("Arial", size: 20))
                Spacer()
            }


        }
    }
}
#Preview(traits: .landscapeLeft) {
    DispRow(nodalDisp: NodalDisp(id: 0))
}
/*
 struct DispRow_Previews: PreviewProvider {
 static var previews: some View {
 DispRow(nodalDisp: NodalDisp(id: 0))
 }
 }
 */
