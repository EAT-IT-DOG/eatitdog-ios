//
//  SearchView.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

// MARK: - Search View
struct SearchView: View {

    /// State Variables
    @State private var activated: Bool = false
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
        
        ScrollView {
            
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
            
            // MARK: - Food Cards
            
        }
        .customBackground()
    }
}
