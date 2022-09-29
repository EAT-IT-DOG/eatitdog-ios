//
//  MainView.swift
//  EAT-IT-DOG
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct MainView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Namespace private var animation
    @State private var selectedView: Int = 2
    @State private var transition: AnyTransition = .slide
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedView {
                case 1: SearchView()
                case 2: HomeView()
                case 3: OfferView()
                default: ProfileView()
                }
            }
                .transition(transition)
            
            // Tab Bar
            HStack {
                Spacer()
                ForEach(0..<5) { idx in
                    ZStack {
                        if selectedView == idx {
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(width: 20, height: 4)
                                .matchedGeometryEffect(id: "UpperBar", in: animation)
                                .padding(.bottom, 70)
                        }
                        Button(action: {
                            HapticManager.instance.impact(style: .light)
                            transition = selectedView < idx ? .backslide : .slide
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
                                    RoundedRectangle(cornerRadius: 17)
                                        .fill(Color.accentColor)
                                        .frame(width: 47, height: 47)
                                        .matchedGeometryEffect(id: "TabBar", in: animation)
                                )}
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    Spacer()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
