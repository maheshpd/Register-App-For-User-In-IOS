//
//  ChooseCoachName.swift
//  Registration App For User
//
//  Created by Mahesh Prasad on 20/07/19.
//  Copyright © 2019 Mahesh Prasad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChooseCoachName: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    

    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    
    @IBOutlet weak var coachNameTbView: UITableView!
    
    let sessionUrl = "http://magicconversion.com/barcodescanner/getSessionName.php"
    
    var sessionlist = [ChooseCoachNameModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCoachName()
    }
   
    func getCoachName() {
        progressBar.startAnimating()
        Alamofire.request(sessionUrl, method: .post, parameters: ["tagno":Common.tagno], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if((response.result.value != nil)) {
                self.progressBar.isHidden = true
                self.progressBar.stopAnimating()
                
                let swiftyJson = JSON(response.result.value!)
                for data in swiftyJson.arrayValue {
                    self.sessionlist.append(ChooseCoachNameModel(id: data["id"].stringValue, name: data["name"].stringValue))
                    
                    DispatchQueue.main.async {
                        self.coachNameTbView.reloadData()
                    }
                }
            }
        }
    }
    
    
    @IBAction func backTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allocationCell", for: indexPath) as? AlocationCell
        
        cell?.AllocationName.text = sessionlist[indexPath.row].name
        return cell!
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    //MARK: - When user select name
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let allocationname = sessionlist[indexPath.row].name
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PasswordVC") as! PasswordVC
        vc.nameLbl = allocationname
        self.present(vc, animated: true, completion: nil)
        
    }
    
}
