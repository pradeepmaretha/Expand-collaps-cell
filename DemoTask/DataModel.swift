//
//  DataModel.swift
//  DemoTask
//
//  Created by pradeep maretha on 08/06/21.
//  Copyright © 2021 pradeep maretha. All rights reserved.
//

import Foundation

struct SectionData{
    
    var header_name = String()
    var count = 0
    var data = [CellData]()
}

struct CellData {

    var cell_name = String()
    var count = Int()
}
