//
//  DetailTableViewCell.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/15.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var valueLable: UILabel!
    @IBOutlet weak var fileLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
