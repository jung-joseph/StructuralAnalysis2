//
//  Material.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/24/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Foundation
import SwiftUI

struct Material: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case id
        case youngsModulus
        case shearModulus
    }
    
    var id: Int
    var youngsModulus: Double = 0.0
    var shearModulus: Double = 0.0
    
}
