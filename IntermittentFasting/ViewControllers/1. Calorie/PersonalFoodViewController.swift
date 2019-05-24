//
//  PersonalFoodViewController.swift
//  Test3
//
//  Created by sama73 on 2019. 5. 2..
//  Copyright © 2019년 sama73. All rights reserved.
//

import UIKit

class PersonalFoodViewController: UIViewController {

	// 음식 목록
	var arrFoodList: [String] = []
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var btnFoodAdd: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		// 음식 추가 버튼 그림자
		btnFoodAdd.layer.shadowColor = UIColor(hex: 0xFF7F67).cgColor
		btnFoodAdd.layer.shadowOffset = CGSize(width: 0, height: 4)
		btnFoodAdd.layer.shadowOpacity = 0.35
		
		tableView.isHidden = true
		
		// 화면 갱신
		updateScreen()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

	// 화면 갱신
	func updateScreen() {
		// 음식리스트
		arrFoodList.removeAll()
		let number = Int.random(in: 0 ... 5)
		for _ in 0..<number {
			arrFoodList += ["연어샐러드"]
		}
		
		if arrFoodList.count == 0 {
			tableView.isHidden = true
		}
		else {
			tableView.isHidden = false
			tableView.reloadData()
			
			let indexPath = NSIndexPath(row: NSNotFound, section: 0)
			tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
		}
	}
	
	// MARK: - Action
	// 음식 추가
	@IBAction func onFoodAddClick(_ sender: UIButton) {
		self.view.endEditing(true)
		
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

extension PersonalFoodViewController: UITableViewDataSource, UITableViewDelegate {
	// MARK:- UITableViewDataSource
	func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrFoodList.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 73.0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "FoodSearchTableViewCell") as! FoodSearchTableViewCell
		
		return cell
	}
	
	// MARK:- UITableViewDelegate
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		
	}
}
