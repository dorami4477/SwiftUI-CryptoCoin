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
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVStack{
                    ForEach(searchData, id:\.self) { item in
                        searchResult(item)
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
            Image(systemName: "star")
        }
        .padding(.vertical)
    }
}

#Preview {
    SearchView()
}
