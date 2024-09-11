//
//  FavoriteRepository.swift
//  SwiftUI-CryptoCoin
//
//  Created by 박다현 on 9/9/24.
//

import Foundation
import RealmSwift

final class FavoriteRepository{
    
    private let realm: Realm
    
    init?() {
        do {
            self.realm = try Realm()
        } catch {
            print("faild to initialze Realm")
            return nil
        }
    }
    
    //Create
    func createData(data:Favorite) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("faild to create data")
        }
        
    }
    
    //Delete
    func deleteData(data:Favorite) {
        let data = realm.object(ofType: Favorite.self, forPrimaryKey: data.id)!
        
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("faild to delete data")
        }
    }
    
    //Delete All
    func deleteAllData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("faild to delete all")
        }
    }
    
    //Read one
    func fetchSingleItem(_ id:String) -> Favorite? {
        let specificItem = realm.object(ofType: Favorite.self, forPrimaryKey: id)
        return specificItem
    }
    
    //Read all
    func fetchAllItem(_ ascending: Bool) -> [Favorite]? {
        let value = realm.objects(Favorite.self)
        return Array(value)
    }
    
}
