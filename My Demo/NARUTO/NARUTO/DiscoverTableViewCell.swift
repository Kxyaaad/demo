//
//  DiscoverTableViewCell.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/31.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
