//
//  ChoiseViewController.swift
//  Punching
//
//  Created by Ray on 2017/2/22.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ChoiseViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    var index = 0
    var Choise = [Month]()
    
    @IBOutlet weak var tableview_month: UITableView!
    @IBOutlet weak var datePicker_begin: UIDatePicker!
    @IBOutlet weak var datePicker_end: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview_month.delegate = self
        tableview_month.dataSource = self
        self.title = "請選擇月份"
        self.getMonthData()
    }
    
    func getMonthData(){
        Choise.removeAll()
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("Employee").child("\(index)").child("Record").observeSingleEvent(of: .value, with: { (snapshot) in
            print( "firebaseData :" + snapshot.key)
            //let value = snapshot.value as? NSDictionary
            if let years = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for year in years {
                    // Make our jokes array for the tableView.
                    print( "firebaseData :" + year.key)
                    if let months = year.children.allObjects as? [FIRDataSnapshot] {
                        for month in months {
                            let model = Month()
                            print( "firebaseData :" + month.key)
                            model.year = year.key
                            model.month = month.key
                            self.Choise.append(model)
                        }
                    }
                }
                self.tableview_month.reloadData()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }

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
        return Choise.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_month", for: indexPath) as! ChoiseTableViewCell
        let index = indexPath.row
        print("\(indexPath.row)")
        cell.month.text = "\(Choise[index].year!)年\(Choise[index].month!)月"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_puching" {
            if let indexPath = tableview_month.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailPuchingViewController
                destinationController.index = self.index
                getPunchingData(year: Choise[indexPath.row].year!,month: Choise[indexPath.row].month!,content: destinationController)
            }
        }else if segue.identifier == "into_other_punching" {
            let destinationController = segue.destination as! DetailPuchingViewController
            destinationController.index = self.index
            getOtherPunchingData(content: destinationController)
        }
    }
    
    func getPunchingData(year:String, month:String, content:DetailPuchingViewController) -> Void {
        content.Punchings.removeAll()
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("Employee").child("\(index)").child("Record").child(year).child(month).observeSingleEvent(of: .value, with: { (snapshot) in
            print( "firebaseData :" + snapshot.key)
            if let days = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for day in days {
                    if let punching = day.value as? Dictionary<String, AnyObject> {
                        print( "\(year)/\(month) : " + day.key)
                        let model = Punching()
                        model.onWork = punching["onWork"] as? String ?? "無資料"
                        model.offWork = punching["offWork"] as? String ?? "無資料"
                        model.day = day.key
                        model.year = year
                        model.month = month
                        content.Punchings.append(model)
                     }
                }
                content.tableview_punching.reloadData()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getOtherPunchingData(content:DetailPuchingViewController){
        let begin = datePicker_begin.date.timeIntervalSince1970
        let end = datePicker_end.date.timeIntervalSince1970
        let Calendar_begin = Calendar.autoupdatingCurrent.dateComponents([.year,.month,.day], from: datePicker_begin.date)
        let Calendar_end = Calendar.autoupdatingCurrent.dateComponents([.year,.month,.day], from: datePicker_end.date)
        if begin <= end {
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            ref.child("Employee").child("\(index)").child("Record").observeSingleEvent(of: .value, with: { (snapshot) in
                if let years = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for year in years {
                        if !(Int(year.key)! >= Calendar_begin.year! && Int(year.key)! <= Calendar_end.year!){
                            continue
                        }
                        if let months = year.children.allObjects as? [FIRDataSnapshot] {
                            for month in months {
                                if let days = month.children.allObjects as? [FIRDataSnapshot] {
                                    for day in days {
                                        let date = convertDayFormater(date: "\(year.key)/\(month.key)/\(day.key)")
                                        if date.timeIntervalSince1970 >= begin && date.timeIntervalSince1970 <= end{
                                            if let punching = day.value as? Dictionary<String, AnyObject> {
                                                let model = Punching()
                                                model.onWork = punching["onWork"] as? String ?? "無資料"
                                                model.offWork = punching["offWork"] as? String ?? "無資料"
                                                model.day = day.key
                                                model.year = year.key
                                                model.month = month.key
                                                content.Punchings.append(model)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                content.tableview_punching.reloadData()
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
}
