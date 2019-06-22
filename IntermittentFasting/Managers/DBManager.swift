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
	
	// 음식 데이터
	var arrFoodData: [NSDictionary] = [];
    
    
    override init() {
        super.init()
        print("DBManager init")
        
        database = try! Realm()
		
		// 음식 데이터 로드
		foodDataLoad()
    }
	
	// 음식 데이터 로드
	func foodDataLoad() {
		let filePath = Bundle.main.path(forResource: "foodData", ofType: "json")
		var fileContents: String? = nil
		do {
			fileContents = try String(contentsOfFile: filePath!, encoding: .utf8)
			let data = fileContents?.data(using: .utf8)
			if let data = data {
				self.arrFoodData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [NSDictionary]
			}
		} catch {
		}
	}
}
