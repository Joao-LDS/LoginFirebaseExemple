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
    private let viewBottom = UIView()
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
    
    // MARK: - Selectors
    
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
        let alert = Alert()
        alert.configureShowAlertWithTextField(view: self.view, title: "Forgot password?", message: "Enter your account email:")
    }
    
}

// MARK: - LoginViewModelDelegate

extension LoginViewController: LoginViewModelDelegate {
    func presentMainView() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        alert.configureShowAlert(view: self.view, title: title, message: message)
    }
}

// MARK: - ViewConfiguration

extension LoginViewController: ViewConfiguration {
    func buildView() {
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(signInButton)
        view.sv(
            viewBottom,
            stackView,
            forgotPassword,
            dontHaveAnAccountButton
        )
    }
    
    func addConstraint() {
        view.layout(
            viewBottom.bottom(-20).right(0).left(0).height(25%),
            "",
            |-26-stackView.width(<=300).centerInContainer()-26-|,
            "",
            forgotPassword.centerHorizontally().height(40),
            12,
            dontHaveAnAccountButton.height(40),
            alignCenter(dontHaveAnAccountButton, with: viewBottom)
        )
    }
    
    func additionalConfiguration() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        viewBottom.backgroundColor = #colorLiteral(red: 0.6078431373, green: 0.3647058824, blue: 0.8980392157, alpha: 1)
        viewBottom.layer.cornerRadius = 20
        viewBottom.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        viewBottom.layer.shadowRadius = 8.0
        viewBottom.layer.shadowOpacity = 0.7
        viewBottom.layer.shadowOffset = .zero
        emailTextField.keyboardType = .emailAddress
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        forgotPassword.setTitle("Forgot password?", for: .normal)
        forgotPassword.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        dontHaveAnAccountButton.setTitle("Don't have an account? Sign In", for: .normal)
        dontHaveAnAccountButton.addTarget(self, action: #selector(handleDontHaveAnAccountButton), for: .touchUpInside)
        
    }
    
    
}
