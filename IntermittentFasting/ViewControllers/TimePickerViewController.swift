//
//  TimePickerViewController.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 26/04/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {
    @IBOutlet var timePicker: UIDatePicker!
    
    var parentVC: SelectWayViewController?
    
    // MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTap)))
        
        self.parentVC = self.parent as? SelectWayViewController
        parentVC!.timeLabel.forEach { (label) in
            if label.tag == 1 { // 선택된 라벨
                timePicker.date = Date().stringToTime(from: label.text!)
            }
        }
    }
    
    
    
    @objc func viewTap() {
        parentVC!.timeLabel.forEach { (label) in
            if label.tag == 1 { // 선택된 라벨
                label.tag = 0
            }
        }
        
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    
    
    // MARK:- Actions
    @IBAction func pickerValueChange(_ sender: UIDatePicker) {
        parentVC!.timeLabel.forEach { (label) in
            if label.tag == 1 { // 선택된 라벨
                label.text = sender.date.timeToString()
            }
        }
    }
}



