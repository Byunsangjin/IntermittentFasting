//
//  AlertMessagePopup.swift
//  PlannerDiary
//
//  Created by sama73 on 2019. 1. 4..
//  Copyright © 2019년 sama73. All rights reserved.
//
/*
let attrString1 = NSMutableAttributedString(string: "김치찌개", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
let attrString2 = NSAttributedString(string: "를\n추가하시겠습니까?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
attrString1.append(attrString2)

let popup = AlertMessagePopup.attributedMessagePopup(attributedMessage: attrString1)
popup.addActionConfirmClick("확인", handler: {
	
})

popup.addActionCancelClick("취소") {
	
}
*/

import UIKit

class AlertMessagePopup: BasePopup {

    @IBOutlet private weak var lbMessage: UILabel!
    @IBOutlet private weak var btnConfirm: UIButton!
    @IBOutlet private weak var btnCancel: UIButton!
    private var confirmClick: (() -> Void)?
    private var cancelClick: (() -> Void)?
    
    override func viewDidLoad() {
        
        // 딤드뷰 클릭시 팝업 닫아 주는 기능 막기
        self.isNotDimmedTouch = true;

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // 일반 메세지
    func messagePopup(_ message: String?) {
        // 딤드 알파 애니
        initGUI()
        
        lbMessage.text = message
    }
	
	// 속성 메세지
	func attributedMessagePopup(_ attributedMessage: NSAttributedString?) {
		// 딤드 알파 애니
		initGUI()
		
		lbMessage.attributedText = attributedMessage
	}
    
    func addActionConfirmClick(_ actionWithTitle: String?, handler ConfirmClick: @escaping () -> Void) {
        
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
            confirmAction()
        }
        
        removeFromParentVC()
    }
    
    func callbackWithCancel() {
        
        if let cancelAction = cancelClick {
            cancelAction()
        }
        
        removeFromParentVC()
    }
    
    // MARK: - Class Method
    /**
     message : 메세지
     */
    static func messagePopup(message: String?) -> AlertMessagePopup {
        
        let storyboard: UIStoryboard? = AppDelegate.sharedNamedStroyBoard("Common") as? UIStoryboard
        let MessagePopupVC = storyboard?.instantiateViewController(withIdentifier: "AlertMessagePopup") as? AlertMessagePopup
        // 팝업으로 떳을때
        MessagePopupVC!.providesPresentationContextTransitionStyle = true
        MessagePopupVC!.definesPresentationContext = true        
        MessagePopupVC!.modalPresentationStyle = .overFullScreen
        
        BasePopup.addChildVC(MessagePopupVC)
        
        // 데이터 세팅
        MessagePopupVC!.messagePopup(message)
        
        return MessagePopupVC!
    }
	
	static func attributedMessagePopup(attributedMessage: NSAttributedString?) -> AlertMessagePopup {
		
		let storyboard: UIStoryboard? = AppDelegate.sharedNamedStroyBoard("Common") as? UIStoryboard
		let MessagePopupVC = storyboard?.instantiateViewController(withIdentifier: "AlertMessagePopup") as? AlertMessagePopup
		// 팝업으로 떳을때
		MessagePopupVC!.providesPresentationContextTransitionStyle = true
		MessagePopupVC!.definesPresentationContext = true
		MessagePopupVC!.modalPresentationStyle = .overFullScreen
		
		BasePopup.addChildVC(MessagePopupVC)
		
		// 데이터 세팅
		MessagePopupVC!.attributedMessagePopup(attributedMessage)
		
		return MessagePopupVC!
	}
}
