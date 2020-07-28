//
//  Alert.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 21/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Stevia

class Alert: UIView {
    
    let labelTitle = UILabel()
    let labelMessage = UILabel()
    private let line = UIView()
    private let button = UIButton(type: .system)
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureShowAlert(view: UIView) {
        view.sv(self)
        width(70%).height(20%).centerInContainer()
        Animation().animationToPresent(view: self)
    }
    
    @objc func dismiss() {
        Animation().animationToDismiss(view: self)
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
            16,
            |-labelMessage-|,
            "",
            |-line.height(1)-|,
            |-button.height(50)-|,
            0
        )
    }
    
    func additionalConfiguration() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8033945863)
        layer.cornerRadius = 10
        labelTitle.textColor = .white
        labelTitle.font = UIFont.boldSystemFont(ofSize: 18)
        labelMessage.numberOfLines = 0
        labelMessage.textAlignment = .center
        labelMessage.textColor = .white
        line.backgroundColor = .white
        button.setTitle("OK", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
    
    
}
