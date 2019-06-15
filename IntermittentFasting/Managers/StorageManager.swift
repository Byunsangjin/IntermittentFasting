//
//  StorageManager.swift
//  firebaseSample
//
//  Created by 박종현 on 12/05/2019.
//  Copyright © 2019 Znfod. All rights reserved.
//

import UIKit
import FirebaseStorage

enum UploadFileType{
    case progress
    case success
    case fail
    case none
}

class StorageManager: NSObject {
    static let shared = StorageManager()
    
    let storage = Storage.storage()
    
    override init() {
        super.init()
        
    }
    
    func uploadImageList(photoList:Array<ModelImage>, id:String, success: @escaping (_ metadataList:Array<StorageMetadata>) -> Void, error: @escaping (_ error:Error) -> Void) {
        print("uploadImageList")
        var metadataList = Array<StorageMetadata>()
        for photo in photoList {
            let data = photo.image.pngData()!
            let fileName = String(Date().timeIntervalSince1970*1000000)
            let format = photo.format
            self.uploadFile(data: data, id: id, fileName: fileName, format: format, success: { metadata in
                metadataList.append(metadata)
                if metadataList.count == photoList.count {
                    success(metadataList)
                }
            }) { error in
                metadataList.append(StorageMetadata.init())
                if metadataList.count == photoList.count {
                    success(metadataList)
                }
            }
        }
    }
    func uploadFile(data:Data, id:String, fileName:String, format:String, success: @escaping (_ metadata:StorageMetadata) -> Void, error:  @escaping (_ error:Error) -> Void) {
        print("uploadFile")
    
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/\(id)/\(fileName).\(format)")
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = imageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            print("metadata : \(metadata)")
            
            // You can also access to download URL after upload.
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                print("downloadURL : \(downloadURL)")
                success(metadata)
            }
 
        }
        // Add a progress observer to an upload task
        let observer = uploadTask.observe(.progress) { snapshot in
            // A progress event occured
            print("progress : \(snapshot)")
        }
        let observer2 = uploadTask.observe(.resume) { snapshot in
            print("resume : \(snapshot)")
        }
        let observer3 = uploadTask.observe(.failure) { snapshot in
            print("failure : \(snapshot)")
        }
        let observer4 = uploadTask.observe(.success) { snapshot in
            print("success : \(snapshot)")
        }
    }
    
    func getImageDownloadUrl(path:String, success: @escaping (_ downloadUrl:URL) -> Void) {
        print("getImageDownloadUrl : \(path)")
        let storageRef = storage.reference()
        let imageRef = storageRef.child(path)
        imageRef.downloadURL { (url, error) in
            print("downloadURL")
            guard let downloadURL = url else {
                print("return")
                // Uh-oh, an error occurred!
                return
            }
            print("downloadURL : \(downloadURL)")
            success(downloadURL)
        }
    }
    
}



