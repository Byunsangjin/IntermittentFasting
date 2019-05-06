//
//  PersonalFoodViewController.swift
//  Test3
//
//  Created by sama73 on 2019. 5. 2..
//  Copyright © 2019년 sama73. All rights reserved.
//

import UIKit

class PersonalFoodViewController: UIViewController {

	@IBOutlet weak var btnFoodAdd: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		// 음식 추가 버튼 그림자
		btnFoodAdd.layer.shadowColor = UIColor(hex: 0xFF7F67).cgColor
		btnFoodAdd.layer.shadowOffset = CGSize(width: 0, height: 4)
		btnFoodAdd.layer.shadowOpacity = 0.35
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

	// MARK: - Action
	
	// 음식 추가
	@IBAction func onFoodAddClick(_ sender: UIButton) {
		let popupVC = PersonalFoodAddPopup.personalFoodAddPopup()
		popupVC.addActionConfirmClick("확인") { (strFoodName, calorie, gram) in
			print(strFoodName)
			print(calorie)
			print(gram)
		}
		
		popupVC.addActionCancelClick("취소") {
			
		}
	}
}
