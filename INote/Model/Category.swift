//
//  Category.swift
//  INote
//
//  Created by User on 08/02/2019.
//  Copyright © 2019 Zakaria. All rights reserved.
//

import Foundation
import RealmSwift

class Category:Object{
    @objc dynamic var name:String=""
    //to create the relationship between one category and many items
    let items = List<Item>()
}
