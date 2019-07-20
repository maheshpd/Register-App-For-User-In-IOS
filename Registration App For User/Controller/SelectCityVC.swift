//
//  SelectCityVC.swift
//  Registration App For User
//
//  Created by Mahesh Prasad on 19/07/19.
//  Copyright © 2019 Mahesh Prasad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SelectCityVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    var citylist = [CityModel]()
    
    @IBOutlet weak var cityNameCollection: UICollectionView!
    let url = "http://magicconversion.com/barcodescanner/selectcity.php"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func getData() {
        Alamofire.request(url).responseJSON { (response) in
            if((response.result.value != nil)) {
                let swiftyJsonValue = JSON(response.result.value!)
                for data in swiftyJsonValue.arrayValue {
                    self.citylist.append(CityModel(cityimage: data["imgUrl"].stringValue, cityName: data["cityname"].stringValue))
                    DispatchQueue.main.async {
                        self.cityNameCollection.reloadData()
                    }
                    
                }
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citylist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath) as? CityCell
        cell?.cityName.text = citylist[indexPath.row].cityName
        let cityimageLink = citylist[indexPath.row].cityimage!
        let url = URL(string: cityimageLink)
        cell?.cityImage.kf.setImage(with: url, placeholder: UIImage(named: "mumbai"), options: nil, progressBlock: nil, completionHandler: nil)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = citylist[indexPath.row].cityName
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectTag") as! SelectTag
        vc.nameLbl = name
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
}
