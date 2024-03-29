//
//  ElProperty.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 7/30/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Foundation
import SwiftUI

struct ElProperty: Decodable, Encodable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case id
        case area
        case iZZ
        case iYY
        case iXY
        case iJ
    }
    
    var id: Int
    var area: Double = 0.0
    var iZZ: Double = 0.0
    var iYY: Double = 0.0
    var iXY: Double = 0.0
    var iJ: Double = 0.0

}
