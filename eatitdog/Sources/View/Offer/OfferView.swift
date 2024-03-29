//
//  OfferView.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

struct TitleText: View {
    let text: String
    var type: Bool = false
    var body: some View {
        Text(text)
            .setFont(16, .medium)
            .foregroundColor(.basics)
            .padding(.bottom, 16)
            .padding(.top, type ? 19 : 22)
    }
}

// MARK: - Offer View
struct OfferView: View {
    
    /// State
    @StateObject var state = OfferState()
    
    /// State Variables
    @State private var dangerous: String = ""
    @State private var selected: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - Title
                Text("제안하기")
                    .setFont(18, .medium)
                    .foregroundColor(.basics)
                
                TitleText(text: "음식 이름")
                CustomTextField("음식 이름을 입력하세요", text: $state.foodName)
                
                // MARK: - Danger Alert
                TitleText(text: "강아지에게 위험하나요?")
                HStack(spacing: 28) {
                    ForEach(["네", "아니오"], id: \.self) { tag in
                        RadioButton(pin: $dangerous, tag: tag)
                    }
                }
                
                // MARK: - Food Category
                TitleText(text: "음식 종류", type: true)
                HStack(spacing: 0) {
                    ForEach([
                        [FoodType.milkProduct, .vegetable, .drink],
                        [.snack, .junkfood, .fruit],
                        [.meat, .seasoning, .seafood]
                    ], id: \.self) { row in
                        VStack(alignment: .leading, spacing: 14) {
                            ForEach(row, id: \.self) { line in
                                RadioButton(pin: $selected, tag: line.toName)
                            }
                        }
                        if row[2] != .seafood {
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding(24)
            .frame(width: 303)
            .background(Color.white)
            .cornerRadius(15)
        }
        .customBackground()
    }
}

struct OfferView_Previews: PreviewProvider {
    static var previews: some View {
        OfferView()
    }
}
