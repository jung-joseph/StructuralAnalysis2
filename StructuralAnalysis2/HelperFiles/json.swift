////
////  json.swift
////  StructuralAnalysis2
////
////  Created by Joseph Jung on 9/2/24.
////
//
//import Foundation
//
//@discardableResult func decodeData(jsonInfile: Data) -> Bool{
//    
//    var errorCode: Bool = false
//    
//    let decoder = JSONDecoder()
//    do {
//        
//        //                                    decode the data from the file
//        let decodedData = try decoder.decode(Equations.self, from: jsonInfile)
//        
//        
//        //                let numEqsText = String(decodedData.neq)
//        let numEqs = decodedData.neq
////            print("numEqs in decodeData: \(numEqs)")
//        //
//        //copy read object into current equation object
////            let tempEquations = Equations(neq: numEqs) // temp new equation object
////            print("count of aMatrixText: \(tempEquations.aMatrixText.count)")
////            equations.copyElements(newObject: tempEquations)
////            print("count of equations.aMatrixText: \(equations.aMatrixText.count)")
//
//        equations.copyElements(newObject: decodedData)
//        
////            print("count of equations.aMatrixText: \(equations.aMatrixText.count)")
//
//        equations.blankXEText()
//        
//        //
//        
//        // Update the system object
//        let tempGauss = Gauss(neq: numEqs)
//        system.copyElements(newObject: tempGauss)
////            print("count of system.aMatrix: \(system.matrix.count)")
//        
//        
//        
//        //
//        
//    } catch {
//        print ("Error in decodeJSON")
//        system.solverMessage = "Invalid file selected"
//        errorCode = true
//        
//        return errorCode
//    }
//    return errorCode
//}
//}
