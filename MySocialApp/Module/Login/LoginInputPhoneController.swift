//
//  LoginInputPhoneController.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/2.
//  Copyright © 2020 lujian. All rights reserved.
//

import UIKit
import Hero

class LoginInputPhoneController: UIViewController {
    
    var hintLabel:UILabel!
    var phoneTf:BaseTextField!
    var loginBtn:BaseButton!
    var stepView:StepView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initSubView()
        initData()
        
    }

    
    func initData() {
        phoneTf.text = "15757115237"
    }
    
    func initSubView() {
        
        
        let titleLabel = UILabel().then{
            $0.textColor = kMainTextColor
            $0.font = kBoldFontSize(26)
            $0.numberOfLines = 0
            $0.text = "登录/注册"
        }
        
        
        hintLabel = UILabel().then{
            $0.textColor = kSubTextColor
            $0.font = kFontSize(14)
            $0.numberOfLines = 0
            $0.text = "如未注册，将自动进入注册流程"
        }
        
        
        let areaNumView = UIView(frame: .init(x: 0, y: 0, width: 80, height: 50))
        
        let areaNumLabel = UILabel(text: "+86").then{
            $0.textColor = kMainTextColor
            $0.font = kMediumFontSize(20)
            $0.frame = .init(x: 20, y: 0, width: 40, height: 64)
        }
        
        areaNumView.addSubview(areaNumLabel);
        
        
        phoneTf = BaseTextField(placeholder: "请输入手机号").then{
            $0.keyboardType = .numberPad
            $0.leftView = areaNumView
            $0.leftViewMode = .always
        }
        
        phoneTf.addSubview(areaNumLabel)
        
        
        stepView = StepView(stepNum: 2)
        stepView.heroID = "step"
        
        loginBtn = BaseButton(title: "获取验证码").then{
            $0.addClickCallback({[weak self] button in
                self?.login()
            })
            $0.heroID = "button"
            $0.isEnabled = false
        }
        
        let phoneValid = phoneTf.rx.text.orEmpty
        
        
        phoneValid.subscribe(onNext: { text in
            if text.count > 11{
                self.phoneTf.text = text[safe: 0..<11]
            }
            
            self.loginBtn.isEnabled = self.phoneTf.text?.count == 11
        })
        
        self.view.addSubviews([titleLabel,hintLabel,phoneTf,stepView,loginBtn])
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(kStatusBarHeight + 90)
            $0.left.equalTo(24)
            $0.right.equalTo(-24)
        }
        
        hintLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp_bottomMargin).offset(16)
            $0.left.equalTo(24)
            $0.right.equalTo(-24)
        }
        
        phoneTf.snp.makeConstraints {
            $0.top.equalTo(hintLabel.snp_bottomMargin).offset(48)
            $0.left.equalTo(24)
            $0.right.equalTo(-24)
            $0.height.equalTo(64)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func login(){
        
        guard let phone = phoneTf.text else {
            return
        }
    
        
        if phone.count != 11{
            showInfoText("请输入正确的手机号")
        }
        
        goToCheckSMSCodeVC()

    }
    
    func goToCheckSMSCodeVC(){
        let vc = LoginSMSCodeController()
        vc.phone = phoneTf.text
        self.navigationController?.pushViewController(vc)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.phoneTf.resignFirstResponder()
    }

}
