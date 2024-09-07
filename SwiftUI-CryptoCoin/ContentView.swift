//
//  ContentView.swift
//  SwiftUI-CryptoCoin
//
//  Created by 박다현 on 9/6/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            TrendingView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
            }

        }
}

#Preview {
    ContentView()
}
