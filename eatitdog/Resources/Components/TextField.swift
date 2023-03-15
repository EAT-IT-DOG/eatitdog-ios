//
//  TextField.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/15.
//

import SwiftUI

struct CustomTextField: View {
    
    let placeholder: String
    @Binding var text: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        TextField("", text: $text)
            .placeholder(placeholder, when: text.isEmpty)
            .setFont(14)
            .padding(.vertical, 10)
            .padding(.horizontal, 24)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.soft, lineWidth: 1))
    }
}
