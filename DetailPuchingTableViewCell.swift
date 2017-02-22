//
//  MonthTableViewCell.swift
//  Punching
//
//  Created by Ray on 2017/2/6.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit

class DetailPuchingTableViewCell: UITableViewCell {

    @IBOutlet weak var text_date: UILabel!
    @IBOutlet weak var text_onWork: UILabel!
    @IBOutlet weak var text_offWork: UILabel!
    @IBOutlet weak var text_total_hours: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
