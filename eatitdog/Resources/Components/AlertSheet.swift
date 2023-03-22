//
//  AlertSheet.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/17.
//

import SwiftUI

struct AlertSheet<Content: View>: View {
    
    let message: String
    let buttonMessage: String
    @Binding var isPresented: Bool
    var cancelButton: Bool = false
    let action: () -> Void
    let content: Content
    
    init(_ message: String,
         _ buttonMessage: String,
         isPresented: Binding<Bool>,
         action: @escaping () -> Void,
         cancelButton: Bool,
         @ViewBuilder content: () -> Content)
    {
        self.message = message
        self.buttonMessage = buttonMessage
        self._isPresented = isPresented
        self.action = action
        self.cancelButton = cancelButton
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
            if isPresented {
                Color.black.opacity(0.3).ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.opacity)
                VStack(alignment: .leading, spacing: 22) {
                    Text(message)
                        .setFont(18, .medium)
                        .foregroundColor(.basics)
                    HStack(spacing: 18) {
                        if cancelButton {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    isPresented = false
                                }
                            }) {
                                Text("취소")
                                    .setFont(14)
                                    .frame(height: 36)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white.opacity(0.01))
                                    .cornerRadius(8)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(.foreground, lineWidth: 1))
                            }
                            .buttonStyle(ScaleButtonStyle())
                            .foregroundColor(.soft)
                        }
                        Button(action: {
                            action()
                            touch()
                        }) {
                            Text(buttonMessage)
                                .setFont(14)
                                .frame(height: 36)
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.01))
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(.foreground, lineWidth: 1))
                        }
                        .buttonStyle(ScaleButtonStyle())
                        .foregroundColor(.accentColor)
                    }
                    .frame(width: 255)
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(15)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(1)
            }
        }
    }
}
