//
//  LaunchView.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

// MARK: - Launch View
struct LaunchView: View {
    
    /// State Variables
    @State private var animated: [Bool] = [false, false, false]
    @State private var launched: Bool = false
    @State private var easteregg: Bool = false
    
    var body: some View {
        if launched {
            MainView()
        } else {
            
            // MARK: - Logo and Slogan
            ZStack {
                Color.accentColor.ignoresSafeArea()
                VStack {
                    Spacer()
                    if animated[0] {
                        Text("먹어보시개")
                            .setFont(40, .medium)
                            .fontWeight(.medium)
                            .transition(.opacity)
                            .frame(height: 70)
                    }
                    if animated[1] {
                        Text("세상의 모든 좋은 음식이\n반려견에게 닿을 때까지")
                            .setFont(24)
                            .multilineTextAlignment(.center)
                            .transition(.opacity)
                            .frame(height: 70)
                    }
                    Spacer()
                    if animated[2] {
                        Image(easteregg ? "Sangyong" : "Dog")
                            .resizable()
                            .frame(width: 235, height: 269)
                            .padding(.leading, 100)
                            .transition(.opacity)
                            .frame(height: 300)
                    }
                }
                .foregroundColor(.white)
                .padding(40)
            }
            .zIndex(1)
            .transition(.backslide)
            .onAppear {
                for idx in 0..<3 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(idx)/4, execute: {
                        withAnimation(.easeInOut(duration: 1)) {
                            animated[idx].toggle()
                        }
                    })
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    withAnimation(.easeInOut) {
                        launched.toggle()
                    }
                })
            }
            .onShake {
                HapticManager.instance.notification(type: .error)
                withAnimation(.default) {
                    easteregg.toggle()
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
