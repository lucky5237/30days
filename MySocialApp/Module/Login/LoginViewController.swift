//
//  LoginViewController.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/24.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Material


class LoginViewController: BaseViewController {
    
    var phoneTf:TextField!
    var passwordTf:TextField!
    var loginBtn:RaisedButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initData() {
        phoneTf.text = "15757115238"
        passwordTf.text = "123456"
    }
    
    override func initSubView() {
        phoneTf = TextField().then{
            $0.keyboardType = .numberPad
            $0.placeholder = "手机号"
            $0.placeholderActiveColor = .purple
        }
        
        passwordTf = TextField().then{
            $0.isSecureTextEntry = true
            $0.placeholder = "验证码"
        }
        
        loginBtn = RaisedButton(title: "登录").then{
            $0.addClickCallback({[weak self] button in
                self?.login()
            })
        }
        
        let phoneValid = phoneTf.rx.text.orEmpty
        
        let pwdValid = passwordTf.rx.text.orEmpty
        
        phoneValid.subscribe(onNext: { text in
            if text.count > 11{
                self.phoneTf.text = text[safe: 0..<11]
            }
        })
        
        self.view.addSubviews([phoneTf,passwordTf,loginBtn])
        
        phoneTf.snp.makeConstraints {
            $0.top.equalTo(kStatusBarHeight + 20)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.height.equalTo(44)
        }
        
        passwordTf.snp.makeConstraints {
            $0.top.equalTo(phoneTf.snp.bottom).offset(20)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
//            $0.height.equalTo(44)
        }
        
        loginBtn.snp.makeConstraints {
            $0.top.equalTo(passwordTf.snp.bottom).offset(20)
            $0.height.equalTo(44)
            $0.width.equalTo(100)
            $0.centerX.equalTo(self.view)
        }
        
    }
    
    func login(){
        
        guard let phone = phoneTf.text else {
            return
        }
        
        guard let password = passwordTf.text else {
            return
        }
        
        if phone.count != 11{
            showInfoText("请输入正确的手机号")
        }
        
//        request(.login(phone: phone, password: password), responseType: UserModel.self, successCallback: { user in
//            print("login api success")
//
//            JMSGUser.login(withUsername: phone, password: password, completionHandler: { resultObject,error in
//                if let error = error{
//                    showErrorText("登录失败: " + error.localizedDescription)
//                    return
//                }
//
//                user.saveToLocal()
//                kAppdelegate.enterMainVC()
//
//            })
//        })
        

    }
    
    func goToRegisterV(){
        let vc = CompleteUserInfoController()
        self.present(vc, animated: true, completion: nil)
    }


}
