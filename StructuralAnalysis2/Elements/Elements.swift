//
//  File.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/1/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Foundation
import SwiftUI
import simd

class Elements: Codable {
 
    
    //MARK: - Properties
    
    var numNodesPerEl : Int
    var numDOFPerNode : Int
    var elementType : String
    var connectivity = [[Int]]()
    var elementStiffness = [[Double]]()
    
    enum CodingKeys: CodingKey {
        case numNodesPerEl
        case numDOFPerNode
        case elementType
        case connectivity
//        case elementStiffness
    }
    
//    @ObservedObject var nodesStore : NodesStore
//    @ObservedObject var materialStore : MaterialStore
//    @ObservedObject var elPropertyStore : ElPropertyStore


    
    //MARK: - initialization
    
    init(numNodes: Int, numDOF: Int, eltype: String) {

        numNodesPerEl = numNodes
        numDOFPerNode = numDOF
        elementType = "eltype"

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.numNodesPerEl = try container.decode(Int.self, forKey: .numNodesPerEl)
        self.numDOFPerNode = try container.decode(Int.self, forKey: .numDOFPerNode)
        self.elementType = try container.decode(String.self, forKey: .elementType)
        self.connectivity = try container.decode([[Int]].self, forKey: .connectivity)
//        self.elementStiffness = try container.decode([[Double]].self, forKey: .elementStiffness)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(numNodesPerEl, forKey: .numNodesPerEl)
        try container.encode(numDOFPerNode, forKey: .numDOFPerNode)
        try container.encode(elementType, forKey: .elementType)
        try container.encode(connectivity, forKey: .connectivity)
//        try container.encode(elementStiffness, forKey: .elementStiffness)
    }
    func angleOfRotation(node1: Node, node2: Node, axis: String) -> Double {
        
        var a1: Double
        var a2: Double
        var a3: Double
        
        if (axis == "X" || axis == "x") {
            a1 = 1.0
            a2 = 0.0
            a3 = 0.0
        } else if (axis == "Y" || axis == "y") {
            a1 = 0.0
            a2 = 1.0
            a3 = 0.0
        }
        else if (axis == "Z" || axis == "z") {
            a1 = 0.0
            a2 = 0.0
            a3 = 1.0
        } else {
            a1 = 1.0
            a2 = 0.0
            a3 = 0.0
        }
        var b1 = node2.xcoord - node1.xcoord
        var b2 = node2.ycoord - node1.ycoord
        var b3 = node2.zcoord - node1.zcoord
        
      
        let lena = sqrt(a1*a1 + a2*a2 + a3*a3)
        let lenb = sqrt(b1*b1 + b2*b2 + b3*b3)
        
        a1 = a1/lena
        a2 = a2/lena
        a3 = a3/lena
        
        b1 = b1/lenb
        b2 = b2/lenb
        b3 = b3/lenb
        
        let dot = (a1*b1 + a2*b2 + a3*b3)
        
        var angle = acos( dot )
        
        if ( b1 <= 0.0 && b2 <= 0.0 ){ // quadrant 3
            angle = -angle
        } else if ( b1 >= 0.0 && b2 <= 0.0 ){  // quadrant 4
            angle = -angle
        }
        
        return (angle)
        
    }
    
    func directionalCosines(node1: Node, node2: Node, axis: String) -> [Double]  {
        

        
        let x1 = 1.0

        
        let y2 = 1.0
        

        let z3 = 1.0

        let b1 = node2.xcoord - node1.xcoord
        let b2 = node2.ycoord - node1.ycoord
        let b3 = node2.zcoord - node1.zcoord
        
        let lenb = sqrt(b1*b1 + b2*b2 + b3*b3)
    
        let cosx = (x1*b1/lenb)
        let cosy = (y2*b2/lenb)
        let cosz = (z3*b3/lenb)
        
        return [cosx, cosy, cosz]
        
    }

    func transpose(_ matrix: [[Double]]) -> [[Double]] {
        let rowCount = matrix.count
        let colCount = matrix[0].count
        var transposed : [[Double]] = Array(repeating: Array(repeating: 0.0, count: rowCount), count: colCount)
        for rowPos in 0..<matrix.count {
            for colPos in 0..<matrix[0].count {
                transposed[colPos][rowPos] = matrix[rowPos][colPos]
            }
        }
        return transposed
    }
     
    func multiply(_ A: [[Double]], _ B: [[Double]]) -> [[Double]] {
        let rowCount = A.count
        let colCount = B[0].count
        var product : [[Double]] = Array(repeating: Array(repeating: 0.0, count: colCount), count: rowCount)
        for rowPos in 0..<rowCount {
            for colPos in 0..<colCount {
                for i in 0..<B.count {
                    product[rowPos][colPos] += A[rowPos][i] * B[i][colPos]
                }
            }
        }
        return product
    }
}


//MARK: - Truss2D Element

class Truss2D: Elements, Identifiable {
    
    //MARK: - Properties
    
    // Inherting:elPropertyStore,materialStore,nodesStore
    enum CodingKeys: CodingKey {
        case id
        case matID
        case propertiesID
        case node1
        case node2
        case area
        case length
        case youngsModulus
    }
    
    var id: Int = 0
    var matID: Int = 0
    var propertiesID: Int = 0
    var node1 : Int = 0
    var node2 : Int = 0
    var area : Double
    var length : Double
    var youngsModulus : Double
    

    init(id: Int, matID: Int, propertiesID: Int, node1: Int, node2: Int, nodesStore: NodesStore, materialStore: MaterialStore, elPropertyStore: ElPropertyStore, truss2DStore: Truss2DStore) {
        
        print("Initializing Truss2D")
//        print("numNodes \(nodesStore.nodes.count)")
        

        self.id = id
        self.matID = matID
        self.propertiesID = propertiesID
        self.node1 = node1
        self.node2 = node2
        self.area = elPropertyStore.elProperties[propertiesID].area


        let dx = (nodesStore.nodes[node2].xcoord - nodesStore.nodes[node1].xcoord)
        let dy = (nodesStore.nodes[node2].ycoord - nodesStore.nodes[node1].ycoord)
        let dz = (nodesStore.nodes[node2].zcoord - nodesStore.nodes[node1].zcoord)
        self.length = sqrt (dx * dx + dy * dy + dz * dz)
        
        self.youngsModulus = materialStore.materials[matID].youngsModulus
        
        super.init(numNodes: 2, numDOF: 2, eltype: "Truss2D")


        
//        elementStiffness = elStiffMatrix(youngsM: youngsMod, crossArea: area , len: length)
        
        
        
    }
    


    required init(from decoder: Decoder) throws {
        print("Decoding Truss2D")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.matID = try container.decode(Int.self, forKey: .matID)
        self.propertiesID = try container.decode(Int.self, forKey: .propertiesID)
        self.node1 = try container.decode(Int.self, forKey: .node1)
        self.node2 = try container.decode(Int.self, forKey: .node2)
        self.area = try container.decode(Double.self, forKey: .area)
        self.length = try container.decode(Double.self, forKey: .length)
        self.youngsModulus = try container.decode(Double.self, forKey: .youngsModulus)
        
        super.init(numNodes: 2, numDOF: 2, eltype: "Truss2D")


    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(matID, forKey: .matID)
        try container.encode(propertiesID, forKey: .propertiesID)
        try container.encode(node1, forKey: .node1)
        try container.encode(node2, forKey: .node2)
        try container.encode(area, forKey: .area)
        try container.encode(length, forKey: .length)
        try container.encode(youngsModulus, forKey: .youngsModulus)
    }
    
    func elStiffMatrix(node1: Node, node2: Node, youngsM: Double, crossArea: Double, len: Double)->[[Double]] {
        
//        var elstiff = [[Double]]()
//        let zeros = simd_double4(0.0 , 0.0, 0.0 , 0.0)
        
//        var elstiff = simd_double4x4(columns: (zeros, zeros, zeros, zeros) )
//
//        var rotationMatrix = simd_double4x4(columns: (zeros, zeros, zeros, zeros) )
//
//        var stiff = simd_double4x4(columns: (zeros, zeros, zeros, zeros) )
//
//        var rTK = simd_double4x4(columns: (zeros, zeros, zeros, zeros) ) // rotationTranspose * elstiffness
        
        let rTranspose : [[Double]]
         
        let rTransposeK : [[Double]]
        
        var elstiff = Array(repeating: Array(repeating: 0.0, count: 4), count: 4)
        
        var rotationMatrix = Array(repeating: Array(repeating: 0.0, count: 4), count: 4)

        var stiff = Array(repeating: Array(repeating: 0.0, count: 4), count: 4)
        
 
        
        
        // Form Rotation Matrix
        
        let theta = angleOfRotation(node1: node1, node2: node2, axis: "x")
        
//        print("in truss2d elStiffMatrix")
//        print("theta \(theta) \(theta * 180.0 / Double.pi)")
        
        rotationMatrix[0][0] = cos(theta)
        rotationMatrix[0][1] = sin(theta)
        rotationMatrix[1][0] = -sin(theta)
        rotationMatrix[1][1] = cos(theta)
        rotationMatrix[2][2] = cos(theta)
        rotationMatrix[2][3] = sin(theta)
        rotationMatrix[3][2] = -sin(theta)
        rotationMatrix[3][3] = cos(theta)

//        print("rotation matrix")
//        print(rotationMatrix)
        
        elstiff[0][0] = 1.0  * youngsM * crossArea / len
        elstiff[0][2] = -1.0 * youngsM * crossArea / len
        elstiff[2][0] = -1.0 * youngsM * crossArea / len
        elstiff[2][2] = 1.0  * youngsM * crossArea / len
        
 
        
//        rTK = rotationMatrix.transpose * elstiff
//        stiff = rTK * rotationMatrix
        rTranspose = transpose(rotationMatrix)
        rTransposeK = multiply(rTranspose, elstiff)
        stiff = multiply(rTransposeK, rotationMatrix)
        

        
        return stiff
    }
    func assemble(system: Gauss, elStiff: [[Double]], nodesStore: NodesStore) {
        // Assemble element stiffness into Global Stiffness
        var localToGlobalMap = [Int]()
        let startingDof1 = nodesStore.nodes[node1].beginDofIndex
        let startingDof2 = nodesStore.nodes[node2].beginDofIndex
        localToGlobalMap = Array(repeating: 0, count: 4)
        localToGlobalMap[0] = startingDof1
        localToGlobalMap[1] = startingDof1 + 1
        localToGlobalMap[2] = startingDof2
        localToGlobalMap[3] = startingDof2 + 1
        for i in 0...3 {
            let row = localToGlobalMap[i]
            for j in 0...3 {
                let col = localToGlobalMap[j]
                
                system.matrix[row][col] = system.matrix[row][col] + elStiff[i][j]
                
                
            }
        }
    }
    
 
}

//MARK: - Frame2D Element

class Frame2D: Elements, Identifiable {
    
    //MARK: - Properties
    
    // Inherting:elPropertyStore,materialStore,nodesStore
    enum CodingKeys: CodingKey {
        case id
        case matID
        case propertiesID
        case node1
        case node2
        case area
        case length
        case youngsModulus
        case pin1
        case pin2
    }
    
    var id: Int = 0
    var matID: Int = 0
    var propertiesID: Int = 0
    var node1 : Int = 0
    var node2 : Int = 0
    var area : Double
    var length : Double
    var youngsModulus : Double
    var pin1: Bool = false
    var pin2: Bool = false
    
    
    init(id: Int, matID: Int, propertiesID: Int, node1: Int, node2: Int, pin1: Bool, pin2: Bool, nodesStore: NodesStore, materialStore: MaterialStore, elPropertyStore: ElPropertyStore, frame2DStore: Frame2DStore) {
        
        print("Initializing Frame2D")
        print("numNodes \(nodesStore.nodes.count)")
        
        self.id = id
        self.matID = matID
        self.propertiesID = propertiesID
        self.node1 = node1
        self.node2 = node2
        self.area = elPropertyStore.elProperties[propertiesID].area

        let dx = (nodesStore.nodes[node2].xcoord - nodesStore.nodes[node1].xcoord)
        let dy = (nodesStore.nodes[node2].ycoord - nodesStore.nodes[node1].ycoord)
        let dz = (nodesStore.nodes[node2].zcoord - nodesStore.nodes[node1].zcoord)
        self.length = sqrt (dx * dx + dy * dy + dz * dz)
        
        self.youngsModulus = materialStore.materials[matID].youngsModulus
        
        self.pin1 = pin1
        self.pin2 = pin2
        
        super.init(numNodes: 2, numDOF: 3, eltype: "Frame2D")


        
//        elementStiffness = elStiffMatrix(youngsM: youngsMod, crossArea: area , len: length)
        
        
        
    }
    
    required init(from decoder: Decoder) throws {
        print("Decoding Frame2D")
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.matID = try container.decode(Int.self, forKey: .matID)
        self.propertiesID = try container.decode(Int.self, forKey: .propertiesID)
        self.node1 = try container.decode(Int.self, forKey: .node1)
        self.node2 = try container.decode(Int.self, forKey: .node2)
        self.area = try container.decode(Double.self, forKey: .area)
        self.length = try container.decode(Double.self, forKey: .length)
        self.youngsModulus = try container.decode(Double.self, forKey: .youngsModulus)
        self.pin1 = try container.decode(Bool.self, forKey: .pin1)
        self.pin2 = try container.decode(Bool.self, forKey: .pin2)
        
        
        super.init(numNodes: 2, numDOF: 3, eltype: "Frame2D")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(matID, forKey: .matID)
        try container.encode(propertiesID, forKey: .propertiesID)
        try container.encode(node1, forKey: .node1)
        try container.encode(node2, forKey: .node2)
        try container.encode(area, forKey: .area)
        try container.encode(length, forKey: .length)
        try container.encode(youngsModulus, forKey: .youngsModulus)
        try container.encode(pin1, forKey: .pin1)
        try container.encode(pin2, forKey: .pin2)
    }
    
    func elStiffMatrix(node1: Node, node2: Node, youngsM: Double, crossArea: Double, len: Double, izz: Double)->[[Double]] {
        
//        var elstiff = [[Double]]()
        var elstiff = Array(repeating: Array(repeating: 0.0, count: 6), count: 6)
        
        var rotationMatrix = Array(repeating: Array(repeating: 0.0, count: 6), count: 6)

        var stiff = Array(repeating: Array(repeating: 0.0, count: 6), count: 6)
        
        let rTranspose : [[Double]]
        
        let rTransposeK : [[Double]]
        
        
        
        
        // Form Rotation Matrix
        
        let theta = angleOfRotation(node1: node1, node2: node2, axis: "x")
        
//                print("in truss2d elStiffMatrix")
//                print("theta \(theta) \(theta * 180.0 / Double.pi)")
        
        rotationMatrix[0][0] = cos(theta)
        rotationMatrix[0][1] = sin(theta)
        rotationMatrix[1][0] = -sin(theta)
        rotationMatrix[1][1] = cos(theta)
        rotationMatrix[2][2] = 1.0
        rotationMatrix[3][3] = cos(theta)
        rotationMatrix[3][4] = sin(theta)
        rotationMatrix[4][3] = -sin(theta)
        rotationMatrix[4][4] = cos(theta)
        rotationMatrix[5][5] = 1.0

//                print("rotation matrix")
//                print(rotationMatrix)
        // pin conditions
               
//               print("In Frame elStiffMatrix ")
//               print("pin1 \(pin1) pin2 \(pin2)")
        
        if pin1 == false && pin2 == false {
            elstiff[0][0] = 1.0  * youngsM * crossArea / len
            elstiff[0][3] = -1.0 * youngsM * crossArea / len
            
            elstiff[1][1] = 12.0 * youngsM * izz / (len * len * len)
            elstiff[1][2] =  6.0 * youngsM * izz / (len * len)
            elstiff[1][4] = -12.0 * youngsM * izz / (len * len * len)
            elstiff[1][5] =  6.0 * youngsM * izz / (len * len)
            
            elstiff[2][1] = 6.0 * youngsM * izz / (len * len)
            elstiff[2][2] =  4.0 * youngsM * izz / (len)
            elstiff[2][4] = -6.0 * youngsM * izz / (len * len)
            elstiff[2][5] =  2.0 * youngsM * izz / (len)
            
            elstiff[3][0] = -1.0 * youngsM * crossArea / len
            elstiff[3][3] = 1.0  * youngsM * crossArea / len
            
            elstiff[4][1] = -12.0 * youngsM * izz / (len * len * len)
            elstiff[4][2] =  -6.0 * youngsM * izz / (len * len)
            elstiff[4][4] = 12.0 * youngsM * izz / (len * len * len)
            elstiff[4][5] =  -6.0 * youngsM * izz / (len * len)
            
            elstiff[5][1] = 6.0 * youngsM * izz / (len * len)
            elstiff[5][2] =  2.0 * youngsM * izz / (len)
            elstiff[5][4] = -6.0 * youngsM * izz / (len * len)
            elstiff[5][5] =  4.0 * youngsM * izz / (len)
            
        } else if pin1 == true {
            
            elstiff[0][0] =  1.0  * youngsM * crossArea / len
            elstiff[0][3] = -1.0 * youngsM * crossArea / len
            
            elstiff[1][1] =  3.0 * youngsM * izz / (len * len * len)
            elstiff[1][4] = -3.0 * youngsM * izz / (len * len * len)
            elstiff[1][5] =  3.0 * youngsM * izz / (len * len)
            
            elstiff[3][0] = -1.0 * youngsM * crossArea / len
            elstiff[3][3] =  1.0  * youngsM * crossArea / len
            
            elstiff[4][1] = -3.0 * youngsM * izz / (len * len * len)
            elstiff[4][4] =  3.0 * youngsM * izz / (len * len * len)
            elstiff[4][5] = -3.0 * youngsM * izz / (len * len)
            
            elstiff[5][1] =  3.0 * youngsM * izz / (len * len)
            elstiff[5][4] = -3.0 * youngsM * izz / (len * len)
            elstiff[5][5] =  3.0 * youngsM * izz / (len)

        } else if pin2 {
            
            elstiff[0][0] =  1.0  * youngsM * crossArea / len
            elstiff[0][3] = -1.0  * youngsM * crossArea / len
            
            elstiff[1][1] =  3.0 * youngsM * izz / (len * len * len)
            elstiff[1][2] =  3.0 * youngsM * izz / (len * len)
            elstiff[1][4] = -3.0 * youngsM * izz / (len * len * len)
            
            elstiff[2][1] =  3.0 * youngsM * izz / (len * len)
            elstiff[2][2] =  3.0 * youngsM * izz / (len)
            elstiff[2][4] = -3.0 * youngsM * izz / (len * len)
            
            elstiff[3][0] = -1.0 * youngsM * crossArea / len
            elstiff[3][3] =  1.0  * youngsM * crossArea / len
            
            elstiff[4][1] = -3.0 * youngsM * izz / (len * len * len)
            elstiff[4][2] = -3.0 * youngsM * izz / (len * len)
            elstiff[4][4] =  3.0 * youngsM * izz / (len * len * len)
            

            
        } else if pin1 == true && pin2 == true{
            
           elstiff[0][0] =  1.0  * youngsM * crossArea / len
           elstiff[0][6] = -1.0  * youngsM * crossArea / len
           
           elstiff[6][0] = -1.0 * youngsM * crossArea / len
           elstiff[6][6] =  1.0  * youngsM * crossArea / len
           
        }
        
        rTranspose = transpose(rotationMatrix)
        rTransposeK = multiply(rTranspose, elstiff)
        stiff = multiply(rTransposeK, rotationMatrix)
        
//        print("stiff")
//        print(stiff)
        
        return stiff
    }
    func assemble(system: Gauss, elStiff: [[Double]], nodesStore: NodesStore) {
        // Assemble element stiffness into Global Stiffness
        var localToGlobalMap = [Int]()
        let startingDof1 = nodesStore.nodes[node1].beginDofIndex
        let startingDof2 = nodesStore.nodes[node2].beginDofIndex
        
//        print("node1 \(node1)  node2 \(node2)")
//        print(" startingDof1 \(startingDof1)")
//        print(" startingDof2 \(startingDof2)")

        localToGlobalMap = Array(repeating: 0, count: 6)
        localToGlobalMap[0] = startingDof1
        localToGlobalMap[1] = startingDof1 + 1
        localToGlobalMap[2] = startingDof1 + 2

        localToGlobalMap[3] = startingDof2
        localToGlobalMap[4] = startingDof2 + 1
        localToGlobalMap[5] = startingDof2 + 2

        for i in 0...5 {
            let row = localToGlobalMap[i]
            for j in 0...5 {
                let col = localToGlobalMap[j]
                
                system.matrix[row][col] = system.matrix[row][col] + elStiff[i][j]
                
                
            }
        }
    }
}
    //MARK: - Truss3D Element

    class Truss3D: Elements, Identifiable {
        
        //MARK: - Properties
        
        // Inherting:elPropertyStore,materialStore,nodesStore
        enum CodingKeys: CodingKey {
            case id
            case matID
            case propertiesID
            case node1
            case node2
            case area
            case length
            case youngsModulus
        }
        
        var id: Int = 0
        var matID: Int = 0
        var propertiesID: Int = 0
        var node1 : Int = 0
        var node2 : Int = 0
        var area : Double
        var length : Double
        var youngsModulus : Double
        
        
        init(id: Int, matID: Int, propertiesID: Int, node1: Int, node2: Int, nodesStore: NodesStore, materialStore: MaterialStore, elPropertyStore: ElPropertyStore, truss3DStore: Truss3DStore) {
            
            print("Initializing Truss3D")
            print("numNodes \(nodesStore.nodes.count)")
            
            self.id = id
            
            self.matID = matID
            
            self.propertiesID = propertiesID
            
            
            self.node1 = node1
            
            self.node2 = node2
            
            
            self.area = elPropertyStore.elProperties[propertiesID].area

            let dx = (nodesStore.nodes[node2].xcoord - nodesStore.nodes[node1].xcoord)
            let dy = (nodesStore.nodes[node2].ycoord - nodesStore.nodes[node1].ycoord)
            let dz = (nodesStore.nodes[node2].zcoord - nodesStore.nodes[node1].zcoord)
            self.length = sqrt (dx * dx + dy * dy + dz * dz)
            
            self.youngsModulus = materialStore.materials[matID].youngsModulus
            
            super.init(numNodes: 2, numDOF: 3, eltype: "Truss3D")


            
    //        elementStiffness = elStiffMatrix(youngsM: youngsMod, crossArea: area , len: length)
            
            
            
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.matID = try container.decode(Int.self, forKey: .matID)
            self.propertiesID = try container.decode(Int.self, forKey: .propertiesID)
            self.node1 = try container.decode(Int.self, forKey: .node1)
            self.node2 = try container.decode(Int.self, forKey: .node2)
            self.area = try container.decode(Double.self, forKey: .area)
            self.length = try container.decode(Double.self, forKey: .length)
            self.youngsModulus = try container.decode(Double.self, forKey: .youngsModulus)
            
            super.init(numNodes: 2, numDOF: 3, eltype: "Truss3D")
        }
        override func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(matID, forKey: .matID)
            try container.encode(propertiesID, forKey: .propertiesID)
            try container.encode(node1, forKey: .node1)
            try container.encode(node2, forKey: .node2)
            try container.encode(area, forKey: .area)
            try container.encode(length, forKey: .length)
            try container.encode(youngsModulus, forKey: .youngsModulus)
        }
      
        
        func elStiffMatrix(node1: Node, node2: Node, youngsM: Double, crossArea: Double, len: Double)->[[Double]] {
            


            var stiff = Array(repeating: Array(repeating: 0.0, count: 6), count: 6)
            
     
            let x1 = node1.xcoord
            let x2 = node2.xcoord
            let y1 = node1.ycoord
            let y2 = node2.ycoord
            let z1 = node1.zcoord
            let z2 = node2.zcoord
            
            let cx = (x2 - x1)/len
            let cy = (y2 - y1)/len
            let cz = (z2 - z1)/len
            
            let axialStiff = youngsM * crossArea / len
            
            stiff[0][0] =  axialStiff * cx * cx
            stiff[0][1] =  axialStiff * cx * cy
            stiff[0][2] =  axialStiff * cx * cz
            stiff[0][3] = -axialStiff * cx * cx
            stiff[0][4] = -axialStiff * cx * cy
            stiff[0][5] = -axialStiff * cx * cz
                
            stiff[1][0] =  axialStiff * cx * cy
            stiff[1][1] =  axialStiff * cy * cy
            stiff[1][2] =  axialStiff * cy * cz
            stiff[1][3] = -axialStiff * cx * cy
            stiff[1][4] = -axialStiff * cy * cy
            stiff[1][5] = -axialStiff * cy * cz

            stiff[2][0] =  axialStiff * cx * cz
            stiff[2][1] =  axialStiff * cy * cz
            stiff[2][2] =  axialStiff * cz * cz
            stiff[2][3] = -axialStiff * cx * cz
            stiff[2][4] = -axialStiff * cy * cz
            stiff[2][5] = -axialStiff * cz * cz
                
            stiff[3][0] = -axialStiff * cx * cx
            stiff[3][1] = -axialStiff * cx * cy
            stiff[3][2] = -axialStiff * cx * cz
            stiff[3][3] =  axialStiff * cx * cx
            stiff[3][4] =  axialStiff * cx * cy
            stiff[3][5] =  axialStiff * cx * cz
                
            stiff[4][0] = -axialStiff * cx * cy
            stiff[4][1] = -axialStiff * cy * cy
            stiff[4][2] = -axialStiff * cy * cz
            stiff[4][3] =  axialStiff * cx * cy
            stiff[4][4] =  axialStiff * cy * cy
            stiff[4][5] =  axialStiff * cy * cz
                    
            stiff[5][0] = -axialStiff * cx * cz
            stiff[5][1] = -axialStiff * cy * cz
            stiff[5][2] = -axialStiff * cz * cz
            stiff[5][3] =  axialStiff * cx * cz
            stiff[5][4] =  axialStiff * cy * cz
            stiff[5][5] =  axialStiff * cz * cz
                

            

            
            return stiff
        }
        func assemble(system: Gauss, elStiff: [[Double]], nodesStore: NodesStore) {
            // Assemble element stiffness into Global Stiffness
            var localToGlobalMap = [Int]()
            let startingDof1 = nodesStore.nodes[node1].beginDofIndex
            let startingDof2 = nodesStore.nodes[node2].beginDofIndex
            localToGlobalMap = Array(repeating: 0, count: 6)
            localToGlobalMap[0] = startingDof1
            localToGlobalMap[1] = startingDof1 + 1
            localToGlobalMap[2] = startingDof1 + 2
            localToGlobalMap[3] = startingDof2
            localToGlobalMap[4] = startingDof2 + 1
            localToGlobalMap[5] = startingDof2 + 2
            for i in 0...5 {
                let row = localToGlobalMap[i]
                for j in 0...5 {
                    let col = localToGlobalMap[j]
                    
                    system.matrix[row][col] = system.matrix[row][col] + elStiff[i][j]
                    
                    
                }
            }
        }
}
        
        //MARK: - Frame3D Element

        class Frame3D: Elements, Identifiable {
            
            //MARK: - Properties
            
            // Inherting:elPropertyStore,materialStore,nodesStore
            enum CodingKeys: CodingKey {
                case id
                case matID
                case propertiesID
                case node1
                case node2
                case area
                case length
                case youngsModulus
                case pin1
                case pin2
                case small
            }
            var id: Int = 0
            var matID: Int = 0
            var propertiesID: Int = 0
            var node1 : Int = 0
            var node2 : Int = 0
            var area : Double
            var length : Double
            var youngsModulus : Double
            var pin1: Bool = false
            var pin2: Bool = false
            let small: Double = 1.0e-10
            
            init(id: Int, matID: Int, propertiesID: Int, node1: Int, node2: Int, pin1: Bool, pin2: Bool, nodesStore: NodesStore, materialStore: MaterialStore, elPropertyStore: ElPropertyStore, frame3DStore: Frame3DStore) {
                
                print("Initializing Frame3D")
                print("numNodes \(nodesStore.nodes.count)")
                
                self.id = id
                
                self.matID = matID
                
                self.propertiesID = propertiesID
                
                
                self.node1 = node1
                
                self.node2 = node2
                
                
                self.area = elPropertyStore.elProperties[propertiesID].area

                let dx = (nodesStore.nodes[node2].xcoord - nodesStore.nodes[node1].xcoord)
                let dy = (nodesStore.nodes[node2].ycoord - nodesStore.nodes[node1].ycoord)
                let dz = (nodesStore.nodes[node2].zcoord - nodesStore.nodes[node1].zcoord)
                self.length = sqrt (dx * dx + dy * dy + dz * dz)
                
                self.youngsModulus = materialStore.materials[matID].youngsModulus
                
                self.pin1 = pin1
                self.pin2 = pin2
                
                super.init(numNodes: 2, numDOF: 6, eltype: "Frame3D")

            }
            
            required init(from decoder: Decoder) throws {
                print("Decoding Frame3D")
                
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.id = try container.decode(Int.self, forKey: .id)
                self.matID = try container.decode(Int.self, forKey: .matID)
                self.propertiesID = try container.decode(Int.self, forKey: .propertiesID)
                self.node1 = try container.decode(Int.self, forKey: .node1)
                self.node2 = try container.decode(Int.self, forKey: .node2)
                self.area = try container.decode(Double.self, forKey: .area)
                self.length = try container.decode(Double.self, forKey: .length)
                self.youngsModulus = try container.decode(Double.self, forKey: .youngsModulus)
                self.pin1 = try container.decode(Bool.self, forKey: .pin1)
                self.pin2 = try container.decode(Bool.self, forKey: .pin2)
                
                super.init(numNodes: 2, numDOF: 6, eltype: "Frame3D")

            }
            
            override func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(id, forKey: .id)
                try container.encode(matID, forKey: .matID)
                try container.encode(propertiesID, forKey: .propertiesID)
                try container.encode(node1, forKey: .node1)
                try container.encode(node2, forKey: .node2)
                try container.encode(area, forKey: .area)
                try container.encode(length, forKey: .length)
                try container.encode(youngsModulus, forKey: .youngsModulus)
                try container.encode(pin1, forKey: .pin1)
                try container.encode(pin2, forKey: .pin2)
            }
          
            
            func elStiffMatrix(node1: Node, node2: Node, youngsM: Double, G: Double, crossArea: Double, len: Double, izz: Double, iyy: Double, ixx: Double)->[[Double]] {
                
        //        var elstiff = [[Double]]()
                var elstiff = Array(repeating: Array(repeating: 0.0, count: 12), count: 12)
                
                
                var rotationMatrix = Array(repeating: Array(repeating: 0.0, count: 12), count: 12)

                var stiff = Array(repeating: Array(repeating: 0.0, count: 12), count: 12)
                
                let rTranspose : [[Double]]
                
                let rTransposeK : [[Double]]
                
                
                
                
                // Form Rotation Matrix
                
//                let theta = angleOfRotation(node1: node1, node2: node2, axis: "x")
                
        //                print("in truss2d elStiffMatrix")
        //                print("theta \(theta) \(theta * 180.0 / Double.pi)")
                
                let x1 = node1.xcoord
                let x2 = node2.xcoord
                let y1 = node1.ycoord
                let y2 = node2.ycoord
                let z1 = node1.zcoord
                let z2 = node2.zcoord
                
                let cx = (x2 - x1)/len
                let cy = (y2 - y1)/len
                let cz = (z2 - z1)/len
                let cxz = sqrt(cx * cx + cz * cz)
                
                // the memeber is vertical: special case
                if cxz <= small {
                    rotationMatrix[0][0] = 0
                    rotationMatrix[0][1] = cy
                    rotationMatrix[0][2] = 0

                    rotationMatrix[1][0] = -cy
                    rotationMatrix[1][1] = 0
                    rotationMatrix[1][2] = 0

                    rotationMatrix[2][0] = 0
                    rotationMatrix[2][1] = 0
                    rotationMatrix[2][2] = 1.0
                    
                    rotationMatrix[3][3] = 0
                    rotationMatrix[3][4] = cy
                    rotationMatrix[3][5] = 0

                    rotationMatrix[4][3] = -cy
                    rotationMatrix[4][4] = 0
                    rotationMatrix[4][5] = 0

                    rotationMatrix[5][3] = 0
                    rotationMatrix[5][4] = 0
                    rotationMatrix[5][5] = 1.0
                    
                    rotationMatrix[6][6] = 0
                    rotationMatrix[6][7] = cy
                    rotationMatrix[6][8] = 0

                    rotationMatrix[7][6] = -cy
                    rotationMatrix[7][7] = 0
                    rotationMatrix[7][8] = 0

                    rotationMatrix[8][6] = 0
                    rotationMatrix[8][7] = 0
                    rotationMatrix[8][8] = 1.0
                    
                    rotationMatrix[9][9] = 0
                    rotationMatrix[9][10] = cy
                    rotationMatrix[9][11] = 0

                    rotationMatrix[10][9] = -cy
                    rotationMatrix[10][10] = 0
                    rotationMatrix[10][11] = 0

                    rotationMatrix[11][9] = 0
                    rotationMatrix[11][10] = 0
                    rotationMatrix[11][11] = 1.0
                    
                } else { // use the special case 3D transformation Saouma pg.4-12, assumes the principal axes of the member are in the vertical  and horizontal planes, e.g, the web of an I-beam
                    
                rotationMatrix[0][0] = cx
                rotationMatrix[0][1] = cy
                rotationMatrix[0][2] = cz

                rotationMatrix[1][0] = -(cy * cy)/cxz
                rotationMatrix[1][1] = cxz
                rotationMatrix[1][2] = -(cy * cz)/cxz

                rotationMatrix[2][0] = -(cz)/cxz
                rotationMatrix[2][1] = 0
                rotationMatrix[2][2] = cx/cxz
                
                rotationMatrix[3][3] = cx
                rotationMatrix[3][4] = cy
                rotationMatrix[3][5] = cz

                rotationMatrix[4][3] = -(cy * cy)/cxz
                rotationMatrix[4][4] = cxz
                rotationMatrix[4][5] = -(cy * cz)/cxz

                rotationMatrix[5][3] = -(cz)/cxz
                rotationMatrix[5][4] = 0
                rotationMatrix[5][5] = cx/cxz
                
                rotationMatrix[6][6] = cx
                rotationMatrix[6][7] = cy
                rotationMatrix[6][8] = cz

                rotationMatrix[7][6] = -cy
                rotationMatrix[7][7] = cxz
                rotationMatrix[7][8] = -(cy * cz)/cxz

                rotationMatrix[8][6] = -(cz)/cxz
                rotationMatrix[8][7] = 0
                rotationMatrix[8][8] = cx/cxz
                
                rotationMatrix[9][9] = cx
                rotationMatrix[9][10] = cy
                rotationMatrix[9][11] = cz

                rotationMatrix[10][9] = -cy
                rotationMatrix[10][10] = cxz
                rotationMatrix[10][11] = -(cy * cz)/cxz

                rotationMatrix[11][9] = -cy
                rotationMatrix[11][10] = 0
                rotationMatrix[11][11] = cx/cxz
                    
                }

                
                


        //                print("rotation matrix")
        //                print(rotationMatrix)
                // pin conditions
                       
        //               print("In Frame elStiffMatrix ")
        //               print("pin1 \(pin1) pin2 \(pin2)")
                
                if pin1 == false && pin2 == false {

                    elstiff[0][0] = youngsM * crossArea / len
                    elstiff[0][6] = -elstiff[0][0]
                    
                    elstiff[1][1] = 12.0 * youngsM * izz / (len * len * len)
                    elstiff[1][5] = 6.0 * youngsM * izz / (len * len)
                    elstiff[1][7] = -elstiff[1][1]
                    elstiff[1][11] = elstiff[1][5]
                    
                    elstiff[2][2] = 12.0 * youngsM * iyy / (len * len * len)
                    elstiff[2][4] = -6.0 * youngsM * iyy / (len * len)
                    elstiff[2][8] = -elstiff[2][2]
                    elstiff[2][10] = elstiff[2][4]
                    
                    elstiff[3][3] = G * ixx / (len)
                    elstiff[3][9] = -elstiff[3][3]
                    
                    elstiff[4][2] = -6.0 * youngsM * iyy / (len * len)
                    elstiff[4][4] =  4.0 * youngsM * iyy / (len)
                    elstiff[4][8] = -elstiff[4][2]
                    elstiff[4][10] = 2.0 * youngsM * iyy / (len)
                    
                    elstiff[5][1] = 6.0 * youngsM * izz / (len * len)
                    elstiff[5][5] =  4.0 * youngsM * izz / (len)
                    elstiff[5][7] = -elstiff[5][1]
                    elstiff[5][11] =  2.0 * youngsM * izz / (len)
                    
                    elstiff[6][0] = -elstiff[0][0]
                    elstiff[6][6] = -elstiff[0][6]
                    
                    
                    elstiff[7][1] = -elstiff[1][1]
                    elstiff[7][5] = -elstiff[1][5]
                    elstiff[7][7] = -elstiff[1][7]
                    elstiff[7][11] = -elstiff[1][11]
                    
                    
                    elstiff[8][2] = -elstiff[2][2]
                    elstiff[8][4] = -elstiff[2][4]
                    elstiff[8][8] = -elstiff[2][8]
                    elstiff[8][10] = -elstiff[2][10]
                    
                    
                    elstiff[9][3] = -elstiff[3][3]
                    elstiff[9][9] = -elstiff[3][9]
                    
                    
                    elstiff[10][2] = elstiff[4][2]
                    elstiff[10][4] =  2.0 * youngsM * iyy / (len)
                    elstiff[10][8] = elstiff[4][8]
                    elstiff[10][10] = 4.0 * youngsM * iyy / (len)
                    
                    
                    elstiff[11][1] = elstiff[5][1]
                    elstiff[11][5] =  2.0 * youngsM * izz / (len)
                    elstiff[11][7] = elstiff[5][7]
                    elstiff[11][11] =  4.0 * youngsM * izz / (len)
                    
                    
 
                } else if pin1 == true {
                    
                    fatalError("Not Implemented")
                    
                } else if pin2 {

                    fatalError("Not Implemented")

                } else if pin1 == true && pin2 == true{
                    
                   elstiff[0][0] =  1.0  * youngsM * crossArea / len
                   elstiff[0][6] = -1.0  * youngsM * crossArea / len
                   
                   elstiff[6][0] = -1.0 * youngsM * crossArea / len
                   elstiff[6][6] =  1.0  * youngsM * crossArea / len
                   
                }
                
                rTranspose = transpose(rotationMatrix)
                rTransposeK = multiply(rTranspose, elstiff)
                stiff = multiply(rTransposeK, rotationMatrix)
                
        //        print("stiff")
        //        print(stiff)
                
                return stiff
            }
            func assemble(system: Gauss, elStiff: [[Double]], nodesStore: NodesStore) {
                // Assemble element stiffness into Global Stiffness
                var localToGlobalMap = [Int]()
                let startingDof1 = nodesStore.nodes[node1].beginDofIndex
                let startingDof2 = nodesStore.nodes[node2].beginDofIndex
                
//                print("node1 \(node1)  node2 \(node2)")
//                print(" startingDof1 \(startingDof1)")
//                print(" startingDof2 \(startingDof2)")

                localToGlobalMap = Array(repeating: 0, count: 12)
                localToGlobalMap[0] = startingDof1
                localToGlobalMap[1] = startingDof1 + 1
                localToGlobalMap[2] = startingDof1 + 2
                localToGlobalMap[3] = startingDof1 + 3
                localToGlobalMap[4] = startingDof1 + 4
                localToGlobalMap[5] = startingDof1 + 5

                localToGlobalMap[6] = startingDof2
                localToGlobalMap[7] = startingDof2 + 1
                localToGlobalMap[8] = startingDof2 + 2
                localToGlobalMap[9] = startingDof2 + 3
                localToGlobalMap[10] = startingDof2 + 4
                localToGlobalMap[11] = startingDof2 + 5

                for i in 0...11 {
                    let row = localToGlobalMap[i]
                    for j in 0...11 {
                        let col = localToGlobalMap[j]
                        
                        system.matrix[row][col] = system.matrix[row][col] + elStiff[i][j]
                        
                        
                    }
                }
            }
        }

