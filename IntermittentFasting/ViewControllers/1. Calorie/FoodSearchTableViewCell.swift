//
//  FoodSearchTableViewCell.swift
//  IntermittentFasting
//
//  Created by 김삼현 on 14/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class FoodSearchTableViewCell: UITableViewCell {
	
	// 음식명
	@IBOutlet weak var lbFoodName: UILabel!
	// 칼로리
	@IBOutlet weak var lbCalories: UILabel!
	// 1회 제공량
	@IBOutlet weak var lbServingSize: UILabel!
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func setCellInfo(_ dicFoodData: [String: String]) {
		let FoodName: String = dicFoodData["FoodName"]!
		let Calories_kcal: String = dicFoodData["Calories_kcal"]!
		let ServingSize_g: String = dicFoodData["ServingSize_g"]!
		
		lbFoodName.text = FoodName
		lbCalories.text = "\(Calories_kcal) kcal"
		lbServingSize.text = "\(ServingSize_g)g/1인분"
	}
}
