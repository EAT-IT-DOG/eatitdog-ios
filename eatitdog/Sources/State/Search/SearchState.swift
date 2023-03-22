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

    @Published var page: Int = 0
    @Published var pagingEnded: Bool = false

    func reset() {
        self.page = 0
        withAnimation(.default) {
            self.pagingEnded = false
            self.selected = nil
            self.data = []
        }
    }
    
    func fetch(_ filter: FoodType?, _ keyword: String, _ failure: @escaping () -> Void) {
        if !pagingEnded {
            
            var params: [String: Any] = ["page": page, "size": 10]
            
            if let filter { params["type"] = filter.rawValue }
            if !keyword.isEmpty { params["keyword"] = keyword }
            
            Requests.request("food\(params.count != 2 ? "/search" : "")", .get,
                             params: params,
                             [Food].self, failure: failure)
            { data in
                if data.isEmpty {
                    withAnimation(.default) {
                        self.pagingEnded = true
                    }
                } else {
                    self.page += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.default) {
                            self.data += data
                        }
                    }
                }
            }
        }
    }
}
