//
//  SearchView.swift
//  SwiftUI-CryptoCoin
//
//  Created by 박다현 on 9/7/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchData: [SearchCoin] = []
    private let repository = FavoriteRepository()
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVStack{
                    ForEach(searchData, id:\.id) { item in
                        NavigationLink {
                            //TrendingView()
                        } label: {
                            searchResult(item)
                        }
                    
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                NetworkManager.shared.callSearchRequest(search: searchText) { value in
                    searchData = value.coins
                }
            }
            .toolbar {
                Button {
                    print("버튼클릭")
                } label: {
                    Image(systemName: "star")
                }
                
            }
        }

    }
    
    func searchResult(_ item: SearchCoin) -> some View {
        
        HStack{
            AsyncImage(url: URL(string: item.thumb)){ result in
                result.image?
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text("\(item.name)")
                Text("\(item.symbol)")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Button {
                toggleFavorite(item: item)
            } label: {
                Image(systemName: isFavorite(item.id) ? "star.fill" : "star")
            }
        }
        .padding(.vertical)
    }
    
    func toggleFavorite(item: SearchCoin) {
        print(item.id)
        if let likedItem = repository?.fetchSingleItem(item.id) {
            repository?.deleteData(data: likedItem)
        } else {
            let data = Favorite(id: item.id, name: item.name, symbol: item.symbol, thumb: item.thumb)
            repository?.createData(data: data)
        }
        
        if let index = searchData.firstIndex(where: { $0.id == item.id }) {
            searchData[index].like.toggle()
        }
    }
    
    func isFavorite(_ id: String) -> Bool {
            return repository?.fetchSingleItem(id) != nil
    }
    
}

#Preview {
    SearchView()
}
