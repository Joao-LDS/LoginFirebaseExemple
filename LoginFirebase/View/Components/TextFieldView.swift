//
//  TextFieldView.swift
//  LoginFirebase
//
//  Created by João Luis Santos on 13/07/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import Stevia

class TextFieldView: UIView {
    
    // MARK: - Properties
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var imageIcon: UIImage = {
        let image = UIImage()
        return image
    }()
    
    private lazy var imageBackGroundView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var imageBackGround: UIImage = {
        let image = UIImage()
        return image
    }()
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    private var placeHolder = ""
    
    private var secure = false
    
    // MARK: - Init
    
    init(image: UIImage, textField: UITextField, placeHolder: String, secure: Bool = false) {
        super.init(frame: .zero)
        self.imageIcon = image
        self.textField = textField
        self.placeHolder = placeHolder
        self.secure = secure
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TextFieldView: ViewConfiguration {
    func buildView() {
        sv(
            imageBackGroundView,
            iconView,
            textField
        )
    }
    
    func addConstraint() {
        imageBackGroundView.fillContainer()
        layout(
            iconView.left(22).centerVertically().size(24)-8-textField-12-|
        )
        
        
    }
    
    func additionalConfiguration() {
        imageBackGround = #imageLiteral(resourceName: "brush_green")
        
        imageBackGroundView.image = imageBackGround
        
        layer.cornerRadius = 30.0
        
        iconView.image = imageIcon
        
        textField.placeholder = placeHolder
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.isSecureTextEntry = secure
    }
    
    
}
