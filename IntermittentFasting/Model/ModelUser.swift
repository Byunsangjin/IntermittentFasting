//
//  User.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 10/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import Realm
import RealmSwift

class ModelUser: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var birth = ""
    @objc dynamic var gender = 1 // 0 남자 1 여자
    @objc dynamic var weight = 0.0
    @objc dynamic var height = 0.0
}

