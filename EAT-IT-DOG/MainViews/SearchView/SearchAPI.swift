//
//  SearchAPI.swift
//  EAT-IT-DOG
//
//  Created by Mercen on 2022/10/03.
//

struct SearchDatas: Decodable, Hashable {
    let status: Int
    let message: String
    let data: [SearchData]
}

struct SearchData: Decodable, Hashable {
}
