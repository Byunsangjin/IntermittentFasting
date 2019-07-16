//
//  FoodFindViewController.swift
//  Test3
//
//  Created by sama73 on 2019. 5. 2..
//  Copyright © 2019년 sama73. All rights reserved.
//

import UIKit

class FoodFindViewController: UIViewController {

	// 음식 목록
	var search: String = ""
	var arrFoodList: [[String: String]] = []
	var arrSearchFood: [[String: String]] = []
	
	@IBOutlet weak var tfSearch: UITextField!
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
		
		arrFoodList = DBManager.shared.getFoodList()
		arrSearchFood = arrFoodList
		
		if arrFoodList.count == 0 {
			tableView.isHidden = true
		}
		else {
			tableView.isHidden = false
			tableView.reloadData()
			
			let indexPath = NSIndexPath(row: NSNotFound, section: 0)
			tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
		}
		
		tfSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
	}
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		search = textField.text!
		
		// 빈문자일때 전체 목록
		if CommonUtil.isEmpty(search as AnyObject) {
			arrSearchFood = arrFoodList
		}
		// 검색어 필터 처리
		else {
			let predicate = NSPredicate(format: "FoodName CONTAINS[cd] %@", search)
			arrSearchFood = (arrFoodList as NSArray).filtered(using: predicate) as! [[String : String]]
		}
		
		tableView.reloadData()
	}
}

extension FoodFindViewController: UITableViewDataSource, UITableViewDelegate {
	// MARK:- UITableViewDataSource
	func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrSearchFood.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 73.0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let dicFoodData: [String: String] = arrSearchFood[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "FoodSearchTableViewCell") as! FoodSearchTableViewCell
		cell.setCellInfo(dicFoodData)
		
		return cell
	}
	
	// MARK:- UITableViewDelegate
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		
	}
}

//extension FoodFindViewController: UITextFieldDelegate {
//
//	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//		if string.isEmpty {
//			search = textField.text!
//		}
//		else {
//			search = textField.text! + string
//
//		}
//		print(search)
//		let predicate = NSPredicate(format: "FoodName CONTAINS[cd] %@", "김치찌개")
//		arrSearchFood = (arrFoodList as NSArray).filtered(using: predicate) as! [[String : String]]
//
//		tableView.reloadData()
//
//		return true
//	}
//}
