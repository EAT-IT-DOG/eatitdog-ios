//
//  ViewExt.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

// MARK: - Radio Button
struct RadioButton: View {
    @Binding var pin: String
    let tag: String
    func clickAction() {
        touch()
        withAnimation(.default) {
            if pin == tag {
                pin = ""
            } else {
                pin = tag
            }
        }
    }
    var body: some View {
        HStack(spacing: 8) {
            Button(action: {
                clickAction()
            }) {
                ZStack {
                    if pin == tag {
                        Circle()
                            .fill(Color.accentColor)
                            .transition(.scale)
                    }
                    Circle()
                        .stroke(Color.soft, lineWidth: 1)
                        .if(pin != tag) {
                            $0.background(Circle().fill(Color.white))
                        }
                }
                .frame(width: 16, height: 16)
            }
            .buttonStyle(ScaleButtonStyle())
            Text(tag)
                .foregroundColor(.basics)
                .onTapGesture(perform: clickAction)
                .setFont(16)
        }
    }
}
