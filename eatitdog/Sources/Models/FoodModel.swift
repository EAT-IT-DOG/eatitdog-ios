//
//  FoodModel.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/15.
//

import SwiftUI

enum FoodSafeness: String, Codable, CaseIterable {
    case safe = "SAFE"
    case normal = "NORMAL"
    case dangerous = "DANGEROUS"
    
    var toColor: Color {
        switch self {
        case .safe:
            return .green
        case .normal:
            return .yellow
        case .dangerous:
            return .accentColor
        }
    }
    
    var toName: String {
        switch self {
        case .safe:
            return "안전"
        case .normal:
            return "양호"
        case .dangerous:
            return "위험"
        }
    }
    
    var toSentence: String {
        if [.safe, .normal].contains(self) {
            return "섭취 가능합니다."
        } else {
            return "먹으면 위험합니다. 만약 반려견이 섭취하였다면 신속히 병원 의료진과 상담하시고, 대처하시기 바랍니다."
        }
    }
}

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

struct Food: Codable, Hashable {
    let id, searchCount: Int
    let name: String
    let caution, benefit, eatingMethod, symptom: String?
    let createdDateTime: Date
    let modifiedDateTime: Date?
    let safeness: FoodSafeness
    let type: FoodType
}
