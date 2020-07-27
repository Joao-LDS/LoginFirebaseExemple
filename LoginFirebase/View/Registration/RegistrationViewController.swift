//
//  RegistrationViewController.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 13/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Stevia
import Firebase

class RegistrationViewController: UIViewController {
    
    private var viewModel = RegistrationViewModel()
    private let imageView = UIImageView()
    private let imagePicker = UIImagePickerController()
    private let addPhotoButton = UIButton()
    private var profileImage: UIImage?
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let fullnameTextField = UITextField()
    private let usernameTextField = UITextField()
    private let stackView = UIStackView()
    private lazy var emailView = TextFieldView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: self.emailTextField, placeHolder: "Email")
    private lazy var passwordView = TextFieldView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: self.passwordTextField, placeHolder: "Password", secure: true)
    private lazy var fullnameView = TextFieldView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: self.fullnameTextField, placeHolder: "Full Name")
    private lazy var usernameView = TextFieldView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: self.usernameTextField, placeHolder: "Username")
    private let buttonSignUp: UIButton = CustomButtom(title: "Sign Up")
    private let alreadyHaveAnAccountButton = UIButton()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        viewModel.delegate = self
        setupView()
    }
    
    // MARK: - Functions
    
    @objc func handleAddPhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleSignUp() {
        guard let profileImage = profileImage else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        viewModel.registerUser(email, password, fullname, username, profileImage)
    }
    
    @objc func handleHaveAnAccount() {
        dismiss(animated: true, completion: nil)
    }
    
    func setImageButtonFromPicker(_ image: UIImage) {
        addPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhotoButton.layer.cornerRadius = 18
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        addPhotoButton.layer.borderWidth = 2
    }

}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImage = image
        setImageButtonFromPicker(image)
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationViewController: RegistrationViewModelDelegate {
    func presentAlert() {
        let alert = UIAlertController(title: "Yeeep", message: "Verify you email please =)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension RegistrationViewController: ViewConfiguration {
    func buildView() {
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(fullnameView)
        stackView.addArrangedSubview(usernameView)
        stackView.addArrangedSubview(buttonSignUp)
        view.sv(
            imageView,
            addPhotoButton,
            stackView,
            alreadyHaveAnAccountButton
        )
    }
    
    func addConstraint() {
        view.layout(
            imageView.fillContainer(),
            "",
            addPhotoButton.centerHorizontally().size(150),
            40,
            |-26-stackView.width(<=300).centerInContainer()-26-|,
            30,
            buttonSignUp.centerHorizontally(),
            "",
            alreadyHaveAnAccountButton.bottom(8%).centerHorizontally()
        )
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .white
        imageView.image = #imageLiteral(resourceName: "photo-of-abstract-painting-2693200")
        imageView.contentMode = .scaleAspectFill
        addPhotoButton.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        addPhotoButton.setImage(UIImage(named: "plus_photo"), for: .normal)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        buttonSignUp.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        alreadyHaveAnAccountButton.setTitle("Already have an account? Log In", for: .normal)
        alreadyHaveAnAccountButton.addTarget(self, action: #selector(handleHaveAnAccount), for: .touchUpInside)
    }
    
    
}
