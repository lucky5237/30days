//
//  LoginSMSCodeController.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/18.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation
 
class LoginSMSCodeController : UIViewController {
    var phone:String?
    var code:String?
    var loginBtn:BaseButton!
    var stepView:StepView!
    var hintLabel:UILabel!
    var smsCodeView:CRBoxInputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        self.view.backgroundColor = .white
        initSubView()
        initData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func initData() {
       
    }
    
    func initSubView() {
        
        let titleLabel = UILabel().then{
            $0.textColor = kMainTextColor
            $0.font = kBoldFontSize(26)
            $0.numberOfLines = 0
            $0.text = "输入验证码"
        }
        
        let hintStr = NSMutableAttributedString.init(string: "验证码已发送至 +86 \(phone!)", attributes: [NSAttributedString.Key.font:kFontSize(14),NSAttributedString.Key.foregroundColor:kSubTextColor])
        hintStr.addAttributes([NSAttributedString.Key.font:kMediumFontSize(14),NSAttributedString.Key.foregroundColor:kThemeColor], range: .init(location: hintStr.length - 15, length: 15))
        
        hintLabel = UILabel().then{
            $0.numberOfLines = 0
            $0.attributedText = hintStr
        }
        
        let cellProperty = CRBoxInputCellProperty()
        cellProperty.cornerRadius = 16
        cellProperty.borderWidth = 1
        cellProperty.cellBorderColorFilled = kThemeColor
        cellProperty.cellBorderColorNormal = kHexColor(hex: "#CED0D6")!
        cellProperty.cellBorderColorSelected = kHexColor(hex: "#CED0D6")!
        cellProperty.cellFont = kBoldFontSize(20)
        cellProperty.cellTextColor = kMainTextColor
        cellProperty.showLine = false
        
        smsCodeView = CRBoxInputView(codeLength: 4)
        smsCodeView.ifNeedCursor = false
        let width = (kScreenWidth - 120) / 4
        smsCodeView.boxFlowLayout?.itemSize = .init(width: width, height: width)
        smsCodeView.customCellProperty = cellProperty
        smsCodeView.loadAndPrepare(withBeginEdit: true)
        smsCodeView.textDidChangeblock = { (text,isFinished) in
            self.loginBtn.isEnabled = isFinished
        }
        
        stepView = StepView(stepNum: 2, currentStep: 2)
        stepView.heroID = "step"
        
        loginBtn = BaseButton(title: "开始30days").then{
            $0.addClickCallback({[weak self] button in
                self?.login()
            })
            $0.heroID = "button"
            $0.isEnabled = false
        }
        
        
        self.view.addSubviews([titleLabel,hintLabel,smsCodeView,stepView,loginBtn])
        
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
        
        smsCodeView.snp.makeConstraints {
            $0.width.equalTo(kScreenWidth - 48)
            $0.centerX.equalTo(self.view)
            $0.top.equalTo(hintLabel.snp_bottomMargin).offset(75)
            $0.height.equalTo(width)
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
    
    
    
    func login(){
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
        
        goToSelectGenderVC()

    }
    
    func goToSelectGenderVC(){
        let vc = LoginSelectGenderController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
}
