//
//  Node.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Foundation
import SwiftUI

struct Node: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case id
        case xcoord
        case ycoord
        case zcoord
        case numDof
        case beginDofIndex
    }
    var id: Int
    var xcoord: Double = 0.0
    var ycoord: Double = 0.0
    var zcoord: Double = 0.0
    var numDof: Int = 0
    var beginDofIndex: Int = 0
}

