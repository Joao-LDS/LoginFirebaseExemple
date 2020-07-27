//
//  MainViewModel.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 18/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Firebase

protocol MainViewModelDelegate {
    func presentLogInView()
    func configureUIWithUser(_ user: User)
}

class MainViewModel {
    
    var delegate: MainViewModelDelegate?
    var user: User? {
        didSet {
            guard let user = user else { return }
            delegate?.configureUIWithUser(user)
        }
    }
    
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        if Auth.auth().currentUser == nil {
            print("User is not logged in...")
            DispatchQueue.main.async {
                self.delegate?.presentLogInView()
            }
        } else {
            completion(true)
        }
    }
    
    func logoutUser() {
        do {
            try Auth.auth().signOut()
            print("Sucess to log out...")
            delegate?.presentLogInView()
        } catch let error {
            print("Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() {
        UserService().fetchUser { user in
            self.user = user
        }
    }
}
