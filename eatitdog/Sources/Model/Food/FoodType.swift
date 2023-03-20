//
//  FoodType.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/20.
//

import SwiftUI

enum FoodType: String, Codable, CaseIterable {
    case milkProduct = "MILK_PRODUCT"
    case snack = "SNACK"
    case meat = "MEAT"
    case vegetable = "VEGETABLE"
    case junkfood = "JUNKFOOD"
    case seafood = "SEAFOOD"
    case drink = "DRINK"
    case seasoning = "SEASONING"
    case fruit = "FRUIT"
    
    var toColor: Color {
        switch FoodType.allCases.firstIndex(where: { $0 == self })! % 3 {
        case 0:
            return .green
        case 1:
            return .yellow
        default:
            return .accentColor
        }
    }
    
    var toName: String {
        switch self {
        case .milkProduct:
            return "유제품"
        case .snack:
            return "간식"
        case .meat:
            return "육류"
        case .vegetable:
            return "채소"
        case .junkfood:
            return "인스턴트"
        case .seafood:
            return "해산물"
        case .drink:
            return "음료"
        case .seasoning:
            return "조미료"
        case .fruit:
            return "과일"
        }
    }
}
