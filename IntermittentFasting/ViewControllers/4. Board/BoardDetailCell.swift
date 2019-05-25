//
//  BoardDetailCell.swift
//  IntermittentFasting
//
//  Created by 박종현 on 25/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class BoardDetailCell: UITableViewCell {
    
    @IBOutlet weak var writeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var settingBtn: UIButton!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var commentWriterLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
