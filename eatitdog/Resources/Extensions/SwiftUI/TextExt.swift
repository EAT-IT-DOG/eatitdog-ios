//
//  TextExt.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/14.
//

import SwiftUI

extension Text {
    @ViewBuilder func setFont(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Text {
        self
            .font(.system(size: size, weight: weight))
    }
}
