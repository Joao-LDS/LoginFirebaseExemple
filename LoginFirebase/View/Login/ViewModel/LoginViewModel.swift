//
//  LoginViewModel.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 20/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate {
    func presentMainView()
}

class LoginViewModel {
    
    static let shared = LoginViewModel()
    
    var delegate: LoginViewModelDelegate?
    
    func logUserIn(withEmail email: String, password: String) {
        AuthFirebase().logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }
            self.delegate?.presentMainView()
        }
    }
}
