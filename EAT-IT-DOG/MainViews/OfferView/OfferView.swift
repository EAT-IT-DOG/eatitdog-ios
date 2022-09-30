//
//  OfferView.swift
//  EAT-IT-DOG
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

struct RadioButton: View {
    @Binding var selected: Bool
    let text: String
    var body: some View {
        HStack(spacing: 8) {
            Button(action: {
                withAnimation(.default) {
                    selected.toggle()
                }
            }) {
                Circle()
                    .strokeBorder(Color.soft, lineWidth: 1)
                    .background(Circle().fill(selected ? Color.accentColor : Color.white))
                    .frame(width: 16, height: 16)
            }
            .buttonStyle(ScaleButtonStyle())
            Text(text)
                .foregroundColor(.basics)
        }
    }
}

struct OfferView: View {
    
    // State Variable
    @State var selected: Bool = true
    
    var body: some View {
        ScrollView {
            VStack {
                Text("제안하기")
                RadioButton(selected: $selected, text: "aaa")
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
