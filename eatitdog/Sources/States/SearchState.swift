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
    
    func fetch() {
        if !pagingEnded {
            Requests.request("food", .get,
                             params: ["page": page, "size": 10],
                             [Food].self)
            { data in
                if data.isEmpty {
                    self.pagingEnded = true
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
