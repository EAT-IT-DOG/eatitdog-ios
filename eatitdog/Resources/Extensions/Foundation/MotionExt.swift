//
//  MotionExt.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/14.
//

import SwiftUI

// MARK: - Transition Extension
extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))
    }
}

extension Animation {
    static var `default`: Animation {
        .spring(dampingFraction: 0.75, blendDuration: 0.5)
    }
}

// MARK: - Button Style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

public func touch() {
    HapticManager.instance.impact(style: .light)
}
