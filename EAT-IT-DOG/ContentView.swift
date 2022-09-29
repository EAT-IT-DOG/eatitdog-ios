//
//  ContentView.swift
//  EAT-IT-DOG
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI


struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}

extension Button {
    @ViewBuilder func customButton(_ condition: Bool) -> some View {
        if condition { self.buttonStyle(PlainButtonStyle()) }
        else { self.buttonStyle(ScaleButtonStyle()) }
    }
}

struct ContentView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Namespace private var animation
    @State private var selectedView: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            // Tab Bar
            HStack {
                Spacer()
                ForEach(0..<5) { idx in
                    Button(action: {
                        withAnimation(.default) {
                            selectedView = idx
                        }
                    }) {
                        Image(["Logout", "Search", "Home", "Offer", "Profile"][idx])
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(selectedView == idx ? .white : .basics)
                            .frame(width: 30, height: 30)
                            .if(selectedView == idx) { $0.background(
                                VStack {
                                    Rectangle()
                                        .fill(Color.accentColor)
                                        .frame(width: 20, height: 5)
                                    RoundedRectangle(cornerRadius: 17)
                                        .fill(Color.accentColor)
                                        .frame(width: 47, height: 47)
                                }
                                    .padding(.bottom, 13)
                                    .matchedGeometryEffect(id: "TabBar", in: animation)
                            )}
                    }
                    .customButton(selectedView == idx)
                    Spacer()
                }
            }
            .padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
