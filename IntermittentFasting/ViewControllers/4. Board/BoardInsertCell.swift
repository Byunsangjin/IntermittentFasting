//
//  BoardInsertCell.swift
//  IntermittentFasting
//
//  Created by 박종현 on 26/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class BoardInsertCell: UITableViewCell {

    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
