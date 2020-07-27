//
//  Alert.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 21/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Stevia

protocol AlertDelegate {
    func dismissAlert()
}

class Alert: UIView {
    
    var delegate: AlertDelegate?
    private let labelTitle = UILabel()
    private let labelMessage = UILabel()
    private let line = UIView()
    private let button = UIButton(type: .system)
    private var title = ""
    private var message = ""
    
    init(title: String, message: String) {
        super.init(frame: .zero)
        self.title = title
        self.message = message
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismiss() {
        delegate?.dismissAlert()
    }
    
}

extension Alert: ViewConfiguration {
    func buildView() {
        sv(
            labelTitle,
            labelMessage,
            line,
            button
        )
    }
    
    func addConstraint() {
        layout(
            16,
            labelTitle.centerHorizontally(),
            "",
            |-labelMessage-|,
            12,
            |-line.height(1)-|,
            |-button.height(50)-|,
            0
        )
    }
    
    func additionalConfiguration() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8033945863)
        layer.cornerRadius = 10
        labelTitle.text = title
        labelTitle.textColor = .white
        labelTitle.font = UIFont.boldSystemFont(ofSize: 18)
        labelMessage.text = message
        labelMessage.numberOfLines = 0
        labelMessage.textAlignment = .center
        labelMessage.textColor = .white
        line.backgroundColor = .white
        button.setTitle("OK", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
    
    
}
