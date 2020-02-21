//
//  History.swift
//  Reiwashi
//
//  Created by 中嶋裕也 on 2020/02/21.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation

struct History:Codable {
    var word: [WordWithOutFabCount]
    var fabs: [String:Int]
}
