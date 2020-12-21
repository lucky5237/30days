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
        
        let hintStr = NSMutableAttributedString.init(string: "验证码已发送至 +86 \(phone!)", attributes: [NSAttributedString.Key.font:kFontSize(18),NSAttributedString.Key.foregroundColor:kSubTextColor])
        hintStr.addAttributes([NSAttributedString.Key.font:kMediumFontSize(18),NSAttributedString.Key.foregroundColor:kMainTextColor], range: .init(location: hintStr.length - 15, length: 15))
        
        hintLabel = UILabel().then{
            $0.numberOfLines = 0
            $0.attributedText = hintStr
        }
        
        let cellProperty = CRBoxInputCellProperty()
        cellProperty.cellCursorColor = k999Color
        cellProperty.cellCursorWidth = 2
        cellProperty.cellCursorHeight = 20
        cellProperty.cornerRadius = 0
        cellProperty.borderWidth = 0
        cellProperty.cellFont = kMediumFontSize(32)
        cellProperty.cellTextColor = kMainTextColor
        cellProperty.showLine = true
        
        smsCodeView = CRBoxInputView(codeLength: 4)
        smsCodeView.ifNeedCursor = false
        smsCodeView.boxFlowLayout?.itemSize = .init(width: 50, height: 50)
        smsCodeView.customCellProperty = cellProperty
        smsCodeView.loadAndPrepare(withBeginEdit: true)
        smsCodeView.textDidChangeblock = { (text,isFinished) in
            self.loginBtn.isEnabled = isFinished
        }
        
        stepView = StepView(stepNum: 2, currentStep: 2)
        
        loginBtn = BaseButton(title: "开始30days").then{
            $0.addClickCallback({[weak self] button in
                self?.login()
            })
            
            $0.isEnabled = false
        }
        
        
        self.view.addSubviews([hintLabel,smsCodeView,stepView,loginBtn])
        
        hintLabel.snp.makeConstraints{
            $0.top.equalTo(kTopHeight + 90)
            $0.left.equalTo(27)
            $0.right.equalTo(-27)
        }
        
        smsCodeView.snp.makeConstraints {
            $0.width.equalTo(kScreenWidth - 80)
            $0.centerX.equalTo(self.view)
            $0.top.equalTo(hintLabel.snp_bottomMargin).offset(32)
            $0.height.equalTo(50)
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
