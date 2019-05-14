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
	// 음식 목록
	var arrFoodList: [String] = []
	
	@IBOutlet var lbTitle: UILabel!
	@IBOutlet var vContent: UIView!
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		vContent.layer.masksToBounds = false
		
		// 그림자 처리
		vContent.layer.shadowColor = UIColor.black.cgColor
		vContent.layer.shadowOffset = CGSize(width: 0, height: 3)
		vContent.layer.shadowOpacity = 0.17
		
		tableView.isHidden = true
		
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FoodListViewController: UITableViewDataSource, UITableViewDelegate {
	// MARK:- UITableViewDataSource
	func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrFoodList.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 55.0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListTableViewCell") as! FoodListTableViewCell
		
		return cell
	}
	
	// MARK:- UITableViewDelegate
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		
	}
}
