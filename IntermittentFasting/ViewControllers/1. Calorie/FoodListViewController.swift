//
//  FoodListViewController.swift
//  IntermittentFasting
//
//  Created by 김삼현 on 09/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class FoodListViewController: UIViewController {

	var currentDate: (year: Int, month: Int, day: Int)?
	
	@IBOutlet var lbTitle: UILabel!
	@IBOutlet var vContent: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
//		vContent.layer.cornerRadius = 5.0
//		vContent.layer.borderColor = UIColor.lightGray.cgColor
//		vContent.layer.borderWidth = 1.0
		vContent.layer.masksToBounds = false
		
		// 그림자 처리
		vContent.layer.shadowColor = UIColor.black.cgColor
		vContent.layer.shadowOffset = CGSize(width: 0, height: 3)
		vContent.layer.shadowOpacity = 0.17
		
		// 화면 갱신
		updateScreen()
	}
	
	// 화면 갱신
	func updateScreen() {
		if let currentDate = self.currentDate {
			self.lbTitle.text = "\(currentDate.year)-\(currentDate.month)-\(currentDate.day)"
		}
		else {
			self.lbTitle.text = ""
		}
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
