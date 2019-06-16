//
//  BoardInsertVC.swift
//  IntermittentFasting
//
//  Created by 박종현 on 26/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit
import Photos

class BoardInsertVC: UIViewController, UINavigationControllerDelegate {
    
    var contentTextView: UITextView!
    var imagePicker: UIImagePickerController!
    
    var photoList = Array<ModelImage>()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.imagePicker =  UIImagePickerController()
        self.imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
    }
    
    // MARK: - @IBAction
    @IBAction func confirmBtnClicked(_ sender: Any) {
        if self.photoList.count > 0 {
            StorageManager.shared.uploadImageList(photoList: self.photoList, id: "01", success: { array in
                print("array : \(array)")
                let title = "제목 제목 제목"
                let content = self.contentTextView.text!
                if content != "" {
                    var images = Array<ModelImage>()
                    for meta in array {
                        let image = ModelImage.init(meta: meta)
                        images.append(image)
                    }
                    let board = ModelBoard.init(title: title, content: content, images: images)
                    FireStoreManager.shared.createBoard(board: board, successBlock: { success in
                        
                        let alert = UIAlertController.init(title: "알림", message: "업로드에 성공했습니다.", preferredStyle: .alert)
                        let ok = UIAlertAction.init(title: "확인", style: .default, handler: { action in
                            self.dismiss(animated: true, completion: nil)
                        })
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }, failureBlock: { error in
                        
                    })
                }else {
                    let alert = UIAlertController.init(title: "알림", message: "내용을 넣어주세요.", preferredStyle: .alert)
                    let cancel = UIAlertAction.init(title: "확인", style: .cancel, handler: nil)
                    alert.addAction(cancel)
                    self.present(alert, animated: true, completion: nil)
                }
            }) { error in
                
            }
        }else {
            let title = "제목 제목 제목"
            let content = self.contentTextView.text!
            if content != "" {
                let board = ModelBoard.init(title: title, content: content, images: nil)
                FireStoreManager.shared.createBoard(board: board, successBlock: { success in
                    
                    let alert = UIAlertController.init(title: "알림", message: "업로드에 성공했습니다.", preferredStyle: .alert)
                    let ok = UIAlertAction.init(title: "확인", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }, failureBlock: { error in
                    
                })
            }else {
                let alert = UIAlertController.init(title: "알림", message: "내용을 넣어주세요.", preferredStyle: .alert)
                let cancel = UIAlertAction.init(title: "확인", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
}

// MARK: - UITableView
extension BoardInsertVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let number = 4
        return number
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if section == 2 {
            if self.photoList.count == 0 {
                numberOfRows = 0
            }else {
                numberOfRows = self.photoList.count
            }
        }else {
            numberOfRows = 1
        }
        return numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cell:BoardInsertCell!
        if section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardInsertTitle") as? BoardInsertCell
        }else if section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardInsertContent") as? BoardInsertCell
            self.contentTextView = cell.contentTextView as! UITextView
        }else if section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardInsertPhoto") as? BoardInsertCell
            if self.photoList.count > 0 {
                let image:ModelImage = self.photoList[row]
                cell.photoView.image = image.image
            }
        }else if section == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardInsertSelect") as? BoardInsertCell
        }else {
            cell = UITableViewCell.init() as? BoardInsertCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        let section = indexPath.section
        // let row = indexPath.row
        if section == 0 {
            height = 80
        }else if section == 1 {
            height = 200
        }else if section == 2 {
            height = 322
        }else if section == 3 {
            height = 50
        }else {
            
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        if section == 3 {
            // 이미지 선택
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
}

// MARK: - UIImagePicker
extension BoardInsertVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.editedImage] as? UIImage else {
            print("Image not found!")
            
            return
        }
        let format:String!
        
        let assetPath = info[.referenceURL] as! NSURL
        if (assetPath.absoluteString?.hasSuffix("JPG"))! {
            print("JPG")
            format = "JPG"
        } else if (assetPath.absoluteString?.hasSuffix("PNG"))! {
            print("PNG")
            format = "PNG"
        } else if (assetPath.absoluteString?.hasSuffix("GIF"))! {
            print("GIF")
            format = "GIF"
        } else {
            print("Unknown")
            format = "Unknown"
        }
        let image = ModelImage(format: format, image: selectedImage)
        self.photoList.append(image)
        self.tableView.reloadData()
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
}
