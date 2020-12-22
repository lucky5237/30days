//
//  BaseTextField.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/22.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation

class BaseTextField: UITextField {
    
    lazy var bottomBorder: CALayer = {
        let border = CALayer();
//        border.borderColor = kHexColor(hex: "#CED0D6")!.cgColor;
        border.borderWidth = 2;
        border.shadowColor = kHexColor(hex: "#FAFBFF")!.cgColor
        border.shadowOffset = CGSize(width: -2, height: -2)
        border.shadowOpacity = 1
        border.shadowRadius = 8
        
        border.cornerRadius = 16
        border.masksToBounds = true
        return border
    }()
    
    public init(placeholder: String? = nil, text:String? = nil) {
        super.init(frame: .init(x: 0, y: 0, width: kScreenWidth - 48, height: 64))
        
        setup()
        
        if let placeholder = placeholder {
            self.attributedPlaceholder = .init(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: kHexColor(hex: "#626260")!,NSAttributedString.Key.font : kMediumFontSize(16)])
        }
        
        if let text = text {
            self.text = text
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        bottomBorder.borderColor = isFirstResponder ? kThemeColor.cgColor : kHexColor(hex: "#CED0D6")!.cgColor;
        bottomBorder.borderWidth = isFirstResponder ? 1 : 2
        bottomBorder.frame = self.bounds
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.textColor = kHexColor(hex: "#292925")!
        self.font = kMediumFontSize(16)
        self.tintColor = kThemeColor
        self.layer.addSublayer(bottomBorder)
        
    }
}
