//
//  Like.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 04/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Restable {
    var id: Int?
    let user: User
    let likeableId: Int
    let likeableType: String
    let createdAt: Date?
    let updatedAt: Date?
}
