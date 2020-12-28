//
//  BaseIconButton.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/28.
//  Copyright © 2020 lujian. All rights reserved.
//

import UIKit

class BaseIconButton: UIButton {
    
    var bgColor:UIColor!
    var iconName:String!
    
    lazy var subLayer: CALayer = {
        let layer = CALayer()
        layer.masksToBounds = true
        return layer
    }()
    
    public init(bgColor:UIColor = .white,iconName:String){
        super.init(frame: .zero)
        self.iconName = iconName
        self.bgColor = bgColor
        setup()
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
        subLayer.frame = self.bounds
        subLayer.cornerRadius = 24
    }
    
    func setup() {
       
        // shadowCode
        self.layer.shadowColor = kHexColor(hex: "#BDB9A6")!.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        
        subLayer.backgroundColor = bgColor.cgColor
        self.layer.insertSublayer(subLayer, at: 0)
        
        self.setImage(kImage(iconName), for: .normal)
        
    }
    

}
