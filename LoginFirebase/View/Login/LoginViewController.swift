//
//  LoginViewController.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 13/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Stevia

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var imageViewTop: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var imageViewLeft: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var imageViewRight: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    private lazy var emailView = TextFieldView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: self.emailTextField, placeHolder: "Email")
    
    private lazy var passwordView = TextFieldView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: self.passwordTextField, placeHolder: "Password", secure: true)
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }


}

extension LoginViewController: ViewConfiguration {
    func buildView() {
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        view.sv(
            imageViewTop,
            imageViewRight,
            stackView,
            imageViewLeft
        )
    }
    
    func addConstraint() {
        view.layout(
            imageViewRight.right(0).height(20%).width(30%),
            "",
            imageViewTop.centerHorizontally().size(200),
            40,
            stackView.height(15%).width(<=300).centerInContainer(),
            "",
            imageViewLeft.bottom(0).height(20%).width(30%)
        )
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .white
        imageViewTop.image = UIImage(named: "blue")
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        imageViewRight.image = UIImage(named: "gray")
        imageViewLeft.image = UIImage(named: "red")
    }
    
    
}
