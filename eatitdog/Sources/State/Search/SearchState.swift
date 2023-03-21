//
//  SearchState.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

class SearchState: ObservableObject {
    
    @Published var data: [Food] = []
    @Published var activated: Bool = false
    @Published var opacity: CGFloat = 1
    @Published var selected: Food?
    @Published var lastAxis: CGFloat? = nil
    
    @Published var page: Int = 0
    @Published var pagingEnded: Bool = false
    
    func reset() {
        self.lastAxis = nil
        self.page = 0
        withAnimation(.easeInOut) {
            self.pagingEnded = false
            self.selected = nil
            self.data = []
        }
    }
    
    func fetch(_ filter: FoodType?, _ keyword: String) {
        if !pagingEnded {
            
            var params: [String: Any] = ["page": page, "size": 10]
            
            if let filter { params["type"] = filter.rawValue }
            if !keyword.isEmpty { params["keyword"] = keyword }
            
            Requests.request("food\(params.count != 2 ? "/search" : "")", .get,
                             params: params,
                             [Food].self)
            { data in
                if data.isEmpty {
                    withAnimation(.easeInOut) {
                        self.pagingEnded = true
                    }
                } else {
                    self.page += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeInOut) {
                            self.data += data
                        }
                    }
                }
            }
        }
    }
}
