//
//  FoodSafeness.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/20.
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
