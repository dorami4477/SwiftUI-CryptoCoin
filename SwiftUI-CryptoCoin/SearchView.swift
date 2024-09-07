//
//  SearchView.swift
//  SwiftUI-CryptoCoin
//
//  Created by 박다현 on 9/7/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVStack{
                    ForEach(0..<10) { item in
                        searchResult()
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
            .toolbar {
                Button {
                    print("버튼클릭")
                } label: {
                    Image(systemName: "star")
                }
                
            }
        }

    }
    
    func searchResult() -> some View {
        HStack{
            Image(systemName: "star")
            VStack{
                Text("Hello, World!")
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
