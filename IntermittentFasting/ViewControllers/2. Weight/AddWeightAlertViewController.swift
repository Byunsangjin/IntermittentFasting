//
//  AddWeightAlertViewController.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 10/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class AddWeightAlertViewController: UIViewController {
    // MARK:- Outlets
    @IBOutlet var alertView: UIView!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    
    
    // MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        setUI()
    }
    
    
    
    func setUI() {
        self.alertView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTap)))
        
        // 키보드 알림 센터에 등록
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        self.weightTextField.becomeFirstResponder()
    }
    
    
    
    @objc func viewTap() {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.bottomConstraint.constant = (keyboardHeight)
            
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.5) {
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func dismissAlert() {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    
    
    // MARK:- Actions
    @IBAction func okBtnClick(_ sender: Any) {
        let weight = ModelWeight()
        let tuple = CalendarManager.getSelectedYearMonthDay()
        weight.date = String(format: "%d.%02d.%02d", tuple.year, tuple.month, tuple.day)        
        weight.weight = Double(weightTextField.text!) as! Double
        DBManager.shared.insertWeightDB(weight: weight)
        
        dismissAlert()
    }
    
    
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        dismissAlert()
    }
}
