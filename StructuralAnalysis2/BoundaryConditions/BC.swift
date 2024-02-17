//
//  BC.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/15/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Foundation
import SwiftUI

struct BC: Decodable, Encodable, Identifiable {
    var id: Int
    var bcNode: Int
    var bcDirection: Int
    var bcValue: Double
    
    enum CodingKeys: CodingKey {
        case id
        case bcNode
        case bcDirection
        case bcValue
    }
}
