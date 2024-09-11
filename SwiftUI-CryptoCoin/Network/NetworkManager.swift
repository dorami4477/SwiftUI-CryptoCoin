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

        let url = "https://api.coingecko.com/api/v3/search/trending"
        AF.request(url).responseDecodable(of: Trending.self) { response in
            switch response.result{
            case .success(let value):
                completion(value)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callSearchRequest(search: String, completion: @escaping (Search) -> Void) {
        
        let url = "https://api.coingecko.com/api/v3/search?query=\(search)"
        AF.request(url).responseDecodable(of: Search.self) { response in
            switch response.result{
            case .success(let value):
                completion(value)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callMarketRequest(id: String, completion: @escaping ([Market]) -> Void) {
        
        let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=krw&ids=\(id)"
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result{
            case .success(let value):
                completion(value)

            case .failure(let error):
                print(error)
            }
        }
    }
}
