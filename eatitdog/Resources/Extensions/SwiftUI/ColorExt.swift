//
//  ColorExt.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/14.
//

import SwiftUI

// MARK: - Color Extension
extension Color {
    static let basics = Color("Basics")
    static let general = Color("General")
    static let soft = Color("Soft")
    static let background = Color("Background")
    static let yellow = Color("Yellow")
    static let green = Color("Green")
}


func colorLoop(_ list: [String], _ key: String) -> Color {
    switch(list.firstIndex(where: { $0 == key })! % 3) {
    case 0: return .green
    case 1: return .yellow
    default: return .accentColor
    }
}
