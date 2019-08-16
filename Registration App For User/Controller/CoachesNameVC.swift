//
//  CoachesNameVC.swift
//  Registration App For User
//
//  Created by Mahesh Prasad on 30/07/19.
//  Copyright © 2019 Mahesh Prasad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SearchTextField
class CoachesNameVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var AllocationNameTable: UITableView!
   
    
    var allocationlist = [AllocationNameModel]()
    var coachNamelist = [String]()
    
    @IBOutlet weak var mySearchTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AllocationNameTable.delegate = self
        AllocationNameTable.dataSource = self
        
        getCoachName()
        getAllocationName()
        print(Common.tagno)
    }
    
    func getCoachName() {
        Alamofire.request(Common.getAllAllocationPeople).responseJSON { (response) in
            if(response.result.value != nil) {
                let swiftyJson = JSON(response.result.value!)
                for data in swiftyJson.arrayValue {
                    let name = data["name"].stringValue
                    self.coachNamelist.append(name)
                    
                    
                }
            }
        }
        
    }
    
    func getAllocationName(){
        Alamofire.request(Common.getSessionName, method: .post, parameters: ["tagno":Common.tagno], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if(response.result.value != nil) {
                let swiftyJson = JSON(response.result.value!)
                print(swiftyJson)
                
                for data in swiftyJson.arrayValue {
                    
                    
                    
                    self.allocationlist.append(AllocationNameModel(name: data["name"].stringValue, id: data["id"].stringValue))
                    
                    DispatchQueue.main.async {
                        self.AllocationNameTable.reloadData()
                    }
                    
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //       return coachNamelist.count
        
        return  allocationlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllocationCell", for: indexPath) as! AllocationCell
        cell.allocationName.text = allocationlist[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    //    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //
    //        switch tableView {
    //        case CoachNameTable:
    //            let setTag = UIContextualAction(style: .normal, title: "Add") { (action, sourceView, completionHandler) in
    //                completionHandler(true)
    //                let name = self.coachNamelist[indexPath.row]
    //                print(name)
    //            }
    //            let configuration = UISwipeActionsConfiguration(actions: [setTag])
    //            return configuration
    //        default:
    //                  print("Wrong")
    //        }
    //        return UISwipeActionsConfiguration()
    //
    //    }
    //
        @IBAction func backBtnTapped(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
        }
    
    @IBAction func addbtnTapped(_ sender: UIButton) {
        if mySearchTextField.text?.count == 0 {
            self.alertControll(title: "Field Required", message: "Enter allocation name")
        }else {
            
            let para: Parameters = ["tag_no": Common.tagno , "name":mySearchTextField.text!]
            
            Alamofire.request(Common.insertSessionName, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if (response.result.value != nil) {
                    let swiftyjson = JSON(response.result.value!)
                        print(swiftyjson)
                    
                    self.mySearchTextField.text = ""
                    self.getAllocationName()
                   
                }
            }
        }
    }
    
    
    func alertControll(title: String , message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHAndler) in
            let id = self.allocationlist[indexPath.row].id
            Alamofire.request(Common.delete_allocation_name, method: .post, parameters: ["id":id!], encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                if(response.result.value != nil) {
                    let swiftyValue = JSON(response.result.value!)
                    print(swiftyValue)
                    
                    self.getAllocationName()
                    
                    DispatchQueue.main.async {
                        self.AllocationNameTable.reloadData()
                    }
                }
            })
            
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
}

