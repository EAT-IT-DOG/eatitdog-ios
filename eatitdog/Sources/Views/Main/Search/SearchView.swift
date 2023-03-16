//
//  SearchView.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

// MARK: - Search View
struct SearchView: View {
    
    /// Model
    @StateObject private var state = SearchState()

    /// State Variables
    @State private var activated: Bool = false
    @State private var opacity: CGFloat = 1
    @State private var selected: String = ""
    
    /// Local Variables
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// Static Variables
    private let category: [String] = ["유제품", "간식", "육류",
                                      "채소", "인스턴트", "해산물",
                                      "음료", "조미료", "과일"]

    var body: some View {
        
        VStack(spacing: 25) {
            
            // MARK: - Category Selection
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(category, id: \.self) { row in
                        Button(action: {
                            touch()
                            withAnimation(.default) {
                                if selected == row {
                                    selected = ""
                                } else {
                                    selected = row
                                }
                            }
                        }) {
                            Text(row)
                                .setFont(14, .medium)
                                .padding([.leading, .trailing], 25)
                                .frame(height: 34)
                                .foregroundColor(selected == row ?
                                                 colorLoop(category, row) : .white)
                                .if(selected != row) {
                                    $0.background(colorLoop(category, row))
                                        //.transition(.scale)
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .strokeBorder(colorLoop(category, row), lineWidth: 1)
                                )
                                .roundedCorner(15)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding([.leading, .trailing],
                         activated ? (screenWidth - 303) / 2 : screenWidth + 100)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeInOut) {
                            activated.toggle()
                        }
                    }
                }
            }
            
            ZStack(alignment: .topTrailing) {
                GeometryReader { outsideProxy in
                    
                    // MARK: - Food Cards
                    ScrollView {
                        VStack(spacing: 0) {
                            GeometryReader { insideProxy in
                                EmptyView()
                                    .onChange(of: insideProxy.frame(in: .global).minY) { newValue in
                                        let proxy = 1 - (outsideProxy.frame(in: .global).minY - newValue) / 100
                                        if proxy > 0.6 {
                                            opacity = proxy
                                        }
                                    }
                            }
                            LazyVStack(spacing: 24) {
                                ForEach(state.data, id: \.self) { data in
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
                                    .transition(.move(edge: .bottom))
                                }
                            }
                            .padding(.top, 58)
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
                
            // MARK: - Safeness
                HStack(spacing: 7) {
                    ForEach(FoodSafeness.allCases, id: \.self) { type in
                        VStack {
                            Circle()
                                .fill(type.toColor)
                                .frame(width: 18, height: 18)
                            Text(type.toName)
                                .setFont(12)
                                .foregroundColor(.general)
                        }
                    }
                }
                .padding(.trailing, (screenWidth - 303) / 2)
                .opacity(opacity)
            }
        }
        .customBackground()
        .onAppear(perform: state.fetch)
    }
}
