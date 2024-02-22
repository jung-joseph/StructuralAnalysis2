//
//  Gauss.swift
//  FrameStructuralAnalysis
//
//  Created by Joseph Jung on 8/2/19.
//  Copyright © 2019 Joseph Jung. All rights reserved.
//

import Foundation

@Observable
class Gauss{
    var matrix = [[Double]]() // create an empty matrix
    var x = [Double]() // create the solution vector
    
//    var numDofPerNode: Int
    var neq: Int
    
    init(neq: Int) {
        
        
        self.neq = neq

        matrix = Array(repeating: Array(repeating: 0.0, count: neq+1), count: neq)
        x = Array(repeating: 0.0, count: neq)
    }
    
 
    func printAMatrix() {
        print("The Complete Augmented Matrix")
        
        for array in matrix {
            for value in array {
                print(value, terminator: " ")
            }
            print(" ")
        }
        
        print()
    }
    
    func printBVector() {
        print("B Vector")
        for i in 0...neq - 1 {
            print(" \(matrix[i][neq])")
        }
        print()
    }
    
    @discardableResult func gaussSolve() -> [Double] {
        // Gauss Elimination without pivoting
        
        var factor: Double
        
        var sum : Double
        var product : Double
        
        // Forward Elimination
        for i in 0...neq-2 {
           
            for j in i+1...neq-1 {
               
                factor = matrix[j][i]/matrix[i][i]
                for jj in i...neq {
                    matrix[j][jj] = matrix[j][jj] - factor *  matrix[i][jj]
                }
               
            }
        }
        
        // Back Substituion
        
        x[neq-1] = matrix[neq-1][neq]/matrix[neq-1][neq-1]
        

        for i in stride(from: neq-2, through: 0, by: -1){
            sum = 0.0
            for j in i...neq-1 { // need to verify! should this be i+1...neq-1 ??
                product = matrix[i][j] * x[j]
                sum = sum - product
            }
            x[i] = (matrix[i][neq] + sum)/matrix[i][i]
        }
        return x
    }
    
    func printSolution(){
        print("Solution vector")
        print(" i   x[i]")
        
        for i in 0...neq-1 {
            print("\(i)     \(x[i])")
        }
    }
}
