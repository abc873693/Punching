//
//  UserPuchingViewController.swift
//  Punching
//
//  Created by Ray on 2017/2/22.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DetailPuchingViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var tableview_punching: UITableView!
    @IBOutlet weak var text_hours: UILabel!
    @IBOutlet weak var text_salary: UILabel!
    @IBOutlet weak var picker_count: UIPickerView!
    
    var index = 0
    var Punchings = [Punching]()
    var salarys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 125...140 {
            salarys.append("\(i)")
            }
        tableview_punching.delegate = self
        tableview_punching.dataSource = self
        tableview_punching.reloadData()
        picker_count.delegate = self
        picker_count.dataSource = self
        self.title = "薪資情況"
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        var sum:Float = 0
        for item in Punchings {
            sum += item.totalTime!
        }
        text_hours.text = "總時數：" + String(format: "%.2f", sum) + "小時"
        let total = Float(salarys[picker_count.selectedRow(inComponent: 0)])! * sum
        text_salary.text = "薪資：" + String(format: "%.2f", total) + "元"
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
        return Punchings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_detail_punching", for: indexPath) as! DetailPuchingTableViewCell
        let index = indexPath.row
        print("\(indexPath.row)")
        cell.text_date.text = "\(Punchings[index].year!)年\(Punchings[index].month!)月\(Punchings[index].day!)日"
        cell.text_onWork.text = "上班：" + Punchings[index].onWork!
        cell.text_offWork.text = "下班：" + Punchings[index].offWork!
        if Punchings[index].onWork != "無資料" && Punchings[index].offWork != "無資料" {
            let begin = convertDateFormater(date : Punchings[index].onWork!)
            let end = convertDateFormater(date : Punchings[index].offWork!)
            let sum = Date(timeIntervalSince1970: end.timeIntervalSince1970 - begin.timeIntervalSince1970)
            print("\(end.timeIntervalSince1970)   \(begin.timeIntervalSince1970)")
            let formatSum = Calendar.autoupdatingCurrent.dateComponents([.hour,.minute], from: sum)
            var floatSum = Float(formatSum.hour! - 8)
            if formatSum.minute!>=25 && formatSum.minute! <= 35 {
                floatSum += 0.5
            }else if formatSum.minute! > 35 {
                floatSum += (Float(formatSum.minute!) / 60.0)
            }
            Punchings[index].totalTime = floatSum
            cell.text_total_hours.text = String(format: "%.2f", floatSum) + "小時"
            
        }else{
            Punchings[index].totalTime = 0
            cell.text_total_hours.text = "無法計算"
        }
        
        return cell
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int {
        return salarys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return salarys[row]
    }
}
