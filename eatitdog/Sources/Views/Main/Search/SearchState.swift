//
//  SearchState.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

import SwiftUI

class SearchState: ObservableObject {
    
    @Published var data: [Food] = []
    
    func fetch() {
        Requests.request("food", .get,
                         params: ["page": 1, "size": 10],
                         [Food].self)
        { data in
            withAnimation(.easeInOut) {
                self.data += data
            }
        }
    }
}
