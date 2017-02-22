//
//  RecordViewController.swift
//  Punching
//
//  Created by Ray on 2017/2/6.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview_employee: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview_employee.delegate = self
        tableview_employee.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_employee", for: indexPath) as! EmployeeTableViewCell
        let index = indexPath.row
        print("\(indexPath.row)")
        cell.name.text = "\(Employees[index].name!)"
        cell.index = Employees[index].index!
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_choise" {
            if let indexPath = tableview_employee.indexPathForSelectedRow {
                let destinationController = segue.destination as! ChoiseViewController
                destinationController.index = Employees[indexPath.row].index!
            }
        }
    }

}
