//
//  PersonalFoodAddPopup.swift
//  IntermittentFasting
//
//  Created by 김삼현 on 05/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class PersonalFoodAddPopup: UIViewController {

	// 팀드 뷰
	@IBOutlet weak var vDimmed: UIView!
	@IBOutlet weak var vContent: UIView!

	@IBOutlet weak var tfFoodName: UITextField!
	@IBOutlet weak var tfCalorie: UZTextField!
	@IBOutlet weak var tfGram: UZTextField!
	
	@IBOutlet weak var btnConfirm: UIButton!
	@IBOutlet weak var btnCancel: UIButton!
	private var confirmClick: ((_ foodName: String, _ calorie: Int, _ gram: Int) -> Void)?
	private var cancelClick: (() -> Void)?

    override func viewDidLoad() {
		
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.vDimmed.isAccessibilityElement = true
		
		view.backgroundColor = UIColor.clear
		
		// 딤드뷰 클릭시 팝업 닫아 주기
		vDimmed.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(callbackWithCancel)))
		
		// 적용된 뷰를 모달 처리 함
		view.accessibilityViewIsModal = true
		
		
		tfFoodName.attributedPlaceholder = NSAttributedString(string: "음식명을 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x60DDB4, alpha: 0.7)])
		tfFoodName.becomeFirstResponder()
		// 스케쥴 시작
//		self.perform(#selector(self.FirstTextFieldFocus), with: nil, afterDelay: 0.1)

		tfCalorie.delegate = self
		tfGram.delegate = self
    }
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let notifier = NotificationCenter.default
		notifier.addObserver(self,
							 selector: #selector(self.keyboardWillShow(_:)),
							 name: UIWindow.keyboardWillShowNotification,
							 object: nil)
		
		notifier.addObserver(self,
							 selector: #selector(self.keyboardWillHide(_:)),
							 name: UIWindow.keyboardWillHideNotification,
							 object: nil)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		NotificationCenter.default.removeObserver(self)
		
		super.viewWillDisappear(animated)
		
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

	// 실행후 최초 포커싱
	@objc func FirstTextFieldFocus() {
		tfFoodName.becomeFirstResponder()
	}
	
	func addActionConfirmClick(_ actionWithTitle: String?, handler ConfirmClick: @escaping (_ foodName: String, _ calorie: Int, _ gram: Int) -> Void) {
		
		btnConfirm.setTitle(actionWithTitle, for: .normal)
		
		btnConfirm.isHidden = false
		if cancelClick != nil {
			btnCancel.isHidden = false
		}
		else {
			btnCancel.isHidden = true
		}
		
		confirmClick = ConfirmClick
	}
	
	func addActionCancelClick(_ actionWithTitle: String?, handler CancelClick: @escaping () -> Void) {
		if CommonUtil.isEmpty(actionWithTitle as AnyObject) {
			return
		}
		
		btnCancel.setTitle(actionWithTitle, for: .normal)
		
		btnCancel.isHidden = false
		if confirmClick != nil {
			btnConfirm.isHidden = false
		} else {
			btnConfirm.isHidden = true
		}
		
		cancelClick = CancelClick
	}
	
	// MARK: - UIButton Action
	// 확인 버튼
	@IBAction func onConfirmClick(_ sender: Any) {
		callbackWithConfirm()
	}
	
	// 취소 버튼
	@IBAction func onCancelClick(_ sender: Any) {
		callbackWithCancel()
	}
	
	// MARK: - Callback Event
	func callbackWithConfirm() {
		
		if let confirmAction = confirmClick {
			let strFoodName = tfFoodName.text
			let strCalorie = tfCalorie.inputTextfield.text
			let strGram = tfGram.inputTextfield.text
			if strFoodName!.isEmpty {
				tfFoodName.becomeFirstResponder()
				return
			}
			if strCalorie!.isEmpty {
				tfCalorie.inputTextfield.becomeFirstResponder()
				return
			}
			if strGram!.isEmpty {
				tfGram.inputTextfield.becomeFirstResponder()
				return
			}

			confirmAction(strFoodName!, Int(strCalorie!)!, Int(strGram!)!)
		}
		
		self.dismiss(animated: false, completion: nil)
	}
	
	@objc func callbackWithCancel() {
		
		if let cancelAction = cancelClick {
			cancelAction()
		}
		
		self.dismiss(animated: false, completion: nil)
	}
	
	// MARK: - NotificationCenter
	// 인포커싱 되었을때 스크롤뷰 마진값 적용
	@objc func keyboardWillShow(_ notification: NSNotification) {
		print("keyboardWillShow")
		
		if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardRectangle = keyboardFrame.cgRectValue
			
			// iPhoneX 스타일 경우 마진을 34만큼 더준다.            
			var gapOffsetY : CGFloat = 0.0
			if CommonUtil.isIphoneX == true {
				gapOffsetY = 34.0
                print("실행!!")
			}
			// 키보드 높이
			let kbSizeHeight : CGFloat = keyboardRectangle.height - gapOffsetY
			
			UIView.animate(withDuration: 0.25, animations: { () -> Void in
				self.view.frame.origin.y = -kbSizeHeight
				self.view.layoutIfNeeded()
			})
		}
	}
	
	// 언포커싱 되었을때 스크롤뷰 마진값 해제
	@objc func keyboardWillHide(_ notification: NSNotification) {
		print("keyboardWillHide")

		UIView.animate(withDuration: 0.25, animations: { () -> Void in
			self.view.frame.origin.y = 0.0
			self.view.layoutIfNeeded()
		})
		
	}
	
	// MARK: - Class Method
	static func personalFoodAddPopup(parentVC: UIViewController) -> PersonalFoodAddPopup {
		
		let storyboard: UIStoryboard? = AppDelegate.sharedNamedStroyBoard("Common") as? UIStoryboard
		let popupVC = storyboard?.instantiateViewController(withIdentifier: "PersonalFoodAddPopup") as? PersonalFoodAddPopup
		// 팝업으로 떳을때
		popupVC!.providesPresentationContextTransitionStyle = true
		popupVC!.definesPresentationContext = true
		popupVC!.modalPresentationStyle = .overFullScreen
		
		parentVC.present(popupVC!, animated: false, completion: nil)
		
		return popupVC!
	}
}

extension PersonalFoodAddPopup: UZTextFieldDelegate {
	func UZTextFieldShouldBeginEditing() -> Bool {
		print("ViewController UZTextFieldShouldBeginEditing")
		return true
	}
	
	func UZTextFieldDidBeginEditing() {
		print("ViewController UZTextFieldDidBeginEditing")
		
	}
	
	func UZTextFieldShouldEndEditing() -> Bool {
		print("ViewController UZTextFieldShouldEndEditing")
		return true
	}
	
	func UZTextFieldDidEndEditing() {
		print("ViewController UZTextFieldDidEndEditing")
//		let text = self.textField.text
//		print("text : \(text)")
		
	}
	
	func UZTextFieldShouldReturn() -> Bool {
		print("ViewController textFieldShouldReturn")
//		let _ = self.textField.resignFirstResponder()
		return true
	}
}
