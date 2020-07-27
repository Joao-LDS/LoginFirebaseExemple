//
//  User.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 22/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let username: String
    let profileImageUrl: String
    let uid: String
    
    init(fromFirebaseWith uid: String,_ dictionary: [String:AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
    init(fromGoogleWith email: String,_ fullname: String,_ givenName: String) {
        self.email = email
        self.fullname = fullname
        self.username = givenName
        self.profileImageUrl = ""
        self.uid = ""
    }
}
