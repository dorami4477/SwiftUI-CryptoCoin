//
//  Search.swift
//  SwiftUI-CryptoCoin
//
//  Created by 박다현 on 9/8/24.
//

import Foundation

struct Search: Decodable, Hashable {
    let coins: [SearchCoin]
}

struct SearchCoin: Decodable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    var like: Bool
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case symbol
        case thumb
        case like
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.thumb = try container.decode(String.self, forKey: .thumb)
        self.like = false 
    }
}
