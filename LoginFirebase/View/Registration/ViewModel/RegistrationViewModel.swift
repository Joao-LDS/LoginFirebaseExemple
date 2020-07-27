//
//  RegistrationViewModel.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 14/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Firebase

protocol RegistrationViewModelDelegate {
    func presentAlert()
}

struct RegistrationViewModel {
    
    var delegate: RegistrationViewModelDelegate?
    
    func registerUser(_ email: String,_ password: String,_ fullname: String,_ username: String,_ image: UIImage) {
        AuthFirebase().registerUser(email, password, fullname, username, image) { error, ref in
            print("Sign up sucessful")
            self.delegate?.presentAlert()
        }
    }
}
