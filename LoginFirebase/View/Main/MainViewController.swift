//
//  MainViewController.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 18/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Stevia
import SDWebImage

class MainViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let stack = UIStackView()
    private let fullnameLabel = UILabel()
    private let emailLabel = UILabel()
    private let usernameLabel = UILabel()
    private let button = CustomButtom(title: "Log out")
    private let viewModel = MainViewModel()
    private let spinner = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.configureActivity(on: true)
        viewModel.authenticateUser { sucess in
            if sucess {
                self.viewModel.fetchUser()
                self.setupView()
            }
        }
    }
    
    @objc func handleButton() {
        viewModel.logoutUser()
    }
    
    func configureActivity(on: Bool) {
        if on {
            spinner.startAnimating()
            view.sv(spinner)
            spinner.centerInContainer()
        } else {
            spinner.stopAnimating()
            spinner.removeFromSuperview()
        }
    }
    
}

extension MainViewController: MainViewModelDelegate {
    func configureUIWithUser(_ user: User) {
        self.configureActivity(on: false)
        fullnameLabel.text = "Full name: \(user.fullname)"
        emailLabel.text = "Email: \(user.email)"
        usernameLabel.text = "Username: \(user.username)"
        imageView.sd_setImage(with: URL(string:user.profileImageUrl), completed: nil)
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        imageView.layer.borderWidth = 2
    }
    
    func presentLogInView() {
        dismiss(animated: true) {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension MainViewController: ViewConfiguration {
    func buildView() {
        stack.addArrangedSubview(fullnameLabel)
        stack.addArrangedSubview(emailLabel)
        stack.addArrangedSubview(usernameLabel)
        view.sv(
            imageView,
            stack,
            button
        )
    }
    
    func addConstraint() {
        view.layout(
            imageView.centerHorizontally().top(15%).size(150),
            "",
            stack.centerInContainer(),
            "",
            button.centerHorizontally().bottom(5%).width(85%)
        )
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .white
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 10
        fullnameLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        emailLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        usernameLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        spinner.style = .gray
    }
    
}
