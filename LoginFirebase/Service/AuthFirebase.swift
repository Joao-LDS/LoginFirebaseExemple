//
//  AuthService.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 14/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import Firebase

class AuthFirebase {

    // MARK: - Firebase Sign In
    
    func logUserIn(withEmail email:String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(_ email: String,_ password: String,_ fullname: String,_ username: String,_ image: UIImage, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { meta, error in
            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        completion(error, nil)
                        return
                    }
                    guard let uid = result?.user.uid else { return }
                    let values = ["email": email, "fullname": fullname, "username": username, "profileImageUrl": profileImageUrl]
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    self.sendEmailVerification()
                }
            }
        }
    }
    
    func sendEmailVerification() {
        guard let user = Auth.auth().currentUser else { return }
        user.sendEmailVerification { error in
            if let _ = error {
                return
            }
        }
    }
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: "joao_l_d_s@hotmail.com") { error in
            print("Email enviado")
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
