//
//  ViewController.swift
//  Punching
//
//  Created by Ray on 2017/2/5.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit

class PunchingViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview_punching: UITableView!
    @IBOutlet weak var nowTime: UILabel!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview_punching.delegate = self
        tableview_punching.dataSource = self
        self.nowTime.text = "現在時間：" + getNowDate()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.nowTime.text = "現在時間：" + getNowDate()
        })
        print("total \(Employees.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Employees.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_employee", for: indexPath) as! PunchingTableViewCell
        let index = indexPath.row
        print("\(indexPath.row)")
        cell.name.text = "\(Employees[index].name!)"
        cell.id.text = "編號:\(Employees[index].id!)"
        cell.button_onwork.isEnabled = (Employees[index].onWork == "None" )
        cell.button_offwork.isEnabled = (Employees[index].offWork == "None" )
        if Employees[index].onWork != "None" {
            cell.onWorkTime.text = Employees[index].onWork
        }
        else {
          cell.onWorkTime.text = "無資料"
        }
        if Employees[index].offWork != "None" {
            cell.offWorkTime.text = Employees[index].offWork
        }
        else {
            cell.offWorkTime.text = "無資料"
        }
        cell.index = Employees[index].index!
        return cell
    }
}

