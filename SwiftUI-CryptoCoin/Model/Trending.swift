//
//  Trending.swift
//  SwiftUI-CryptoCoin
//
//  Created by 박다현 on 9/6/24.
//

import Foundation

struct Trending: Decodable, Hashable {
    let coins: [Coin]
    let nfts: [Nft]
}

// MARK: - Coin
struct Coin: Codable, Hashable {
    let item: Item
}

// MARK: - Item
struct Item: Codable, Hashable {
    let id: String
    let coinID: Int
    let name, symbol: String
    let marketCapRank: Int
    let thumb, small, large: String
    let slug: String
    let priceBtc: Double
    let score: Int
    let data: ItemData

    enum CodingKeys: String, CodingKey {
        case id
        case coinID = "coin_id"
        case name, symbol
        case marketCapRank = "market_cap_rank"
        case thumb, small, large, slug
        case priceBtc = "price_btc"
        case score, data
    }
}

// MARK: - ItemData
struct ItemData: Codable, Hashable {
    let price: Double
    let priceBtc: String
    let priceChangePercentage24H: [String: Double]
    let marketCap, marketCapBtc, totalVolume, totalVolumeBtc: String
    let sparkline: String
    let content: Content?

    enum CodingKeys: String, CodingKey {
        case price
        case priceBtc = "price_btc"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCap = "market_cap"
        case marketCapBtc = "market_cap_btc"
        case totalVolume = "total_volume"
        case totalVolumeBtc = "total_volume_btc"
        case sparkline, content
    }
}

// MARK: - Content
struct Content: Codable, Hashable {
    let title, description: String
}

// MARK: - Nft
struct Nft: Codable, Hashable {
    let id, name, symbol: String
    let thumb: String
    let nftContractID: Int
    let nativeCurrencySymbol: String
    let floorPriceInNativeCurrency, floorPrice24HPercentageChange: Double
    let data: NftData

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, thumb
        case nftContractID = "nft_contract_id"
        case nativeCurrencySymbol = "native_currency_symbol"
        case floorPriceInNativeCurrency = "floor_price_in_native_currency"
        case floorPrice24HPercentageChange = "floor_price_24h_percentage_change"
        case data
    }
}

// MARK: - NftData
struct NftData: Codable, Hashable {
    let floorPrice, floorPriceInUsd24HPercentageChange, h24Volume, h24AverageSalePrice: String
    let sparkline: String

    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
        case h24Volume = "h24_volume"
        case h24AverageSalePrice = "h24_average_sale_price"
        case sparkline
    }
}
