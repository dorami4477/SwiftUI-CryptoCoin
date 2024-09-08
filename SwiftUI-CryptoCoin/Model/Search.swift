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
}
