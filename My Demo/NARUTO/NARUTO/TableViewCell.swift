//
//  TableViewCell.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/9.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var tit: UILabel!
    @IBOutlet weak var det: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
