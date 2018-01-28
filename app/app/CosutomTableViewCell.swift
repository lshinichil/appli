//
//  CosutomTableViewCell.swift
//  app
//
//  Created by 井元進一 on 2018/01/23.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit

class CosutomTableViewCell: UITableViewCell {
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var TextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
