//
//  UZTextField.swift
//  UZTextFieldSample
//
//  Created by 박종현 on 09/04/2019.
//  Copyright © 2019 Znfod. All rights reserved.
//

import UIKit

@IBDesignable
class UZTextField: UIView {

    weak var delegate: UZTextFieldDelegate?
    
	public var hintLabel: UILabel!
	public var inputTextfield: UITextField!
    
    @IBInspectable var textSize: CGFloat = 0
	@IBInspectable var keyboardType: Int = 0
	@IBInspectable var marginRight:CGFloat = 0
    @IBInspectable var hint: String = ""
    @IBInspectable var lineHeight:CGFloat = 1
    
    @IBInspectable var lineColor:UIColor = UIColor.black
    @IBInspectable var textColor:UIColor = UIColor.black
    @IBInspectable var titleColor:UIColor = UIColor.black
    @IBInspectable var hintColor:UIColor = UIColor.lightGray
	
	
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("frame : \(frame)")
        
        sharedInit()
    }
	
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("aDecoder : \(aDecoder)")
		
		sharedInit()
    }
	
	override open func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		
		sharedInit()
	}
	
	func sharedInit() {
		// Common logic goes here
		
	}
    
    override func draw(_ rect: CGRect) {
        print("rect : \(rect)")

		setBottomLine(rect)
		setHintLabel(rect)
		setTextField(rect)
    }
	
    private func setBottomLine(_ rect: CGRect) {
        let frame = CGRect.init(x: 0, y: rect.height-lineHeight, width: rect.width, height: lineHeight)
        let line = UIView.init(frame: frame)
        line.backgroundColor = lineColor
        self.addSubview(line)
    }
	
    private func setTextField(_ rect: CGRect) {
		var frame = rect
		frame.size.width = frame.width - marginRight
        self.inputTextfield = UITextField.init(frame: frame)
        self.inputTextfield.font = UIFont.systemFont(ofSize: self.textSize)
		self.inputTextfield.keyboardType = UIKeyboardType.init(rawValue: keyboardType)!
        self.inputTextfield.delegate = self
        self.inputTextfield.borderStyle = .none
        self.inputTextfield.textColor = textColor
        self.addSubview(self.inputTextfield)
    }
	
    private func setHintLabel(_ rect: CGRect) {
        self.hintLabel = UILabel.init(frame: rect)
        self.hintLabel.font = UIFont.systemFont(ofSize: self.textSize)
        self.hintLabel.text = hint
        self.hintLabel.textColor = hintColor
        self.addSubview(self.hintLabel)
    }
	
    func setTitle() {
        print("show")
        var rect = self.inputTextfield.frame
        let height = rect.height
        rect.origin.y = rect.origin.y - height
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.hintLabel.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
                self.hintLabel.frame = rect
                self.hintLabel.textColor = self.titleColor
            })
        }
    }
	
    func setHint() {
        print("hide")
        if self.textExist() {
            
        }else {
            let rect = self.inputTextfield.frame
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, animations: {
                    self.hintLabel.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                    self.hintLabel.frame = rect
                    self.hintLabel.textColor = self.hintColor
                })
            }
        }
    }
	
    // inputTextField 에 Text가 있으면 true 없으면 false
    func textExist() -> Bool{
        if self.inputTextfield.text == "" {
            return false
        }else {
            return true
        }
    }
    
    override func resignFirstResponder() -> Bool {
        self.inputTextfield.resignFirstResponder()
        return true;
    }
    
    var text: String{
        get {
            return self.inputTextfield.text!
        }
        set {
            self.inputTextfield.text = newValue
        }
    }

}

extension UZTextField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("UZTextField textFieldShouldBeginEditing")
        let result = delegate?.UZTextFieldShouldBeginEditing()
        self.setTitle()
        return result!
    }
	
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("UZTextField textFieldDidBeginEditing")
        delegate?.UZTextFieldDidBeginEditing()
    }
	
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("UZTextField textFieldShouldEndEditing")
        let result = delegate?.UZTextFieldShouldEndEditing()
        self.setHint()
        return result!
    }
	
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("UZTextField textFieldDidEndEditing")
        delegate?.UZTextFieldDidEndEditing()
        
    }
	
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("UZTextField textFieldDidEndEditing")
        let result = delegate?.UZTextFieldShouldReturn()
        return result!
    }
}

protocol UZTextFieldDelegate: class {
    func UZTextFieldShouldBeginEditing() -> Bool
    func UZTextFieldDidBeginEditing()
    func UZTextFieldShouldEndEditing() -> Bool
    func UZTextFieldDidEndEditing()
    func UZTextFieldShouldReturn() -> Bool
}
