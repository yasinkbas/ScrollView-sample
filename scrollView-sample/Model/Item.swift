//
//  Item.swift
//  scrollView-realm-sample
//
//  Created by Yasin Akbaş on 25.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import RealmSwift

class Item: Object {
    @objc dynamic var id = ""
    @objc dynamic var itemName = ""
    @objc dynamic var itemDesc = ""
    
    convenience init(itemName: String, itemDesc: String) {
        self.init()
        self.itemName = itemName
        self.itemDesc = itemDesc
    }
    
    override static func primaryKey() -> String? {
      return "id"
    }
}


