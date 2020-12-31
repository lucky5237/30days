//
//  BaseAlertView.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/24.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation
import SwiftEntryKit
import OverlayController

class BaseAlertView: UIView {
    
    var title:String?
    var content:String!
    var cancelBtnTitle:String?
    var confirmBtnTitle:String!
    var confirmClickBlock:((_ sender: UIButton) -> ())?
    var cancelClickBlock:((_ sender: UIButton) -> ())?
    

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
    
    lazy var confirmBtn:UIButton = {
        let button = UIButton()
        button.backgroundColor = kThemeColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = kFontSize(14)
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var cancelBtn:UIButton = {
        let button = UIButton()
        button.backgroundColor = kHexColor(hex: "#EDEDED")!
        button.setTitleColor(kMainTextColor, for: .normal)
        button.titleLabel?.font = kFontSize(14)
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        return button
    }()
    
    var popVC:OverlayController!
    
    
    public init(title:String? = nil, content:String!, confirmTitle:String! = "确定",confirmClickBlock:((_ sender: UIButton) -> ())? = nil, cancelTitle:String = "取消",cancelClickBlock:((_ sender: UIButton) -> ())? = nil) {
        super.init(frame: .zero)
        
        self.title = title
        self.content = content
        self.confirmBtnTitle = confirmTitle
        self.cancelBtnTitle = cancelTitle
        self.confirmClickBlock = confirmClickBlock
        self.cancelClickBlock = cancelClickBlock
        setup()
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
        
        var titleHeight:CGFloat = 0
        
        if let title = self.title,title.count > 0{
            self.addSubview(self.titleLabel)
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(24)
                $0.left.equalTo(24)
                $0.right.equalTo(-24)
                $0.height.equalTo(25)
            }
            self.titleLabel.text = title
            
            self.addSubview(self.contentLabel)
            contentLabel.snp.makeConstraints{
                $0.top.equalTo(titleLabel.snp_bottomMargin).offset(20)
                $0.left.equalTo(24)
                $0.right.equalTo(-24)
            }
            
            titleHeight = 49
            
        }else{
            self.addSubview(self.contentLabel)
            contentLabel.snp.makeConstraints{
                $0.top.equalTo(24)
                $0.left.equalTo(24)
                $0.right.equalTo(-24)
            }
            titleHeight = 24
        }
        
        
        
        if let cancelBtnTitle = self.cancelBtnTitle,cancelBtnTitle.count > 0 {
            
            self.addSubview(self.cancelBtn)
            self.addSubview(self.confirmBtn)
            
            cancelBtn.snp.makeConstraints{
                $0.left.equalTo(24);
                $0.height.equalTo(36)
                $0.width.equalTo((kScreenWidth - 132) / 2)
                $0.top.equalTo(contentLabel.snp.bottom).offset(30)
            }
            
            confirmBtn.snp.makeConstraints{
                $0.right.equalTo(-24);
                $0.height.equalTo(36)
                $0.width.equalTo((kScreenWidth - 132) / 2)
                $0.top.equalTo(contentLabel.snp.bottom).offset(30)
            }
            
            self.cancelBtn.setTitle(cancelBtnTitle, for: .normal)
        
        }else{
            self.addSubview(self.confirmBtn)
            confirmBtn.snp.makeConstraints{
                $0.right.equalTo(-24);
                $0.height.equalTo(36)
                $0.left.equalTo(24)
                $0.top.equalTo(contentLabel.snp.bottom).offset(30)
            }
        }
        
        self.confirmBtn.setTitle(confirmBtnTitle, for: .normal)
        self.contentLabel.text = content
        
        self.confirmBtn.addClickCallback { sender in
            if let confirmClickBlock =  self.confirmClickBlock{
                confirmClickBlock(sender)
            }
            self.dismiss()
        }
        
        self.cancelBtn.addClickCallback { sender in
            if let cancelClickBlock =  self.cancelClickBlock{
                cancelClickBlock(sender)
            }
            self.dismiss()
        }
        
        
        let contentHeight = self.content.height(withConstrainedWidth: kScreenWidth - 124, font: kFontSize(14))
        
        self.frame = .init(origin: .zero, size: .init(width: kScreenWidth - 76, height: titleHeight + contentHeight + 90))
    }
    
    
    class func show(title:String = "", content:String!, confirmTitle:String! = "确定",confirmClickBlock:((_ sender: UIButton) -> ())!, cancelTitle:String = "取消",cancelClickBlock:((_ sender: UIButton) -> ())? = nil){
        
        let alertView = BaseAlertView.init(title: title, content:content, confirmTitle: confirmTitle, confirmClickBlock: confirmClickBlock, cancelTitle: cancelTitle, cancelClickBlock: cancelClickBlock)
        
        alertView.present()

    }
    
    private func present()  {
        if popVC == nil || !popVC.isPresenting {
            popVC = OverlayController(view: self)
            popVC.layoutPosition = .center
            popVC.presentationStyle = .fade
            popVC.present()
        }
        
    }
    
    
    private func dismiss() {
        if popVC.isPresenting {
            popVC.dissmiss()
        }
    }
    
    
    
    
}
