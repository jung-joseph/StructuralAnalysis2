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
    var id: Int
    var loadNode: Int
    var loadDirection: Int
    var loadValue: Double
}
