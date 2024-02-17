//
//  Loads.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/16/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Foundation
import SwiftUI

struct Load: Codable, Identifiable{
    
    enum CodingKeys: CodingKey {
        case id
        case loadNode
        case loadDirection
        case loadValue
    }
    
    var id: Int
    var loadNode: Int
    var loadDirection: Int
    var loadValue: Double
}
