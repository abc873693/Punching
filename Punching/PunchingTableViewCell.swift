//
//  TableViewCell.swift
//  Punching
//
//  Created by Ray on 2017/2/6.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class PunchingTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var onWorkTime: UILabel!
    @IBOutlet weak var offWorkTime: UILabel!
    @IBOutlet weak var button_onwork: UIButton!
    @IBOutlet weak var button_offwork: UIButton!
    var index = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onWork(_ sender: UIButton) {
        let now = getNow()
        let calendar = Calendar.autoupdatingCurrent
        let path = calendar.dateComponents([.year, .month, .day], from: Date())
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("Employee").child("\(index)").child("Record").child("\(path.year!)").child("\(path.month!)").child("\(path.day!)").child("onWork").setValue(now)
        button_onwork.isEnabled = false
        onWorkTime.text = now
    }

    @IBAction func offWork(_ sender: UIButton) {
        let now = getNow()
        let calendar = Calendar.autoupdatingCurrent
        let path = calendar.dateComponents([.year, .month, .day], from: Date())
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("Employee").child("\(index)").child("Record").child("\(path.year!)").child("\(path.month!)").child("\(path.day!)").child("offWork").setValue(now)
        button_offwork.isEnabled = false
        offWorkTime.text = now
    }

}
