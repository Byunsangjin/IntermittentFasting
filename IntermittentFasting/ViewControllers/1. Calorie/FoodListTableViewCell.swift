//
//  FoodListTableViewCell.swift
//  IntermittentFasting
//
//  Created by 김삼현 on 14/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class FoodListTableViewCell: UITableViewCell {

	@IBOutlet weak var lbFoodName: UILabel!
	@IBOutlet weak var lbCalorie: UILabel!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
