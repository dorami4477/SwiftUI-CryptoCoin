//
//  TrendingView.swift
//  SwiftUI-CryptoCoin
//
//  Created by 박다현 on 9/7/24.
//

import SwiftUI

struct TrendingView: View {
    let rows = [ GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80))]
    @State private var coinData = Trending(coins: [], nfts: [])
    @State private var marketData: [Market] = []
    private let repository = FavoriteRepository()
    var filteredCoin: [Coin] {
        coinData.coins.sorted { a, b in
            a.item.marketCapRank < b.item.marketCapRank
        }
    }
    var filteredNft: [Nft] {
        coinData.nfts
    }
    
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack {
                        subTilte("My Favorite")
                        ScrollView(.horizontal) {
                            LazyHStack{
                                ForEach(marketData, id: \.id) { item in
                                    favoriteList(item)
                                }
                            }
                        }
                        .padding(.bottom)
                        rowGroup("Top 15 Coin", items: filteredCoin)
                        rowGroup("Top 7 NFT", items: filteredNft)
                    }
                    .padding()
                }
                .navigationTitle("Crypto Coin")
                .toolbar {
                    Button {
                        print("버튼클릭")
                    } label: {
                        Image(systemName: "star")
                    }
                    
                }
                .onAppear {
                    NetworkManager.shared.callRequest { value in
                        coinData = value
                    }
                    getFavData()
                }
            }
    }
    
    func getFavData() {
        guard let allItem = repository?.fetchAllItem(true) else { return }
        _ = allItem.map { item in
            NetworkManager.shared.callMarketRequest(id: item.id) { value in
                marketData.append(contentsOf: value)
            }
        }
    }
    
    func rowGroup<item: Hashable>(_ title: String, items: [item]) -> some View{
        VStack{
            subTilte(title)
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 30) {
                    ForEach(items.indices, id: \.self) { index in
                        if let coin = items as? [Coin] {
                            topList(coin[index], index: index)
                        } else if let ntf = items as? [Nft] {
                            topNftList(ntf[index], index: index)
                        }
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
    func subTilte(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func topList(_ item: Coin, index: Int) -> some View {
        let chanage = item.item.data.priceChangePercentage24H["krw"]!
        return HStack {
            Text("\(index + 1)")
            AsyncImage(url: URL(string: item.item.small)!)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("\(item.item.name)")
                Text("\(item.item.symbol)")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(item.item.data.price)")
                Text(chanage > 0 ? "+\(String(format: "%.2f", chanage))%" : "\(String(format: "%.2f", chanage))%")
                    .font(.caption)
                    .foregroundStyle(chanage > 0 ? .red : .blue)
            }
        }
        .frame(width:300)
    }
    
    func topNftList(_ item: Nft, index: Int) -> some View {
        HStack {
            Text("\(index + 1)")
            AsyncImage(url: URL(string: item.thumb)!)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("\(item.name)")
                Text("\(item.symbol)")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(item.floorPriceInNativeCurrency)")
                Text("\(item.floorPrice24HPercentageChange)")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .frame(width:300)
    }
    
    func favoriteList(_ item: Market) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray.opacity(0.2))
                .frame(width: 220, height: 160)
            VStack{
                HStack{
                    AsyncImage(url: URL(string: item.image)!) { result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())

                    }

//                    Circle()
//                        .fill(.clear)
//                        .frame(width: 30, height: 30)
//                        .overlay(
//                            Image(systemName: "star")
//                                .resizable()
//                                .scaledToFill()
//                        )
                    
                    
                    VStack(alignment: .leading) {
                        Text("\(item.name)")
                        Text("\(item.symbol)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                Spacer()
                Text("\(item.currentPrice)")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(item.priceChangePercentage24H)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(width: 220, height: 160)
        }
    }
}
#Preview {
    TrendingView()
}
