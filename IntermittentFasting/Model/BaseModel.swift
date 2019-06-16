//
//  BaseModel.swift
//  IntermittentFasting
//
//  Created by 박종현 on 26/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    override init() {
        super.init()
    }
    
    init(_ dictionary:Dictionary<String, Any>) {
        super.init()
        
    }
    
    func objectToDictionary() -> Dictionary<String, Any> {
        let dictionary = Dictionary<String, Any>()
        return dictionary
    }
    
    
}
