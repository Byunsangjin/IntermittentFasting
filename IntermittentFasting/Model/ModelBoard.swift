//
//  ModelPost.swift
//  IntermittentFasting
//
//  Created by 박종현 on 26/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

enum BoardType{
    case notice
    case normal
    case edu
    case none
}

class ModelBoard: BaseModel {
    // 게시글 타입
    var type:BoardType = .none
    // 게시글 아이디
    var id = String()
    // 게시글 제목
    var title = String()
    // 게시글 작성시간
    var create_date = Int()
    // 게시글 작성자 이름
    var writer_name = String()
    // 게시글 작성자 아이디
    var writer_id = String()
    // 게시글 내용
    var content = String()
    // 게시글 이미지 리스트
    var images = Array<ModelImage>()
    // 게시글 유투브
    var youtube = ModelYoutube()
    // 게시글 삭제 유무
    var delete_yn = false
    
    override init(_ dictionary: Dictionary<String, Any>) {
        super.init(dictionary)
        if let type = dictionary["type"] as? BoardType{
            self.type = type
        }
        if let id = dictionary["id"] as? String{
            self.id = id
        }
        if let title = dictionary["title"] as? String{
            self.title = title
        }
        if let create_date = dictionary["create_date"] as? Int{
            self.create_date = create_date
        }
        if let writer_name = dictionary["writer_name"] as? String{
            self.writer_name = writer_name
        }
        if let writer_id = dictionary["writer_id"] as? String{
            self.writer_id = writer_id
        }
        if let content = dictionary["content"] as? String{
            self.content = content
        }
        if let images = dictionary["images"] as? String{
            
        }
        if let youtube = dictionary["youtube"] as? String{
            
        }
    }
    // 최초 생성
    init(title:String, content:String, images:Array<ModelImage>!) {
        super.init()
        self.title = title
        self.content = content
        if let images = images {
            self.images = images
        }
        self.create_date = Int(Date().timeIntervalSince1970 * 1000000)
        self.writer_id = "01"
        self.writer_name = "관리자"
        
    }
    
    override func objectToDictionary() -> Dictionary<String, Any> {
        print("objectToDictionary")
        var dictionary = Dictionary<String, Any>()
        
        dictionary["title"] = title
        
        dictionary["create_date"] = create_date
        
        dictionary["writer_name"] = writer_name
        
        dictionary["writer_id"] = writer_id
        
        dictionary["content"] = content
        
        dictionary["images"] = self.arrayToString()
        
        dictionary["delete_yn"] = false
        print("dictionary : \(dictionary)")
        return dictionary
    }
    func arrayToString() -> String {
        var str = String()
        for image in self.images {
            str.append(image.name)
            if image != self.images.last {
                str.append(",")
            }
        }
        return str
    }
}
