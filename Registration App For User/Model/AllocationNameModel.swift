//
//  AllocationNameModel.swift
//  Registration App For User
//
//  Created by Mahesh Prasad on 29/07/19.
//  Copyright © 2019 Mahesh Prasad. All rights reserved.
//

import Foundation

class AllocationNameModel {
    var name: String?
    var id: String?
    init(name: String?, id:String) {
        self.name = name
        self.id = id
    }
    
    init(name:String) {
        self.name = name
    }
    
}
