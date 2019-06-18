//
//  ModelImage.swift
//  IntermittentFasting
//
//  Created by 박종현 on 26/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit
import FirebaseStorage

class ModelImage: BaseModel {
    // 이미지 아이디
    var id = String()
    // 이미지 url
    var url = String()
    // 이미지 path
    var path = String()
    // 이미지 포맷
    var format = String()
    // 이미지
    var image = UIImage()
    // 이미지 사이즈
    var size = Int()
    // 이미지 가로
    var width = Int()
    // 이미지 세로
    var height = Int()
    // 이미지 썸네일 url
    var thumbUrl = String()
    // 이미지 name
    var name = String()
    
    init(format:String, image:UIImage) {
        super.init()
        self.format = format
        self.image = image
    }
    init(meta:StorageMetadata) {
        super.init()
        let dictionary = meta.dictionaryRepresentation()
        print("dictionary : \(dictionary)")
        if let name = dictionary["name"] {
            self.name = name as! String
        }
    }
    
    override init(_ dictionary: Dictionary<String, Any>) {
        super.init(dictionary)
    }
    
    override func objectToDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        
        return dictionary
    }
}
