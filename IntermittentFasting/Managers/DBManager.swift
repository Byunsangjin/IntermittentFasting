//
//  DBManager.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 15/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager: NSObject {
    // MARK:- Constants
    static let shared = DBManager()
    
    
    
    // MARK:- Variables
    var database: Realm!
    
    
    
    override init() {
        super.init()
        print("DBManager init")
        
        database = try! Realm()
    }
}
