//
//  SelectWayViewController.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 23/04/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class SelectWayViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet var dayOfTheWeekButtons: [ButtonLayer]!
    @IBOutlet var rullButtons: [ButtonLayer]!
    
    @IBOutlet var completionButton: ButtonLayer!
    
    @IBOutlet var timeLabel: [UILabel]!
    
    
    // MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.forEach { (label) in
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(timeLabelClick(sender:))))
        }
    }
    
    
    
    @objc func timeLabelClick(sender: UITapGestureRecognizer) {
        let timePickerVC = self.storyboard?.instantiateViewController(withIdentifier: "TimePickerViewController") as! TimePickerViewController
        
        let label = sender.view
        label!.tag = 1
        
        self.addChild(timePickerVC)
        self.view.addSubview(timePickerVC.view)
    }
    
    
    
    // MARK:- Actions
    @IBAction func questionBtnClick(_ sender: Any) {
        let infoPageVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        
        self.addChild(infoPageVC)
        self.view.addSubview(infoPageVC.view)
    }
    
    
    
    @IBAction func backBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func rullBtnClick(_ sender: UIButton) {
        let selectColor = UIColor(hexString: "60DDB4")
        let unSelectTextColor = UIColor.black
        let unSelectBorderColor = UIColor(hexString: "B6B6B6")
        
        rullButtons.forEach { (button) in
            if button.tag == sender.tag { // 선택한 버튼
                button.borderColor = selectColor
                button.setTitleColor(selectColor, for: .normal)
            } else { // 선택하지 않은 버튼
                button.borderColor = unSelectBorderColor
                button.setTitleColor(unSelectTextColor, for: .normal)
            }
        }
    }
    
    
    
    @IBAction func weekBtnClick(_ sender: UIButton) {
        let selectColor = UIColor(hexString: "60DDB4")
        let unSelectTextColor = UIColor.black
        let unSelectBorderColor = UIColor(hexString: "B6B6B6")
        
        let button = sender as! ButtonLayer
        
        if sender.tag == 0 { // 선택 되지 않은 버튼이었다면
            sender.tag = 1
            button.borderColor = selectColor
            button.setTitleColor(selectColor, for: .normal)
        } else { // 선택 됐던 버튼이었다면
            sender.tag = 0
            button.borderColor = unSelectBorderColor
            button.setTitleColor(unSelectTextColor, for: .normal)
        }
    }
}



extension SelectWayViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
           scrollView.contentOffset.y = 0
        }
    }
}
