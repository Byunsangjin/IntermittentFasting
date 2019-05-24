//
//  InputInfoViewController.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 19/04/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InputInfoViewController: UIViewController {
    // MARK:- Outlets
    
    @IBOutlet var genderButton: [ButtonLayer]!
    
    @IBOutlet var heightTextField: TextFieldLayer!
    @IBOutlet var weightTextField: TextFieldLayer!
    
    @IBOutlet var heightWarningImg: UIImageView!
    @IBOutlet var weightWarningImg: UIImageView!
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var heightTFConstraint: NSLayoutConstraint!
    
    @IBOutlet var cmLabel: UILabel!
    @IBOutlet var kgLabel: UILabel!
    
    @IBOutlet var nextBtnView: GradationView!
    
    @IBOutlet var birthLabel: UILabel!
    
    
    
    // MARK:- Variables
    var disposeBag = DisposeBag()
    
    
    
    // MARK:- Methods
    override func viewDidLoad() {        
        super.viewDidLoad()
        print("Weight View DidLoad")
        setUI()
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        disposeBag = DisposeBag()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    func setUI() {
        self.mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        self.nextBtnView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextBtnClick)))
        
        birthLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(birthLabelClick)))
        
        // 신장 텍스트필드
        heightTextField.rx.text.orEmpty
            .map({ str in
                if str.count > 3 {
                    self.heightTextField.text = str.left(3)
                }
                return str
            })
            .map(isTextFieldEmpty)
            .subscribe(onNext: { b in
                self.heightWarningImg.isHidden = !b
                self.cmLabel.isHidden = b
            }).disposed(by: disposeBag)
        
        // 체중 텍스트필드
        weightTextField.rx.text.orEmpty
            .map({ str in
                if str.count > 3 {
                    self.heightTextField.text = "300"
                }
                return str
            })
            .map(isTextFieldEmpty)
            .subscribe(onNext: { b in
                self.weightWarningImg.isHidden = !b
                self.kgLabel.isHidden = b
            }).disposed(by: disposeBag)
        
        // 키보드 알림 센터에 등록
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
    
    func isTextFieldEmpty(text: String) -> Bool {
        return text.isEmpty
    }
    
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print("input")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            // 신장 TextField의 중앙 Constraint + 30
            let keyboardShowHeight = keyboardHeight - (UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 2) * heightTFConstraint.multiplier) + 30
            
            self.bottomConstraint.constant = keyboardShowHeight
            self.topConstraint.constant = -keyboardShowHeight
            
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.bottomConstraint.constant = 0
        self.topConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
    @objc func nextBtnClick() {
        let selectWayVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectWayViewController") as! SelectWayViewController
        self.present(selectWayVC, animated: true)
    }
    
    
    
    @objc func birthLabelClick() {
        let datePickerVC = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        
        self.addChild(datePickerVC)
        self.view.addSubview(datePickerVC.view)
        
        datePickerVC.datePicker.date = Date().stringToDate(from: birthLabel.text!)
    }
    
    
    
    // MARK:- Actions
    @IBAction func backBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func genderBtnClick(_ sender: UIButton) {
        let selectColor = UIColor(hexString: "60DDB4")
        let unSelectTextColor = UIColor.black
        let unSelectBorderColor = UIColor(hexString: "B6B6B6")
        
        genderButton.forEach { (button) in
            if button.tag == sender.tag { // 선택한 버튼
                button.borderColor = selectColor
                button.setTitleColor(selectColor, for: .normal)
            } else { // 선택하지 않은 버튼
                button.borderColor = unSelectBorderColor
                button.setTitleColor(unSelectTextColor, for: .normal)
            }
        }
    }
}
