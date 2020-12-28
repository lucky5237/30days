//
//  BaseAlertView.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/24.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation

class BaseAlertView: UIView {
    
    lazy var subLayer: CALayer = {
        let border = CALayer()
        border.cornerRadius = 16
        border.masksToBounds = true
        return border
    }()
    
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.textColor = kMainTextColor
        title.font = kMediumFontSize(18)
        return title
    }()
    
    
    lazy var contentLabel:UILabel = {
        let content = UILabel()
        content.textColor = kSubTextColor
        content.numberOfLines = 0
        content.font = kFontSize(14)
        return content
    }()
    
    lazy var confirmBtn:BaseButton = {
        let button = BaseButton()
        return button
    }()
    
    lazy var cancelBtn:BaseButton = {
        let button = BaseButton()
        button.backgroundColor = kHexColor(hex: "#EDEDED")!
        button.setTitleColor(kMainTextColor, for: .normal)
        return button
    }()
    
    
    public init(title:String? = "提示", content:String, confirmTitle:String? = "确定", cancelTitle:String? = "取消") {
        super.init(frame: .zero)
        
        setup()
        
        self.titleLabel.text = title
        self.contentLabel.text = content
        self.confirmBtn.setTitle(confirmTitle, for: .normal)
        self.cancelBtn.setTitle(cancelTitle, for: .normal)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    func setup() {
        self.backgroundColor = .white
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.contentLabel)
        self.addSubview(self.cancelBtn)
        self.addSubview(self.confirmBtn)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview();
        }
        
        
        contentLabel.snp.makeConstraints{
            $0.top.equalToSuperview();
        }
        
        cancelBtn.snp.makeConstraints{
            $0.top.equalToSuperview();
        }
        
        confirmBtn.snp.makeConstraints{
            $0.top.equalToSuperview();
        }
        
        
        // shadowCode
        self.layer.shadowColor = kHexColor(hex: "#A6ABBD")!.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        
        self.layer.addSublayer(subLayer)
        
    }
}
