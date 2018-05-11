//
//  Category.swift
//  ListUp
//
//  Created by apple on 11/05/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    
    // forward relationship
    // each Category has an one to many relationships with items
    let items = List<Item>()
    
}
