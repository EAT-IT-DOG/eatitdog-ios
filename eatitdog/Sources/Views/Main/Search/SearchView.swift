//
//  SearchView.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

// MARK: - Search View
struct SearchView: View {
    
    /// State
    @StateObject private var state = SearchState()
    @EnvironmentObject private var mainState: MainState
    
    /// Local Variables
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    var body: some View {
        
        VStack(spacing: 25) {
            
            // MARK: - Category Selection
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(FoodType.allCases, id: \.self) { row in
                            Button(action: {
                                touch()
                                withAnimation(.default) {
                                    if mainState.selectedFilter == row {
                                        mainState.selectedFilter = nil
                                    } else {
                                        mainState.selectedFilter = row
                                        if state.selected?.type != mainState.selectedFilter {
                                            state.selected = nil
                                        }
                                    }
                                }
                            }) {
                                Text(row.toName)
                                    .setFont(14, .medium)
                                    .padding([.leading, .trailing], 25)
                                    .frame(height: 34)
                                    .foregroundColor(mainState.selectedFilter == row ? row.toColor : .white)
                                    .if(mainState.selectedFilter != row) {
                                        $0.background(row.toColor)
                                        //.transition(.scale)
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .strokeBorder(row.toColor, lineWidth: 1)
                                    )
                                    .roundedCorner(15)
                            }
                            .buttonStyle(ScaleButtonStyle())
                            .id(row)
                        }
                    }
                    .padding([.leading, .trailing],
                             state.activated ? (screenWidth - 303) / 2 : screenWidth + 100)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut) {
                                state.activated.toggle()
                            }
                        }
                    }
                }
                .onChange(of: mainState.selectedFilter) { newValue in
                    withAnimation(.easeInOut) {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
            
            ZStack(alignment: .topTrailing) {
                GeometryReader { outsideProxy in
                    
                    // MARK: - Food Cards
                    ScrollViewReader { value in
                        ScrollView {
                            VStack(spacing: 0) {
                                GeometryReader { insideProxy in
                                    EmptyView()
                                        .onChange(of: insideProxy.frame(in: .global).minY) { newValue in
                                            state.opacity = 1 - (outsideProxy.frame(in: .global).minY - newValue) / 100
                                        }
                                }
                                LazyVStack(spacing: 24) {
                                    ForEach(state.data, id: \.self) { data in
                                        if [nil, data.type].contains(mainState.selectedFilter) {
                                            SearchCellView(selected: $state.selected, data: data)
                                        }
                                    }
                                }
                                .padding(.top, 58)
                                .padding(.bottom, 28)
                            }
                        }
                        .onChange(of: state.selected) { newValue in
                            if let toValue = newValue {
                                withAnimation(.easeInOut) {
                                    value.scrollTo(toValue.id, anchor: .top)
                                }
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
                
                // MARK: - Safeness
                if state.selected == nil {
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
                    .transition(.opacity)
                    .padding(.trailing, (screenWidth - 303) / 2)
                    .opacity(state.opacity > 0.6 ? state.opacity : 0.6)
                }
            }
        }
        .customBackground()
        .onAppear(perform: state.fetch)
        .onDisappear {
            mainState.selectedFilter = nil
        }
    }
}
