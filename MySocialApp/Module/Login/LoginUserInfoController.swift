//
//  LoginUserInfoController.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/19.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation
import Material
class LoginUserInfoController: BaseViewController {
    
    var avatarImgView:BaseImageView!
    var nameTextfield:BaseTextField!
    var introTextfield:BaseTextField!
    var loginBtn:BaseButton!
    var stepView:StepView!
    var scrollView:UIScrollView!
    var addIconImgView:UIImageView!
    var hintLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initSubView() {
        
        scrollView = UIScrollView().then{
            $0.showsHorizontalScrollIndicator = false
            $0.contentSize = .init(width: kScreenWidth, height: kScreenHeight - kTopHeight - kBottomSafeHeight - 100)
        }
        
        avatarImgView = BaseImageView(showShadow: true, cornerRadius: 50).then{
            $0.backgroundColor = .white
        }
        
        hintLabel = UILabel().then{
            $0.textColor = kSubTextColor
            $0.font = kFontSize(14)
            $0.numberOfLines = 0
            $0.text = "上传头像，让更多的人认识你"
        }
        
        avatarImgView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addImage)))
        
        addIconImgView = UIImageView().then{
            $0.image = kImage("添加照片")
        }
        
        
        nameTextfield = BaseTextField(placeholder: "给自己取一个昵称")

        introTextfield = BaseTextField(placeholder:"一句话介绍自己")
        
        
        stepView = StepView(stepNum: 3, currentStep: 2)
        
        loginBtn = BaseButton(title: "完成注册").then{
            $0.isEnabled = false

        }
    
        nameTextfield.rx.text.orEmpty.subscribe(onNext: { [self] text in
            if text.count > 15{
                self.nameTextfield.text = text[safe: 0..<15]
            }
            self.loginBtn.isEnabled = text.count > 0
        })
        
        
        introTextfield.rx.text.orEmpty.subscribe(onNext: { [self] text in
            if text.count > 20{
                self.introTextfield.text = text[safe: 0..<20]
            }
        })
        
        self.view.addSubview(scrollView)
        scrollView.addSubviews([avatarImgView,hintLabel,nameTextfield,introTextfield])
        avatarImgView.addSubview(addIconImgView)
        self.view.addSubviews([stepView,loginBtn])
        
        
        
        scrollView.snp.makeConstraints{
            $0.top.equalTo(kTopHeight)
            $0.left.equalTo(0)
            $0.right.equalTo(-0)
            $0.bottom.equalTo(-(kBottomSafeHeight + 100))
        }
        
        avatarImgView.snp.makeConstraints{
            $0.top.equalTo(20)
            $0.width.height.equalTo(100)
            $0.centerX.equalTo(scrollView)
        }
        
        hintLabel.snp.makeConstraints{
            $0.top.equalTo(avatarImgView.snp_bottomMargin).offset(20)
            $0.centerX.equalTo(scrollView)
        }
        
        nameTextfield.snp.makeConstraints{
            $0.top.equalTo(hintLabel.snp_bottomMargin).offset(48)
            $0.left.equalTo(24)
            $0.height.equalTo(56)
            $0.width.equalTo(kScreenWidth - 48)
        }
        
        introTextfield.snp.makeConstraints{
            $0.top.equalTo(nameTextfield.snp_bottomMargin).offset(32)
            $0.left.equalTo(24)
            $0.height.equalTo(56)
            $0.width.equalTo(kScreenWidth - 48)
        }
        
        loginBtn.snp.makeConstraints {
            $0.bottom.equalTo(-(kBottomSafeHeight + 16))
            $0.height.equalTo(56)
            $0.width.equalTo(kScreenWidth - 48)
            $0.centerX.equalTo(self.view)
        }
        
        stepView.snp.makeConstraints {
            $0.bottom.equalTo(loginBtn.snp_topMargin).offset(-27)
            $0.height.equalTo(30)
            $0.width.equalTo(kScreenWidth - 48)
            $0.centerX.equalTo(self.view)
        }
        
        addIconImgView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.height.equalTo(36)
        }
        
    }
    
    
    
    @objc func addImage(){
        self.launchPhotoPicker { (items, cancelled) in
            if !cancelled && items.count > 0{
                if let photo = items.singlePhoto {
                    self.avatarImgView.image = photo.image
                    self.addIconImgView.isHidden = true
                }
            }
        }
    }
}
