//
//  MainState.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/17.
//

import SwiftUI

class MainState: ObservableObject {
    
    @Published var selectedView: Int = 2
    @Published var transition: AnyTransition = .slide
    
    @Published var searchState: Bool = false
    @Published var searchText: String = ""
    
    @Published var logoutClicked: Bool = false
    @Published var selectedFilter: FoodType?
    
}
