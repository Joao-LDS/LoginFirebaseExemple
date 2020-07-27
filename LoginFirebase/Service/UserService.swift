//
//  UserService.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 22/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Firebase
import GoogleSignIn

class UserService {
    
    func fetchUser(completion: @escaping (User) -> Void) {
        if Auth.auth().currentUser != nil {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
                guard let dict = snapshot.value as? [String:AnyObject] else { return }
                let user = User(fromFirebaseWith: uid, dict)
                completion(user)
            }
        }
        if let user = GIDSignIn.sharedInstance().currentUser {
            guard let fullname = user.profile.name else { return }
            guard let email = user.profile.email else { return }
            guard let givenName = user.profile.givenName else { return }
            let user = User(fromGoogleWith: email, fullname, givenName)
            completion(user)
        }
    }
}
