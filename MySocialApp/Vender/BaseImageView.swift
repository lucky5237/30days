//
//  BaseView.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/24.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation
import Kingfisher

class BaseImageView: UIImageView {
    lazy var subLayer:CALayer = {
        let border = CALayer()
        border.shadowColor = kHexColor(hex: "#BDB9A6")!.cgColor
        border.shadowOffset = CGSize(width: 2, height: 2)
        border.shadowOpacity = 1
        border.shadowRadius = 4
        
        return border
    }()
    
    var showShadow:Bool = false
    
    
    
    public init(imageName: String? = nil, imageUrl: String? = nil, showShadow:Bool = false, cornerRadius:CGFloat? = 0) {
        super.init(frame: .zero)
        self.showShadow = showShadow
        
        setup()
        
        if let imageName = imageName{
            self.image = UIImage.init(named: imageName)
        }else if let imageUrl = imageUrl{
            self.kf.setImage(with: URL(string:imageUrl))
        }
        
        if let cornerRadius = cornerRadius, cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        
        self.contentMode = .scaleAspectFill
        
        if self.showShadow{
            self.layer.addSublayer(subLayer)
        }
        
    }
}
