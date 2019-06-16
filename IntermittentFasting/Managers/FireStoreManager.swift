//
//  FireStoreManager.swift
//  IntermittentFasting
//
//  Created by 박종현 on 26/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FireStoreManager: NSObject {
    static let shared = FireStoreManager()
    
    let db = Firestore.firestore()
    
    override init() {
        super.init()
        
    }
    
    func selectBoard(success: @escaping (_ array:Array<ModelBoard>) -> Void) {
        print("selectBoard")
        self.selectDB(collection: "Board") { array in
            print("array : \(array)")
            var result = Array<ModelBoard>()
            for dictionary in array {
                result.append(ModelBoard.init(dictionary))
            }
            success(result)
        }
    }
    
    func selectDB(collection:String, success: @escaping (_ array:Array<Dictionary<String, Any>>) -> Void) {
        print("selectDB")
        let ref = db.collection(collection)
        ref.whereField("delete_yn", isEqualTo: false).order(by: "create_date", descending: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var array:Array<Dictionary<String, Any>> = Array<Dictionary<String, Any>>()
                print("Success")
                for document in querySnapshot!.documents {
                    var dictionary:Dictionary<String, Any> = document.data()
                    dictionary["id"] = document.documentID
                    print("dictionary : \(dictionary)")
                    array.append(dictionary)
                }
                success(array)
            }
        }
    }
    
    func createBoard(board:ModelBoard, successBlock: @escaping (_ success:Bool) -> Void, failureBlock:  @escaping (_ error:Error) -> Void) {
        print("createBoard")
        self.createDB(collection: "Board", object: board, successBlock: { success in
            successBlock(success)
        }) { error in
            failureBlock(error)
        }
    }
    // 생성
    func createDB(collection:String, object:BaseModel, successBlock: @escaping (_ success:Bool) -> Void, failureBlock: @escaping (_ error:Error) -> Void) {
        print("createDB")
        db.collection(collection).addDocument(data: object.objectToDictionary()) { error in
            if let err = error {
                failureBlock(err)
            }else {
                successBlock(true)
            }
        }
    }

    func updateBoard(collection:String, document:String, object:BaseModel, successBlock: @escaping (_ success:Bool) -> Void, failureBlock: @escaping (_ error:Error) -> Void) {
    
    }
    // 수정
    func updateDB(collection:String, document:String, object:BaseModel, successBlock: @escaping (_ success:Bool) -> Void, failureBlock: @escaping (_ error:Error) -> Void) {
        let docRef = db.collection(collection).document(document)
        docRef.setData(object.objectToDictionary()) { error in
            if let err = error {
                failureBlock(err)
            }else {
                successBlock(true)
            }
        }
    }
}
