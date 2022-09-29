//
//  ContentView.swift
//  EAT-IT-DOG
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}

struct ContentView: View {
    @Namespace private var animation
    @State var selectedView: Int = 0
    var body: some View {
        HStack {
            Spacer()
            ForEach(0..<5) { idx in
                Image(["Logout", "Search", "Home", "Offer", "Profile"][idx])
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(selectedView == idx ? .white : .basics)
                    .frame(width: 30, height: 30)
                    .if(selectedView == idx) { $0.background(
                        VStack {
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(width: 20, height: 5)
                            RoundedRectangle(cornerRadius: 17)
                                .fill(Color.accentColor)
                                .frame(width: 47, height: 47)
                        }
                            .padding(.bottom, 13)
                            .matchedGeometryEffect(id: "TabBar", in: animation)
                    )}
                    .onTapGesture {
                        withAnimation(.default) {
                            selectedView = idx
                        }
                    }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
