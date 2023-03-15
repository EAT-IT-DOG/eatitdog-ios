//
//  Request.swift
//  eatitdog
//
//  Created by Mercen on 2023/03/14.
//

import SwiftUI
import Alamofire

class Requests {
    static func failure() {
        if NetworkReachabilityManager()!.isReachable {
        } else {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                exit(0)
            }
        }
    }
    
    static func simple(_ uri: String,
                       _ method: HTTPMethod,
                       params: [String: Any]? = nil,
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
                self.failure()
            }
        }
    }
    
    static func request<T: Codable>(_ uri: String,
                                    _ method: HTTPMethod,
                                    params: [String: Any]? = nil,
                                    _ model: T.Type,
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
                    let decodedData = try! decoder.decode(T.self, from: data)
                    if let decodedData = try? decoder.decode(T.self, from: data) {
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    }
                }
            case .failure:
                self.failure()
            }
        }
    }
}
