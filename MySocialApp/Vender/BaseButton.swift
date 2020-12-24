//
//  BaseButton.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/15.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation

class BaseButton: UIButton {
    
    lazy var bgLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.masksToBounds = true
        layer.colors = [kHexColor(hex: "#FF2D00")!.cgColor, kHexColor(hex: "#FF5000")!.cgColor]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0, y:-0.1)
        layer.endPoint = CGPoint(x: 1, y: 1)
        return layer
    }()
    
    
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgLayer.cornerRadius = self.bounds.size.height / 2
        bgLayer.frame = self.bounds
    }
    
    
    func setup() {
        self.setTitleColor(kNormalButtonTitleColor, for: .normal)
        self.titleLabel?.font = kBoldFontSize(18)
        // shadowCode
        self.layer.shadowColor = kHexColor(hex: "#BDB9A6")!.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        
        self.layer.insertSublayer(bgLayer, at: 0)
        
    }
    
    
}
