//
//  ContentView.swift
//  SwiftUI-CryptoCoin
//
//  Created by 박다현 on 9/6/24.
//

import SwiftUI

struct ContentView: View {
    let rows = [ GridItem(.fixed(80)), GridItem(.fixed(80))]
    let colors: [Color] = [.black, .blue, .brown, .cyan, .gray, .indigo, .mint, .yellow, .orange, .purple]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("My Favorite")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal) {
                    LazyHStack{
                        ForEach(0..<5) { item in
                            favoriteList()
                        }
                    }
                }
                Text("Top 15 Coin")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal) {
                      LazyHGrid(rows: rows) {
                        ForEach(colors, id: \.self) { color in
                          RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 80)
                            .foregroundColor(color)
                        }
                      }
                    }
            }
            .padding()
            .navigationTitle("Crypto Coin")
        }
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
    ContentView()
}
