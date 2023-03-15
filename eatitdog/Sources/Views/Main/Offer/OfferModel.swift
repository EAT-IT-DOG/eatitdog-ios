//
//  OfferModel.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/15.
//

import Combine

class OfferModel: ObservableObject {
    
    @Published var foodName: String = ""
    @Published var isDangerous: Bool? = nil
    @Published var foodCategory: String = ""
    @Published var howToFeed: String = ""
    @Published var goodThings: String = ""
    @Published var warnings: String = ""
    
}
