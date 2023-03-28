//
//  Request.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/14.
//

import SwiftUI
import Alamofire

class Requests {
    
    static func simple(_ uri: String,
                       _ method: HTTPMethod,
                       params: [String: Any]? = nil,
                       failure: @escaping () -> Void,
                       completion: @escaping () -> Void) {
        AF.request("\(API)\(uri)",
                   method: method,
                   parameters: params,
                   encoding: method == .get ? URLEncoding.default : JSONEncoding.default
        )
        .validate()
        .responseData { response in
            if let resdata = response.data {
                print(String(decoding: resdata, as: UTF8.self))
            }
            switch response.result {
            case .success:
                completion()
            case .failure:
                failure()
            }
        }
    }
    
    static func request<T: Codable>(_ uri: String,
                                    _ method: HTTPMethod,
                                    params: [String: Any]? = nil,
                                    _ model: T.Type,
                                    failure: @escaping () -> Void,
                                    completion: @escaping (T) -> Void) {
        AF.request("\(API)\(uri)",
                   method: method,
                   parameters: params,
                   encoding: method == .get ? URLEncoding.default : JSONEncoding.default
        )
        .validate()
        .responseData { response in
            if let resdata = response.data {
                print(String(decoding: resdata, as: UTF8.self))
            }
            switch response.result {
            case .success:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    //let decodedData = try! decoder.decode(T.self, from: data)
                    if let decodedData = try? decoder.decode(T.self, from: data) {
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    }
                }
            case .failure:
                failure()
            }
        }
    }
}
