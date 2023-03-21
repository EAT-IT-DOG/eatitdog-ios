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
    
    @Published var searchTrigger: Bool = false
    @Published var searchStatus: Bool = false
    @Published var searchText: String = ""
    
    @Published var logoutClicked: Bool = false
    @Published var selectedFilter: FoodType?
    
    func triggerSearch() {
        if !self.searchText.isEmpty {
            self.transition = .slide
            withAnimation(.easeInOut) {
                if self.searchStatus {
                    self.searchText = ""
                }
                self.selectedView = 1
                self.searchStatus.toggle()
            }
            self.searchTrigger = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.searchTrigger = false
            }
        }
    }
}
