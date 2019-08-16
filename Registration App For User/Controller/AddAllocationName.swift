//
//  AddAllocationName.swift
//  Registration App For User
//
//  Created by Mahesh Prasad on 29/07/19.
//  Copyright © 2019 Mahesh Prasad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AddAllocationName: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return coachNamelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoachNameCell", for: indexPath) as! CoachNameCell
        cell.coachName?.text = coachNamelist[indexPath.row].name
        return cell
    }
    
    
    
    var allocationlist = [AllocationNameModel]()
    var coachNamelist = [AllocationNameModel]()
    @IBOutlet weak var allocationName: UITableView!
    
    @IBOutlet weak var CoachNameTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allocationName.delegate = self
        allocationName.dataSource = self
        CoachNameTable.delegate = self
        CoachNameTable.dataSource = self
        
        
        getCoachName();
        getSessionName();
    }
    
    func getSessionName(){
        Alamofire.request(Common.getSessionName, method: .post, parameters: ["tagno":Common.tagno], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if(response.result.value != nil) {
                let swiftyJson = JSON(response.result.value!)
                
                for data in swiftyJson.arrayValue {
                    self.coachNamelist.append(AllocationNameModel(name: data["name"].stringValue, id: data["id"].stringValue))
                    
                    DispatchQueue.main.async {
                        self.allocationName.reloadData()
                    }
                }
                
            }
        }
    }
    
    
    func getCoachName() {
        Alamofire.request(Common.getAllAllocationPeople).responseJSON { (response) in
            if(response.result.value != nil) {
                let swiftyJson = JSON(response.result.value!)
                for data in swiftyJson.arrayValue {
                    self.allocationlist.append(AllocationNameModel(name: data["name"].stringValue, id: data["id"].stringValue))
                    
                    DispatchQueue.main.async {
                        self.CoachNameTable.reloadData()
                    }
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        var numberOfRow = 1
//        switch tableView {
//        case CoachName:
//            numberOfRow = coachNamelist.count
////        case allocationName:
////            numberOfRow = allocationlist.count
//        default:
//            print("Some thing Wrong!!")
//        }
//
//        return numberOfRow
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "AllocationCell", for: indexPath) as! AllocationCell
//
//       let cell = tableView.dequeueReusableCell(withIdentifier: "CoachNameCell", for: indexPath) as! CoachNameCell
//
//        cell.nameLbl.text = coachNamelist[indexPath.row].name
//
////        var cell = UITableViewCell()
////        switch tableView {
////        case allocationName:
////            cell = tableView.dequeueReusableCell(withIdentifier: "AllocationCell", for: indexPath) as? AllocationCell
////           cell.detailTextLabel?.text = allocationlist[indexPath.row].name
//
////        case CoachName:
//
////        cell.detailTextLabel?.text = coachName[indexPath.row].name
//
//
////        default:
////            print("Some thing wrongwww")
////        }
//
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let setTag = UIContextualAction(style: .destructive, title: "Add") { (action, sourceView, completionHandler) in
//
//            let names = self.allocationlist[indexPath.row].name
//            let para: Parameters = ["tag_no":Common.tagno, "name":names!]
//
//            Alamofire.request(Common.insertSessionName, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
//                if (response.result.value != nil) {
////                    let swiftyJson = JSON(response.result.value!)
//
//                    self.getSessionName();
////                    let message = swiftyJson["message"].stringValue
////                    self.alertControll(title: "Name Add", message: message)
//                }
//            })
//
//        }
//        let configuration = UISwipeActionsConfiguration(actions: [setTag])
//        return configuration
//    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, sourceView, completionHandler) in
//            let id = self.allocationlist[indexPath.row].id
//            let para: Parameters = ["id":id!]
//            Alamofire.request(Common.insertSessionName, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
//                if(response.result.value != nil) {
//
//                    let swiftyJson = JSON(response.result.value!)
//                    let message = swiftyJson["tag"].stringValue
//                    self.alertControll(title: "Delete", message: message)
//                }
//            })
//        }
//
//        let configuration = UISwipeActionsConfiguration(actions: [delete])
//        return configuration
//    }
    
    
    
    func alertControll(title: String , message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
