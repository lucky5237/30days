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
    
    var avatarImgView:UIImageView!
    var nameTextfield:TextField!
    var introTextfield:TextField!
    var loginBtn:BaseButton!
    var stepView:StepView!
    var scrollView:UIScrollView!
    var addIconImgView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initSubView() {
        
        
        
        scrollView = UIScrollView().then{
            $0.showsHorizontalScrollIndicator = false
            $0.contentSize = .init(width: kScreenWidth, height: kScreenHeight - kTopHeight - kBottomSafeHeight - 100)
        }
        
        avatarImgView = UIImageView().then{
            $0.backgroundColor = kHexColor(hex: "#DBDBDB")
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 50
            $0.isUserInteractionEnabled = true
            $0.contentMode = .scaleAspectFill
        }
        
        avatarImgView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addImage)))
        
        addIconImgView = UIImageView().then{
            $0.image = kImage("添加照片")
        }
        
        
        nameTextfield = TextField().then{
            $0.placeholder = "请输入您的昵称"
            $0.placeholderActiveColor = k999Color
            $0.dividerActiveColor = k222Color
            $0.font = kFontSize(16)
            $0.textColor = kMainTextColor
//            $0.placeholderActiveScale = 1
        }

        introTextfield = TextField().then{
            $0.placeholder = "请输入您的个性签名"
            $0.placeholderActiveColor = k999Color
            $0.dividerActiveColor = k222Color
            $0.font = kFontSize(16)
            $0.textColor = kMainTextColor
        }
        
        
        stepView = StepView(stepNum: 3, currentStep: 2)
        
        loginBtn = BaseButton(title: "下一步").then{
            $0.isEnabled = false

        }
    
        nameTextfield.rx.text.orEmpty.subscribe(onNext: { [self] text in
            if text.count > 15{
                self.nameTextfield.text = text[safe: 0..<15]
            }
            if self.nameTextfield.isFirstResponder{
                self.nameTextfield.placeholder = "请输入您的昵称 \(self.nameTextfield.text?.count ?? 0)/15"
            }else{
                self.nameTextfield.placeholder = "请输入您的昵称"
            }
            self.loginBtn.isEnabled = text.count > 0
        })
        
        
        introTextfield.rx.text.orEmpty.subscribe(onNext: { [self] text in
            if text.count > 20{
                self.introTextfield.text = text[safe: 0..<20]
            }
            if self.introTextfield.isFirstResponder{
                self.introTextfield.placeholder = "请输入您的个性签名 \(self.introTextfield.text?.count ?? 0)/20"
            }else{
                self.introTextfield.placeholder = "请输入您的个性签名"
            }
        })
        
        self.view.addSubview(scrollView)
        scrollView.addSubviews([avatarImgView,nameTextfield,introTextfield])
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
        
        nameTextfield.snp.makeConstraints{
            $0.top.equalTo(avatarImgView.snp_bottomMargin).offset(52)
            $0.left.equalTo(27)
            $0.width.equalTo(kScreenWidth - 54)
        }
        
        introTextfield.snp.makeConstraints{
            $0.top.equalTo(nameTextfield.snp_bottomMargin).offset(72)
            $0.left.equalTo(27)
            $0.width.equalTo(kScreenWidth - 54)
        }
        
        loginBtn.snp.makeConstraints {
            $0.bottom.equalTo(-(kBottomSafeHeight + 11))
            $0.height.equalTo(52)
            $0.width.equalTo(kScreenWidth - 54)
            $0.centerX.equalTo(self.view)
        }
        
        stepView.snp.makeConstraints {
            $0.bottom.equalTo(loginBtn.snp_topMargin).offset(-27)
            $0.height.equalTo(30)
            $0.width.equalTo(kScreenWidth - 54)
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
