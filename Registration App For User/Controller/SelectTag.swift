//
//  SelectTag.swift
//  Registration App For User
//
//  Created by Mahesh Prasad on 20/07/19.
//  Copyright © 2019 Mahesh Prasad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SelectTag: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tagTable: UITableView!
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    
    let data = "http://magicconversion.com/barcodescanner/tagdata.php"
    var taglist = [TagModel]()
    var nameLbl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(nameLbl!)
        
        getData()
    }
    
    func getData(){
        
        let para = ["place":nameLbl!]
        progressBar.startAnimating()
        Alamofire.request(data, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if((response.result.value != nil)) {
                
                self.progressBar.isHidden = true
                self.progressBar.stopAnimating()
                
               let swiftyJson = JSON(response.result.value!)
                for data in swiftyJson.arrayValue {
                    self.taglist.append(TagModel(tagno: data["tagno"].stringValue, time: data["time"].stringValue, ctf: data["ctf"].stringValue, place: data["place"].stringValue, name: data["name"].stringValue, date: data["date"].stringValue, tf: data["tf"].stringValue, sessionname: data["ss_name"].stringValue))
                    
                    DispatchQueue.main.async {
                        self.tagTable.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func backArrowTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taglist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath) as?  TagCell
        cell?.nameLbl.text = taglist[indexPath.row].name
        cell?.placeLbl.text = taglist[indexPath.row].place
        cell?.ctfLbl.text = taglist[indexPath.row].ctf
        cell?.tagLbl.text = taglist[indexPath.row].tagno
        cell?.dateLbl.text = taglist[indexPath.row].date
        cell?.timeLbl.text = taglist[indexPath.row].time
        
        let tf = taglist[indexPath.row].tf
        let sessionnane = taglist[indexPath.row].sessionname
        
        if ((sessionnane?.elementsEqual("True"))!) {
            cell?.tagBg.backgroundColor = UIColor.green
            if ((tf?.elementsEqual("True"))!) {
                cell?.tagBg.backgroundColor = UIColor.white
            }else {
                cell?.tagBg.backgroundColor = UIColor.green
            }
        }else {
            cell?.tagBg.backgroundColor = UIColor.red
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let name = taglist[indexPath.row].name
        let place = taglist[indexPath.row].place
        let ctf = taglist[indexPath.row].ctf
        let tagno = taglist[indexPath.row].tagno
        let date = taglist[indexPath.row].date
        let time = taglist[indexPath.row].time
        
        Common.ctf = ctf!
        Common.date = date
        Common.name = name!
        Common.place = place!
        Common.tagno = tagno!
        Common.time = time!
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChooseCoachName") as! ChooseCoachName
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
}
