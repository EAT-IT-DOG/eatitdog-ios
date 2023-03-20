//
//  FoodModel.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/15.
//

import Foundation

struct Food: Codable, Hashable {
    let id, searchCount: Int
    let name: String
    let caution, benefit, eatingMethod, symptom: String?
    let createdDateTime: Date
    let modifiedDateTime: Date?
    let safeness: FoodSafeness
    let type: FoodType
}
