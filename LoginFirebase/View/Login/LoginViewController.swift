//
//  LoginViewController.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 13/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Stevia
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = LoginViewModel()
    private let imageView = UIImageView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let stackView = UIStackView()
    private lazy var emailView = TextFieldView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: self.emailTextField, placeHolder: "Email")
    private lazy var passwordView = TextFieldView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: self.passwordTextField, placeHolder: "Password", secure: true)
    private let forgotPassword = UIButton()
    private let dontHaveAnAccountButton = UIButton()
    private let signInButton = CustomButtom(title: "Sign In")
    private let alert = Alert()
    

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupView()
    }
    
    // MARK: - Functions
    
    @objc func handleDontHaveAnAccountButton() {
        let vc = RegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func handleSignIn() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        viewModel.logUserIn(withEmail: email, password: password)
    }
    
    @objc func handleForgotPassword() {
        viewModel.resetPassword()
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    func presentMainView() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        alert.labelTitle.text = title
        alert.labelMessage.text = message
        alert.configureShowAlert(view: self.view)
    }
}

extension LoginViewController: ViewConfiguration {
    func buildView() {
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(signInButton)
        view.sv(
            imageView,
            stackView,
            forgotPassword,
            dontHaveAnAccountButton
        )
    }
    
    func addConstraint() {
        view.layout(
            imageView.fillContainer(),
            "",
            |-26-stackView.width(<=300).centerInContainer()-26-|,
            "",
            forgotPassword.centerHorizontally(),
            12,
            dontHaveAnAccountButton.height(50).bottom(8%).centerHorizontally()
        )
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        imageView.image = #imageLiteral(resourceName: "photo-of-abstract-painting-2693200")
        imageView.contentMode = .scaleAspectFill
        forgotPassword.setTitle("Forgot password?", for: .normal)
        forgotPassword.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        dontHaveAnAccountButton.setTitle("Don't have an account? Sign In", for: .normal)
        dontHaveAnAccountButton.addTarget(self, action: #selector(handleDontHaveAnAccountButton), for: .touchUpInside)
        
    }
    
    
}
