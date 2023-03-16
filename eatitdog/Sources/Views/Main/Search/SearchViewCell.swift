//
//  SearchViewCell.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/16.
//

import SwiftUI

struct TextContainer: View {
    
    let head: String
    let text: String
    
    init(_ head: String, _ text: String) {
        self.head = head
        self.text = text
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(head)
                .minimumScaleFactor(1.0)
                .setFont(14, .medium)
            Text(text)
                .minimumScaleFactor(1.0)
                .setFont(16)
                .foregroundColor(.body)
        }
    }
}

struct SearchViewCell: View {
    
    /// Namespace
    @Namespace private var animation
    
    @Binding var selected: Food?
    let data: Food
    
    var body: some View {
        Group {
            if selected == data {
                VStack(alignment: .leading, spacing: 24) {
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
                        withAnimation(.easeInOut) {
                            selected = nil
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
                .background(Color.white)
                .cornerRadius(15)
                .transition(.opacity)
                .matchedGeometryEffect(id: "a\(data.id)", in: animation)
            } else {
                Button(action: {
                    withAnimation(.easeInOut) {
                        selected = data
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
                    .background(data.safeness.toColor)
                    .frame(width: 303, height: 150)
                    .cornerRadius(15)
                    .transition(.opacity)
                    .matchedGeometryEffect(id: "a\(data.id)", in: animation)
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
        .id(data.id)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
