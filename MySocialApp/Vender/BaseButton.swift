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
    
    override var isEnabled: Bool{
        didSet{
            if self.isEnabled {
                self.alpha = 1
            } else {
                self.alpha = 0.5
            }
        }
    }
    
    public init(title: String?, disabledTitle:String? = nil) {
        super.init(frame: .init(x: 0, y: 0, width: kScreenWidth - 48, height: 58))
        
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
        
        self.setTitleColor(kNormalButtonTitleColor, for: .normal)
        self.titleLabel?.font = kMediumFontSize(16)
        // shadowCode
        self.layer.shadowColor = kHexColor(hex: "#A6ABBD")!.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        
        
        let bgLayer = CAGradientLayer()
        bgLayer.masksToBounds = true
        bgLayer.cornerRadius = 28
        bgLayer.colors = [kHexColor(hex: "#FF2D00")!.cgColor, kHexColor(hex: "#FF5000")!.cgColor]
        bgLayer.locations = [0, 1]
        bgLayer.frame = self.bounds
        bgLayer.startPoint = CGPoint(x: 0, y: 0)
        bgLayer.endPoint = CGPoint(x: 1, y: 1)
        self.layer.insertSublayer(bgLayer, at: 0)
        
       
        
    }
    
    
}
