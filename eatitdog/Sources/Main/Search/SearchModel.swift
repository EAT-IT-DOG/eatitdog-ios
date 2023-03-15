//
//  SearchModel.swift
//  eatitdog
//
//  Created by Mercen on 2022/09/29.
//

struct SearchDatas: Decodable, Hashable {
    let status: Int
    let message: String
    let data: [SearchData]
}

struct SearchData: Decodable, Hashable {
}
