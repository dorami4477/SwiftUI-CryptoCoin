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
                                ForEach(0..<5) { item in
                                    favoriteList()
                                }
                            }
                        }
                        .padding(.bottom)
                        subTilte("Top 15 Coin")
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows, spacing: 30) {
                                ForEach(filteredCoin, id:\.self) { item in
                                    topList(item)
                                }
                            }
                        }
                        .padding(.bottom)
                        subTilte("Top 7 NFT")
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows, spacing: 30) {
                                ForEach(filteredNft, id:\.self) { item in
                                    topNftList(item)
                                }
                            }
                        }
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
//                .onAppear {
//                    NetworkManager.shared.callRequest { value in
//                        coinData = value
//                    }
//                    
//                }
            }
    }
    
    func subTilte(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func topList(_ item: Coin) -> some View {
        HStack {
            Text("\(item.item.marketCapRank)")
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
                Text("\(item.item.data.priceChangePercentage24H["krw"]!)")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .frame(width:300)
    }
    
    func topNftList(_ item: Nft) -> some View {
        HStack {
            Text("1")
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
    
    func favoriteList() -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray.opacity(0.2))
                .frame(width: 220, height: 160)
            VStack{
                HStack{
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .background(.yellow)
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading) {
                        Text("Bitcoin")
                        Text("BTC")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                Spacer()
                Text("69,234,245")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("+0.64%")
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
