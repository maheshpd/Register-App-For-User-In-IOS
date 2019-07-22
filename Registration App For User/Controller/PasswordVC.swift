//
//  PasswordVC.swift
//  Registration App For User
//
//  Created by Mahesh Prasad on 22/07/19.
//  Copyright © 2019 Mahesh Prasad. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PasswordVC: UIViewController {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    var nameLbl:String?
    
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = nameLbl
        ref = Database.database().reference()
        ref.child("Coach").child(nameLbl!)
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        
        progressBar.isHidden = false
        progressBar.startAnimating()
        
        if passwordTxt.text?.count == 0 {
        
           progressBar.stopAnimating()
            progressBar.isHidden = false
            alertControll(title: "Password", message: "Please enter password")
        }else {
            ref.observeSingleEvent(of: .value) { (snapshot) in
                let password = snapshot.childSnapshot(forPath: "password").value
                print(password!)
//                if ((passwordTxt.text?.elementsEqual(password))!){
//
//                }
            }
        }
        
    }
    
    func alertControll(title: String , message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
