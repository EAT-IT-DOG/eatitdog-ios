/// Offer View Interface
/// Created by Mercen on 2022/09/29.


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

// MARK: - Offer View
struct OfferView: View {
    
    /// State Variables
    @State private var dangerous: String = ""
    @State private var selected: String = ""
    
    /// Static Variables
    private let category: [[String]] = [["유제품", "채소", "음료"],
                                        ["간식", "인스턴트", "조미료"],
                                        ["육류", "과일", "해산물"]]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - Title
                Text("제안하기")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.basics)
                
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
                    ForEach(category, id: \.self) { row in
                        VStack(alignment: .leading, spacing: 14) {
                            ForEach(row, id: \.self) { line in
                                RadioButton(pin: $selected, tag: line)
                            }
                        }
                        if row != category.last {
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
