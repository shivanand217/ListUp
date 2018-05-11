//
//  Item.swift
//  ListUp
//
//  Created by apple on 11/05/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Int = 0
    
    // inverse Relationship of items
    // i.e each item has inverse Relationship with the Category
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
