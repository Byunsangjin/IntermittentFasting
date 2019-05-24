//
//  ModelWeight.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 10/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import Realm
import RealmSwift

class ModelWeight: Object {    
    @objc dynamic var date = ""
    @objc dynamic var weight = 0.0
    
    override static func primaryKey() -> String? {
        return "date"
    }
}
