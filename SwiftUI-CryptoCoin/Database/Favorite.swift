//
//  Favorite.swift
//  SwiftUI-CryptoCoin
//
//  Created by 박다현 on 9/9/24.
//

import Foundation
import RealmSwift

final class Favorite: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var symbol: String
    @Persisted var thumb: String
    
    convenience init(id: String, name: String, symbol: String, thumb: String) {
        self.init()
        self.id = id
        self.name = name
        self.symbol = symbol
        self.thumb = thumb
    }
}
