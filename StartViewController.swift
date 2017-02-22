//
//  StartViewController.swift
//  Punching
//
//  Created by Ray on 2017/2/6.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class StartViewController: UIViewController {
    let username = "root@rainvitstor.com"
    let password = "Rain5345"

    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.signIn(withEmail: username, password: password) { (user, error) in
            if user?.email != nil {
                self.getData()
            }
            else {
                let quetion = UIAlertController(title: "firebase", message: "創建失敗", preferredStyle: .alert);
                //新增選項
                let OKaction = UIAlertAction(title: "好", style: .default , handler:nil);
                //把選項加到UIAlertController
                quetion.addAction(OKaction);
                //Show
                self.present(quetion, animated: true, completion: nil);
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        /*let userID = FIRAuth.auth()?.currentUser?.uid*/
        ref.child("Employee").observeSingleEvent(of: .value, with: { (snapshot) in
            
            print( "firebaseData :" + snapshot.key)
            //let value = snapshot.value as? NSDictionary
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                let calendar = Calendar.autoupdatingCurrent
                let now = calendar.dateComponents([.year, .month, .day], from: Date())
                for snap in snapshots {
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let model = Employee()
                        let key = snap.key
                        model.index = snap.key as? Int ?? 0
                        model.id = postDictionary["id"] as? String ?? ""
                        model.name = postDictionary["name"] as? String ?? ""
                        let todayPunching = snap.childSnapshot(forPath: "Record").childSnapshot(forPath: "\((now.year!))").childSnapshot(forPath: "\((now.month!))").childSnapshot(forPath: "\((now.day!))")
                        model.onWork = todayPunching.childSnapshot(forPath: "onWork").value as?String ?? "None"
                        model.offWork = todayPunching.childSnapshot(forPath: "offWork").value as?String ?? "None"
                        Employees.append(model)
                        print( "firebaseData :" + key + ":" + model.name!)
                        print( "\(now.year!)/\(now.month!)/\(now.day!)")
                        //self.jokes.insert(joke, atIndex: 0)
                    }
                }
                
            }
            
            self.performSegue(withIdentifier: "into_main", sender: self)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
