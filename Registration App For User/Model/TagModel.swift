//
//  TagModel.swift
//  Registration App For User
//
//  Created by Mahesh Prasad on 20/07/19.
//  Copyright © 2019 Mahesh Prasad. All rights reserved.
//

import Foundation

class TagModel {
    var tagno: String?
    var time: String?
    var ctf: String?
    var place: String?
    var name: String?
    var date: String
    var tf: String?
    var sessionname: String?
    
    init(tagno: String, time:String, ctf: String, place:String, name:String, date:String, tf:String , sessionname: String) {
        self.tagno = tagno
        self.time = time
        self.ctf = ctf
        self.place = place
        self.name = name
        self.date = date
        self.tf = tf
        self.sessionname = sessionname
    }
}
