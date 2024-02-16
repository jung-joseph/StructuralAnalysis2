//
//  Displacements.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/21/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Foundation

struct NodalDisp : Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id
        case u
    }
    var id : Int
    var u : [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
 
}
