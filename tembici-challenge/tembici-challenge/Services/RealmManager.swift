//
//  RealmManager.swift
//  tembici-challenge
//
//  Created by Hannah  on 16/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//
import RealmSwift

class RealmManager {
    
    let realm = try! Realm()
    
    /**
     Delete local database
     */
    func deleteDatabase() {
        try! realm.write({
            realm.deleteAll()
        })
    }
    
    /**
     Save array of objects to database
     */
    func saveObjects(objs: [Favorite]) {
        try! realm.write({
            realm.add(objs)
        })
    }
    /*
     Delete object to database
     */
    func deleteData(favorite:Favorite){
        if let fav = self.getObjectById(id: favorite.id){
            try! realm.write {
                realm.delete(fav)
            }
        }
    }
    /*
     Get object to database
     */
    func getObjectById(id: Int) -> Favorite? {
        return realm.object(ofType: Favorite.self, forPrimaryKey: id)
    }
    
    /**
     Save array of objects to database
     */
    func saveObject(obj: Favorite) {
        try! realm.write({
            realm.add(obj)
        })
    }
    
    /**
     Returs an array as Results<Favorite>
     */
    func getObjects(type: Favorite.Type) -> Results<Favorite>? {
        return realm.objects(type)
    }
}
