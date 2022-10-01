//
//  OfferView.swift
//  EAT-IT-DOG
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

struct TitleText: View {
    let text: String
    var type: Bool = false
    var body: some View {
        Text(text)
            .fontWeight(.medium)
            .foregroundColor(.basics)
            .padding(.bottom, 16)
            .padding(.top, type ? 19 : 22)
    }
}

struct OfferView: View {
    
    // State Variable
    @State private var dangerous: String = ""
    @State private var selected: String = ""
    
    // Static Variable
    private let category: [[String]] = [["유제품", "채소", "음료"],
                                        ["간식", "인스턴트", "조미료"],
                                        ["육류", "과일", "해산물"]]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                // Danger Alert
                TitleText(text: "강아지에게 위험하나요?")
                HStack(spacing: 28) {
                    ForEach(["네", "아니오"], id: \.self) { tag in
                        RadioButton(pin: $dangerous, tag: tag)
                    }
                }
                
                // Food Category
                TitleText(text: "음식 종류", type: true)
                HStack(spacing: 0) {
                    ForEach(category, id: \.self) { i in
                        VStack(alignment: .leading, spacing: 14) {
                            ForEach(i, id: \.self) { j in
                                RadioButton(pin: $selected, tag: j)
                            }
                        }
                        if i != category.last {
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding(24)
            .frame(width: 303)
            .background(Color.white)
            .roundedCorner(15)
        }
        .customBackground()
    }
}

struct OfferView_Previews: PreviewProvider {
    static var previews: some View {
        OfferView()
    }
}
