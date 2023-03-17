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
    
    func fetch() {
        Requests.request("food", .get,
                         params: ["page": 1, "size": 10],
                         [Food].self)
        { data in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut) {
                    self.data += data
                }
            }
        }
    }
}
