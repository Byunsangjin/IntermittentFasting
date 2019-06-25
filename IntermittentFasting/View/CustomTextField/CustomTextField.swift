//
//  CustomTextField.swift
//  IntermittentFasting
//
//  Created by 김삼현 on 25/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

	override init(frame: CGRect) {
		super.init(frame: frame)
		initTextField()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initTextField()
	}
	
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

	func initTextField() {
		// 커서 색상 변경(안드로이드 처럼)
		tintColor = UIColor.init(hex: 0x009edc)
		
		// 키보드 자판 색상
		keyboardAppearance = .default
		
		// 키보드 타입
		//    if (self.keyboardType == UIKeyboardTypeNumberPad) {
		// 숫자판 툴바 생성
		let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
		numberToolbar.barStyle = .default
		//	[numberToolbar setTranslucent:YES];
		numberToolbar.items = [
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
			UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.doneClicked))
		]
		numberToolbar.sizeToFit()
		
		inputAccessoryView = numberToolbar
	}
	
	@objc func doneClicked() {
		resignFirstResponder()
	}
}
