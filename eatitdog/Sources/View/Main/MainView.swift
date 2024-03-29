//
//  MainView.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

// MARK: - Main View
struct MainView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Namespace private var animation
    
    /// State
    @StateObject var state = MainState()
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Search Bar
            if state.selectedView != 0 {
                HStack(spacing: 0) {
                    TextField("", text: $state.searchText, onCommit: state.triggerSearch)
                        .placeholder("음식 이름을 입력하세요", when: state.searchText.isEmpty)
                        .disabled(state.searchStatus)
                        .foregroundColor(.basics)
                        .setFont(16)
                    Spacer()
                    Button(action: {
                        touch()
                        state.triggerSearch()
                        endTextEditing()
                    }) {
                        Image(state.searchStatus ? "Xmark" : "MiniSearch")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.basics)
                            .frame(width: 28, height: 28)
                            .rotationEffect(.degrees(state.searchStatus ? -90 : 0))
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding(.horizontal, 24)
                .frame(width: 303, height: 60)
                .background(Color.white)
                .cornerRadius(15)
                .padding(.bottom, 28)
                .padding(.top, 15)
                .frame(maxWidth: .infinity)
                .background(Color.background.ignoresSafeArea())
                .transition(state.transition)
            }
            
            // MARK: - View Changer
            Group {
                switch state.selectedView {
                case 0: LoginView()
                case 1: SearchView()
                case 2: HomeView(animation: animation)
                case 3: OfferView()
                default: ProfileView()
                }
            }
            .transition(state.transition)
            .environmentObject(state)
            
            // MARK: - Bottom Tab Bar
            HStack {
                Spacer()
                ForEach(0..<5) { idx in
                    ZStack {
                        if state.selectedView == idx {
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(width: 20, height: 4)
                                .matchedGeometryEffect(id: "UpperBar", in: animation)
                                .padding(.bottom, 70)
                        }
                        Button(action: {
                            touch()
                            if [0, 3, 4].contains(idx) {
                                withAnimation(.default) {
                                    state.logoutClicked.toggle()
                                }
                            } else {
                                state.transition = state.selectedView < idx ? .backslide : .slide
                                withAnimation(.easeInOut) {
                                    state.selectedView = idx
                                }
                            }
                        }) {
                            Image(["Logout", "Search", "Home", "Offer", "Profile"][idx])
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(state.selectedView == idx ? .white : .basics)
                                .frame(width: 30, height: 30)
                                .if(state.selectedView == idx) { $0.background(
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
        .alertSheet("현재는 지원하지 않는 기능입니다", "확인",
                    isPresented: $state.logoutClicked,
                    action: {
            withAnimation(.default) {
                state.logoutClicked = false
            }
        }, cancelButton: false)
        .alertSheet("서버에 연결할 수 없습니다", "닫기",
                    isPresented: $state.failure,
                    action: {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                exit(0)
            }
        }, cancelButton: false)
        .background(Color.white.ignoresSafeArea())
    }
}
