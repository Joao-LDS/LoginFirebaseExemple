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
    private let dontHaveAnAccountButton = UIButton()
    private let signInButton = CustomButtom(title: "Sign In")
    private let presentAlert = CustomButtom(title: "Present alert")
    private let alert = Alert(title: "Sucess", message: "oiuhsfgiusdhfuhgddushgiudshgiuofdhgushfduhgisdiudfhsuhghdghiusdhiughiugfshiugshuigdu")

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        alert.delegate = self
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        alert.showAlert()
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
    
    @objc func handleShowAlert() {
        view.sv(alert)
        alert.width(70%).height(20%).centerInContainer()
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    func presentMainView() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension LoginViewController: AlertDelegate {
    func dismissAlert() {
        alert.removeFromSuperview()
    }
}

extension LoginViewController: ViewConfiguration {
    func buildView() {
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(presentAlert)
        view.sv(
            imageView,
            stackView,
            dontHaveAnAccountButton
        )
    }
    
    func addConstraint() {
        view.layout(
            imageView.fillContainer(),
            "",
            |-26-stackView.width(<=300).centerInContainer()-26-|,
            "",
            dontHaveAnAccountButton.height(50).bottom(8%).centerHorizontally()
        )
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        presentAlert.addTarget(self, action: #selector(handleShowAlert), for: .touchUpInside)
        imageView.image = #imageLiteral(resourceName: "photo-of-abstract-painting-2693200")
        imageView.contentMode = .scaleAspectFill
        dontHaveAnAccountButton.setTitle("Don't have an account? Sign In", for: .normal)
        dontHaveAnAccountButton.addTarget(self, action: #selector(handleDontHaveAnAccountButton), for: .touchUpInside)
    }
    
    
}
