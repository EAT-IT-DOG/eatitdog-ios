//
//  SearchCellView.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/16.
//

import SwiftUI

fileprivate struct TextContainer: View {
    
    let head: String
    let text: String
    
    init(_ head: String, _ text: String) {
        self.head = head
        self.text = text
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(head)
                .setFont(14, .medium)
                .foregroundColor(.basics)
            Text(text)
                .setFont(16)
                .foregroundColor(.body)
        }
    }
}

// MARK: - Search Cell View
struct SearchCellView: View {
    
    /// Namespace
    @Namespace private var animation
    
    @Binding var selected: Food?
    let data: Food
    
    var body: some View {
        Group {
            if selected == data {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .trailing, spacing: 0) {
                        Circle()
                            .fill(data.safeness.toColor)
                            .frame(width: 18, height: 18)
                        Text(data.safeness.toName)
                            .setFont(12)
                            .foregroundColor(.general)
                        Text(data.name)
                            .setFont(24, .medium)
                            .foregroundColor(.basics)
                            .setAlignment(.leading)
                    }
                    TextContainer("섭취 가능 여부", data.safeness.toSentence)
                    if let eatingMethod = data.eatingMethod {
                        TextContainer("급여 방법", eatingMethod)
                    }
                    if let benefit = data.benefit {
                        TextContainer("주성분 및 기능", benefit)
                    }
                    if let symptom = data.symptom {
                        TextContainer("증상", symptom)
                    }
                    Button(action: {
                        withAnimation(.default) {
                            selected = nil
                            touch()
                        }
                    }) {
                        Text("확인")
                            .foregroundColor(.white)
                            .frame(width: 144, height: 36)
                            .background(data.safeness.toColor)
                            .cornerRadius(8)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .frame(maxWidth: .infinity)
                }
                .padding(24)
                .frame(width: 303)
                .background(Color.white
                    .matchedGeometryEffect(id: "c\(data.id)", in: animation))
                .cornerRadius(15)
                .transition(.opacity)
            } else {
                Button(action: {
                    withAnimation(.default) {
                        selected = data
                        touch()
                    }
                }) {
                    VStack(spacing: 4) {
                        Text(data.name)
                            .setFont(24, .medium)
                        Text("#\(data.type.toName)")
                            .setFont(18)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .frame(width: 303, height: 150)
                    .background(data.safeness.toColor
                        .matchedGeometryEffect(id: "c\(data.id)", in: animation))
                    .cornerRadius(15)
                    .transition(.opacity)
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
        .id(data.id)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
