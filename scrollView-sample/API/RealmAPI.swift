//
//  RealmApi.swift
//  scrollView-realm-sample
//
//  Created by Yasin Akbaş on 25.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import Foundation
import RealmSwift

class RealmAPI {
    
    fileprivate var db: Realm!
    
    init() {
        do {
            db = try Realm()
        } catch {
            print(error)
        }
    }
    
    func addItem(_ item: Object) {
        do {
            try db.write {
                db.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func updateItem(item: Object, newItem: Object) {
        do {
            try db.write {
                var item = item
                item = newItem
                db.add(item, update: Realm.UpdatePolicy.modified)
            }
        } catch {
            print(error)
       }
    }
    
    func deleteItem(item: Object) {
        do {
            try db.write {
                db.delete(item)
            }
        } catch {
            print(error)
        }
    }
}
