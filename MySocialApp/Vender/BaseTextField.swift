//
//  BaseTextField.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/22.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation

class BaseTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    lazy var bottomBorder: CALayer = {
        let border = CALayer()
        border.backgroundColor = kBackgroundColor.cgColor
        border.borderWidth = 2;
        border.cornerRadius = 16
        border.masksToBounds = true
        return border
    }()
    
    public init(placeholder: String? = nil, text:String? = nil) {
        super.init(frame: .zero)
        
        setup()
        
        if let placeholder = placeholder {
            self.attributedPlaceholder = .init(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: kSubTextColor,NSAttributedString.Key.font : kFontSize(16)])
        }
        
        if let text = text {
            self.text = text
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomBorder.borderColor = isFirstResponder ? kThemeColor.cgColor : kHexColor(hex: "#E2DCD1")!.cgColor
        bottomBorder.borderWidth = isFirstResponder ? 1 : 2
        bottomBorder.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
    
        self.layer.shadowColor = kHexColor(hex: "#BDB9A6")!.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        
        self.textColor = kMainTextColor;
        self.font = kMediumFontSize(20)
        self.tintColor = kThemeColor
        self.layer.addSublayer(bottomBorder)
        
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
