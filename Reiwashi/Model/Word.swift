//
//  Word.swift
//  Reiwashi
//
//  Created by 中嶋裕也 on 2020/02/20.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation

struct Word: Codable {
    var id: Int
    var fabCount: Int
    var name: String
    var userId: Int
    var tagId: String?
    var isFab: Bool
    var createdAt: Date
    var updatedAt: Date
}

struct WordWithOutFabCount: Codable {
    var id: Int
    var name: String
    var userId: Int
    var tagId: String?
    var createdAt: Date
    var updatedAt: Date
}
