//
//  NetworkManager.swift
//  SwiftUI-CryptoCoin
//
//  Created by 박다현 on 9/6/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func callRequest(completion: @escaping (Trending) -> Void) {
    //func callRequest() {
        let url = "https://api.coingecko.com/api/v3/search/trending"
        AF.request(url).responseDecodable(of: Trending.self) { response in
            switch response.result{
            case .success(let value):
                completion(value)
                print(value.coins)
            case .failure(let error):
                print(error)
            }
        }
    }
}
