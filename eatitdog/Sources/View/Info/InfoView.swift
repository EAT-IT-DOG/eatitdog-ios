//
//  InfoView.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/22.
//

import SwiftUI

struct InfoView: View {
    
    let animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 0) {
            Text("강아지가 먹어도 되는\n음식인지 검색해 보세요!")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
                .setFont(30, .medium)
                .matchedGeometryEffect(id: "1txt", in: animation)
            Spacer()
            Image("Girl")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .padding(.bottom, 4)
                .matchedGeometryEffect(id: "1img", in: animation)
        }
        .frame(maxWidth: .infinity)
        .background(LinearGradient(
            gradient: Gradient(colors: [Color.accentColor, Color.yellow]),
            startPoint: .top, endPoint: .bottom)
            .matchedGeometryEffect(id: "1bg", in: animation)
            .ignoresSafeArea()
        )
        .zIndex(2)
    }
}
