//
//  BaseButton.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/15.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation

class BaseButton: UIButton {
    
    open var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    open var disabledTitle: String? {
        didSet {
            self.setTitle(disabledTitle, for: .disabled)
        }
    }
    
//    override var isEnabled: Bool{
//        didSet{
//            if self.isEnabled {
//                self.alpha = 1
//            } else {
//                self.alpha = 0.1
//            }
//        }
//    }
    
    public init(title: String?, disabledTitle:String? = nil) {
        super.init(frame: .zero)
        
        setup()
        
        guard let title = title else { return }
        
        self.setTitle(title, for: .normal)
        
        if nil == disabledTitle {
            self.setTitle(title, for: .disabled)
        }else{
            self.setTitle(disabledTitle, for: .disabled)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = 11
        self.layer.masksToBounds = true
        self.backgroundColor = kThemeColor
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.init(white: 1, alpha: 0.5), for: .disabled)
        self.titleLabel?.font = kMediumFontSize(14)
    }
    
    
}
