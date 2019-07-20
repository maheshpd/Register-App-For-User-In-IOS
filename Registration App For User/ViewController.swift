//
//  ViewController.swift
//  Registration App For User
//
//  Created by Mahesh Prasad on 18/07/19.
//  Copyright © 2019 Mahesh Prasad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {

    let data = "http://magicconversion.com/barcodescanner/tagdata.php"
    let url = "http://magicconversion.com/barcodescanner/selectcity.php"
    let singleuser = "http://magicconversion.com/barcodescanner/singleuserdata.php"
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    func getData() {
        Alamofire.request(url, method: .get, parameters: ["place":"Mumbai"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .success:
                print(response)
                break
            case .failure(let error):
                print(error)
            }
        }
        
    }
}


