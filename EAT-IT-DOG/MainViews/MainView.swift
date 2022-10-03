//
//  MainView.swift
//  EAT-IT-DOG
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Namespace private var animation
    
    // State Variable
    @State private var selectedView: Int = 2
    @State private var transition: AnyTransition = .slide
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Search Bar
            if selectedView != 0 {
                HStack(spacing: 0) {
                    TextField("", text: $searchText)
                        .placeholder("음식 이름을 입력하세요", when: searchText.isEmpty)
                        .foregroundColor(.basics)
                    Spacer()
                    Button(action: {
                        touch()
                    }) {
                        Image("MiniSearch")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.basics)
                            .frame(width: 28, height: 28)
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding([.leading, .trailing], 24)
                .frame(width: 303, height: 60)
                .background(Color.white)
                .roundedCorner(15)
                .padding([.top, .bottom], 40)
                .frame(maxWidth: .infinity)
                .background(Color.background.ignoresSafeArea())
                .transition(transition)
            }
            
            // View
            Group {
                switch selectedView {
                case 0: LoginView()
                case 1: SearchView()
                case 2: HomeView()
                case 3: OfferView()
                default: ProfileView()
                }
            }
            .transition(transition)
            
            // Tab Bar
            HStack {
                Spacer()
                ForEach(0..<5) { idx in
                    ZStack {
                        if selectedView == idx {
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(width: 20, height: 4)
                                .matchedGeometryEffect(id: "UpperBar", in: animation)
                                .padding(.bottom, 70)
                        }
                        Button(action: {
                            touch()
                            transition = selectedView < idx ? .backslide : .slide
                            withAnimation(.easeInOut) {
                                selectedView = idx
                            }
                        }) {
                            Image(["Logout", "Search", "Home", "Offer", "Profile"][idx])
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(selectedView == idx ? .white : .basics)
                                .frame(width: 30, height: 30)
                                .if(selectedView == idx) { $0.background(
                                    RoundedRectangle(cornerRadius: 17)
                                        .fill(Color.accentColor)
                                        .frame(width: 47, height: 47)
                                        .matchedGeometryEffect(id: "TabBar", in: animation)
                                )}
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            endTextEditing()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
