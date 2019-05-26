//
//  BoardCell.swift
//  IntermittentFasting
//
//  Created by 박종현 on 24/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class BoardCell: UITableViewCell {

    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var photo01ImageView: UIImageView!
    @IBOutlet weak var photo02ImageView: UIImageView!
    @IBOutlet weak var photo03ImageView: UIImageView!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var pushBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
