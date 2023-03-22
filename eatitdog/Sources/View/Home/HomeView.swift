//
//  HomeView.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

// MARK: - Home View
struct HomeView: View {
    
    /// State
    @EnvironmentObject private var mainState: MainState
    let animation: Namespace.ID
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 26) {
                
                // MARK: - Banner
                VStack(spacing: 0) {
                    Text("강아지가 먹어도 되는\n음식인지 검색해 보세요!")
                        .minimumScaleFactor(0.5)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                        .setFont(18, .medium)
                    Image("Girl")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .padding(.bottom, 4)
                }
                .frame(width: 303)
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color.accentColor, Color.yellow]),
                    startPoint: .top, endPoint: .bottom))
                .cornerRadius(15)
                
                // MARK: - Category Plate
                VStack(spacing: 0) {
                    ForEach([
                        [FoodType.milkProduct, .snack, .meat],
                        [.vegetable, .junkfood, .seafood],
                        [.drink, .seasoning, .fruit]
                    ], id: \.self) { line in
                        HStack(spacing: 0) {
                            ForEach(line, id: \.self) { row in
                                Button(action: {
                                    mainState.transition = .slide
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        withAnimation(.default) {
                                            mainState.selectedFilter = row
                                        }
                                    }
                                    withAnimation(.default) {
                                        mainState.selectedView = 1
                                    }
                                    touch()
                                }) {
                                    VStack(spacing: 13) {
                                        Image(row.toName)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .if(row.toName == "유제품") {
                                                $0.padding(.leading, 8)
                                            }
                                        Text(row.toName)
                                            .foregroundColor(.basics)
                                            .setFont(16)
                                    }
                                }
                                .frame(width: 101, height: 120)
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(15)
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 28)
        }
        .customBackground()
    }
}
