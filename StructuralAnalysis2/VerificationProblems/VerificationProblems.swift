//
//  VerificationProblems.swift
//  StructuralAnalysis2
//
//  Created by Joseph Jung on 9/2/24.
//

import Foundation


@Observable
class VerificationProblems: ObservableObject {
    
    var oneElementBar = """
{
"truss2DStore":
 {"truss2DElements": [{"youngsModulus":30000000,"area":1,"node2":1,"propertiesID":0,"id":0,"length":10,"matID":0,"node1":0}]
  },
"frame2DStore":{"frame2DElements":[]
  },
"truss3DStore":{"truss3DElements":[]
  },
"frame3DStore":{"frame3DElements":[]
  },
"elPropertyStore":
 {"elProperties": [{"iYY":1,"iXY":1,"iJ":1,"area":1,"iZZ":1,"id":0}]
  },
"bcStore":
 {"bcs": [{"bcValue":0,"bcDirection":0,"id":0,"bcNode":0},
          {"bcValue":0,"bcDirection":1,"id":1,"bcNode":0},
          {"bcValue":0,"bcDirection":1,"id":2,"bcNode":1}]
  },
"materialStore":
 {"materials": [{"id":0, "youngsModulus":30000000,"shearModulus":11500000}]
  },
"nodesStore":
 {"nodes": [{"ycoord":0,"xcoord":0,"id":0,"zcoord":0,"numDof":2,"beginDofIndex":0},
            {"id":1,"zcoord":0,"numDof":2,"xcoord":10,"ycoord":0,"beginDofIndex":2}],
  "totalNumDofs":4
  },
"loadStore":
 {"loads":[{"loadValue":1,"loadDirection":0,"loadNode":1,"id":0}]
 }
}
""".data(using: .utf8)

    var twoElementBar = """
    {"frame3DStore":{"frame3DElements":[]},"bcStore":{"bcs":[{"bcDirection":0,"id":0,"bcNode":0,"bcValue":0},{"id":1,"bcDirection":1,"bcNode":0,"bcValue":0},{"bcValue":0,"id":2,"bcDirection":1,"bcNode":2},{"bcNode":1,"bcValue":0,"id":3,"bcDirection":1}]},"nodesStore":{"nodes":[{"ycoord":0,"xcoord":0,"zcoord":0,"id":0,"numDof":2,"beginDofIndex":0},{"xcoord":10,"id":1,"zcoord":0,"numDof":2,"beginDofIndex":2,"ycoord":0},{"ycoord":0,"zcoord":0,"numDof":2,"beginDofIndex":4,"id":2,"xcoord":20}],"totalNumDofs":6},"loadStore":{"loads":[{"id":0,"loadValue":10,"loadDirection":0,"loadNode":2}]},"truss2DStore":{"truss2DElements":[{"node1":0,"length":10,"node2":1,"id":0,"area":1,"matID":0,"youngsModulus":30000000,"propertiesID":0},{"propertiesID":0,"area":1,"id":1,"youngsModulus":30000000,"matID":0,"length":10,"node1":1,"node2":2}]},"materialStore":{"materials":[{"shearModulus":11500000,"youngsModulus":30000000,"id":0}]},"frame2DStore":{"frame2DElements":[]},"elPropertyStore":{"elProperties":[{"id":0,"area":1,"iZZ":1,"iYY":1,"iXY":1,"iJ":1}]},"truss3DStore":{"truss3DElements":[]}}
""".data(using: .utf8)

        var threeSpanBeam = """
    {"truss2DStore":{"truss2DElements":[]},"elPropertyStore":{"elProperties":[{"area":1,"iZZ":1,"id":0,"iYY":1,"iJ":1,"iXY":1}]},"truss3DStore":{"truss3DElements":[]},"frame2DStore":{"frame2DElements":[{"youngsModulus":30000000,"propertiesID":0,"node2":1,"id":0,"pin1":false,"length":900,"pin2":false,"matID":0,"node1":0,"area":1},{"propertiesID":0,"area":1,"matID":0,"id":1,"pin1":false,"youngsModulus":30000000,"node2":4,"length":900,"node1":1,"pin2":false},{"pin2":false,"id":2,"pin1":false,"propertiesID":0,"node1":4,"area":1,"length":900,"youngsModulus":30000000,"matID":0,"node2":2},{"youngsModulus":30000000,"id":3,"matID":0,"node1":2,"node2":3,"length":600,"pin1":false,"propertiesID":0,"area":1,"pin2":false}]},"materialStore":{"materials":[{"id":0,"youngsModulus":1800000000,"shearModulus":1}]},"loadStore":{"loads":[{"loadDirection":1,"loadNode":4,"id":0,"loadValue":-133}]},"bcStore":{"bcs":[{"bcDirection":1,"bcValue":0,"bcNode":0,"id":0},{"bcNode":1,"id":1,"bcValue":0,"bcDirection":1},{"id":2,"bcValue":0,"bcNode":2,"bcDirection":1},{"bcDirection":0,"bcNode":3,"id":3,"bcValue":0},{"bcDirection":1,"id":4,"bcValue":0,"bcNode":3}]},"nodesStore":{"nodes":[{"id":0,"ycoord":0,"numDof":3,"beginDofIndex":0,"zcoord":0,"xcoord":0},{"zcoord":0,"numDof":3,"xcoord":900,"beginDofIndex":3,"ycoord":0,"id":1},{"xcoord":2700,"id":2,"zcoord":0,"ycoord":0,"numDof":3,"beginDofIndex":6},{"ycoord":0,"beginDofIndex":9,"xcoord":3300,"zcoord":0,"numDof":3,"id":3},{"ycoord":0,"zcoord":0,"xcoord":1800,"numDof":3,"beginDofIndex":12,"id":4}],"totalNumDofs":15},"frame3DStore":{"frame3DElements":[]}}
""".data(using: .utf8)
    
    var twoDTruss = """
{"materialStore":{"materials":[{"id":0,"youngsModulus":30000,"shearModulus":11500000}]},"nodesStore":{"nodes":[{"ycoord":120,"beginDofIndex":0,"id":0,"zcoord":0,"numDof":2,"xcoord":0},{"zcoord":0,"numDof":2,"beginDofIndex":2,"ycoord":120,"xcoord":120,"id":1},{"xcoord":120,"zcoord":0,"numDof":2,"beginDofIndex":4,"id":2,"ycoord":0},{"zcoord":0,"ycoord":0,"xcoord":0,"beginDofIndex":6,"id":3,"numDof":2}],"totalNumDofs":8},"elPropertyStore":{"elProperties":[{"iZZ":1,"id":0,"iXY":1,"iJ":1,"area":4,"iYY":1}]},"bcStore":{"bcs":[{"bcDirection":0,"bcNode":3,"bcValue":0,"id":0},{"bcDirection":1,"bcNode":3,"id":1,"bcValue":0},{"id":2,"bcDirection":1,"bcValue":0,"bcNode":2}]},"loadStore":{"loads":[{"loadDirection":0,"loadValue":4,"loadNode":0,"id":0}]},"frame2DStore":{"frame2DElements":[]},"frame3DStore":{"frame3DElements":[]},"truss2DStore":{"truss2DElements":[{"node1":0,"matID":0,"id":0,"length":120,"node2":1,"youngsModulus":30000000,"area":1,"propertiesID":0},{"youngsModulus":30000000,"propertiesID":0,"matID":0,"length":120,"node2":2,"id":1,"area":1,"node1":1},{"youngsModulus":30000000,"node1":2,"area":1,"id":2,"length":120,"propertiesID":0,"matID":0,"node2":3},{"area":1,"node2":0,"node1":3,"length":120,"id":3,"youngsModulus":30000000,"matID":0,"propertiesID":0},{"node1":0,"length":169.7056274847714,"youngsModulus":30000000,"matID":0,"node2":2,"propertiesID":0,"area":1,"id":4},{"youngsModulus":30000000,"matID":0,"node2":1,"length":169.7056274847714,"id":5,"area":1,"propertiesID":0,"node1":3}]},"truss3DStore":{"truss3DElements":[]}}
""".data(using: .utf8)
    
    var solleksRiverBridge = """
{"truss2DStore":{"truss2DElements":[]},"bcStore":{"bcs":[{"bcNode":0,"id":0,"bcValue":0,"bcDirection":1},{"bcDirection":0,"id":1,"bcValue":0,"bcNode":6},{"bcNode":6,"bcDirection":1,"bcValue":0,"id":2},{"bcNode":7,"bcValue":0,"id":3,"bcDirection":0},{"id":4,"bcNode":7,"bcValue":0,"bcDirection":1},{"bcValue":0,"bcDirection":0,"bcNode":8,"id":5},{"bcDirection":1,"id":6,"bcValue":0,"bcNode":8}]},"frame2DStore":{"frame2DElements":[{"area":1,"youngsModulus":30000000,"node1":0,"pin1":false,"pin2":false,"node2":1,"id":0,"matID":0,"length":840,"propertiesID":0},{"matID":0,"area":1,"node1":1,"pin2":false,"youngsModulus":30000000,"length":300,"id":1,"node2":2,"propertiesID":0,"pin1":false},{"node1":2,"youngsModulus":30000000,"matID":0,"id":2,"propertiesID":0,"pin1":false,"node2":3,"length":216,"pin2":false,"area":1},{"matID":0,"propertiesID":0,"length":192,"node2":4,"area":1,"id":3,"youngsModulus":30000000,"pin1":false,"node1":3,"pin2":false},{"youngsModulus":30000000,"node1":4,"id":4,"length":372,"pin2":false,"pin1":false,"node2":5,"matID":0,"propertiesID":0,"area":1},{"pin1":false,"node2":6,"length":840,"youngsModulus":30000000,"pin2":false,"propertiesID":0,"matID":0,"node1":5,"id":5,"area":1},{"pin2":true,"youngsModulus":30000000,"pin1":false,"length":774.5281918690888,"matID":0,"node2":1,"node1":7,"propertiesID":1,"id":6,"area":1},{"pin2":true,"propertiesID":1,"area":1,"youngsModulus":30000000,"pin1":false,"node1":8,"matID":0,"node2":5,"id":7,"length":774.5281918690887}]},"frame3DStore":{"frame3DElements":[]},"truss3DStore":{"truss3DElements":[]},"elPropertyStore":{"elProperties":[{"iYY":1,"iXY":1,"iZZ":285260,"iJ":1,"area":767,"id":0},{"iJ":1,"iZZ":33900,"iYY":1,"iXY":1,"area":446,"id":1}]},"materialStore":{"materials":[{"id":0,"youngsModulus":34000,"shearModulus":11500000}]},"nodesStore":{"totalNumDofs":27,"nodes":[{"id":0,"ycoord":0,"zcoord":0,"beginDofIndex":0,"xcoord":0,"numDof":3},{"zcoord":0,"id":1,"ycoord":0,"xcoord":840,"numDof":3,"beginDofIndex":3},{"ycoord":0,"numDof":3,"beginDofIndex":6,"zcoord":0,"xcoord":1140,"id":2},{"zcoord":0,"numDof":3,"beginDofIndex":9,"ycoord":0,"id":3,"xcoord":1356},{"ycoord":0,"zcoord":0,"numDof":3,"id":4,"xcoord":1548,"beginDofIndex":12},{"zcoord":0,"numDof":3,"ycoord":0,"id":5,"beginDofIndex":15,"xcoord":1920},{"zcoord":0,"xcoord":2760,"ycoord":0,"id":6,"numDof":3,"beginDofIndex":18},{"zcoord":0,"id":7,"beginDofIndex":21,"xcoord":368.4,"ycoord":-614.4,"numDof":3},{"numDof":3,"xcoord":2391.6,"zcoord":0,"id":8,"beginDofIndex":24,"ycoord":-614.4}]},"loadStore":{"loads":[{"loadValue":-30.4,"loadDirection":1,"loadNode":2,"id":0},{"loadDirection":1,"loadNode":3,"id":1,"loadValue":-30.4},{"loadValue":-7.5,"loadDirection":1,"id":2,"loadNode":4}]}}
""".data(using: .utf8)
    
}

