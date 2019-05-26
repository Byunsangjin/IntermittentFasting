//
//  DatePickerViewController.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 13/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    // MARK:- Outlets
    @IBOutlet var datePicker: UIDatePicker!
    
    
    // MARK:- Variables
    var date: String?
    var parentVC: InputInfoViewController?
    
    
    // MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimViewTap)))
        
        parentVC = self.parent as? InputInfoViewController
    }
    
    
    
    func dismissAlert() {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    
    
    @objc func dimViewTap() {
        dismissAlert()
    }
    
    
    
    
    
    // MARK:- Actions
    @IBAction func okBtnClick(_ sender: Any) {
        parentVC?.birthLabel.text = datePicker.date.dateToString()
        
        dismissAlert()
    }
    
    
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        dismissAlert()
    }
    
    
    
}
