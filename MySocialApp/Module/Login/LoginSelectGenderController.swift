//
//  LoginSelectGenderController.swift
//  MySocialApp
//
//  Created by lukey on 2020/12/19.
//  Copyright © 2020 lujian. All rights reserved.
//

import Foundation
class LoginSelectGenderController :UIViewController{
    var hintLabel:UILabel!
    var maleBtn:UIButton!
    var femaleBtn:UIButton!
    var loginBtn:BaseButton!
    var stepView:StepView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgroundColor
        initSubView()
        initData()
        
    }

    
    func initData() {
        
    }
    
    func initSubView() {
        
        
        let titleLabel = UILabel().then{
            $0.textColor = kMainTextColor
            $0.font = kBoldFontSize(26)
            $0.numberOfLines = 0
            $0.text = "选择性别"
        }
        
        hintLabel = UILabel().then{
            $0.textColor = kSubTextColor
            $0.font = kFontSize(14)
            $0.numberOfLines = 0
            $0.text = "性别一旦选定，将无法修改"
        }
        
        maleBtn = UIButton().then{
            $0.setTitle("男,BOY", for:.normal)
            $0.setTitleColor(kMainTextColor, for:.normal)
            $0.contentHorizontalAlignment = .left
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
            $0.titleEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
            $0.titleLabel?.font = kMediumFontSize(20)
            $0.setImage(kImage("选中"), for: .selected)
            $0.setImage(kImage("选中"), for: [.selected, .highlighted])
            $0.setImage(kImage("未选中"), for: .normal)
            $0.addClickCallback { sender in
                if !sender.isSelected{
                    sender.isSelected = true
                    sender.setTitleColor(kMainTextColor, for: .normal)
                    self.femaleBtn.isSelected = false
                    self.femaleBtn.setTitleColor(kHexColor(hex:"#A9AEB9")!, for: .normal)
                    self.loginBtn.isEnabled = true
                }
            }
        }
        
        femaleBtn = UIButton().then{
            $0.setTitle("女,GIRL", for:.normal)
            $0.setTitleColor(kMainTextColor, for:.normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
            $0.titleLabel?.font = kMediumFontSize(20)
            $0.setImage(kImage("选中"), for: .selected)
            $0.setImage(kImage("选中"), for: [.selected, .highlighted])
            $0.setImage(kImage("未选中"), for: .normal)
            $0.addClickCallback { sender in
                if !sender.isSelected{
                    sender.isSelected = true
                    sender.setTitleColor(kMainTextColor, for: .normal)
                    self.maleBtn.isSelected = false
                    self.maleBtn.setTitleColor(kHexColor(hex:"#A9AEB9")!, for: .normal)
                    self.loginBtn.isEnabled = true
                }
            }
        }
       
        
        stepView = StepView(stepNum: 2)
        
        loginBtn = BaseButton(title: "最后一步，完善资料").then{
            $0.isEnabled = false
            $0.addClickCallback { sender in
                
                BaseAlertView.show(title: "", content: "确认性别后将无法更改，请谨慎选择", confirmTitle: "确认", confirmClickBlock: { sender in
                    let vc = LoginUserInfoController()
                    vc.gender = self.maleBtn.isSelected ?  0 : 1
                    self.navigationController?.pushViewController(vc)
                }, cancelTitle: "我再想想", cancelClickBlock: nil)
                
            }
        }
        
        self.view.addSubviews([titleLabel,hintLabel,maleBtn,femaleBtn,stepView,loginBtn])
        
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
        
        maleBtn.snp.makeConstraints {
            $0.top.equalTo(hintLabel.snp_bottomMargin).offset(54)
            $0.left.equalTo(24)
            $0.width.equalTo(120)
        }
        
        femaleBtn.snp.makeConstraints {
            $0.top.equalTo(maleBtn.snp_bottomMargin).offset(26)
            $0.left.equalTo(24)
            $0.width.equalTo(120)
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
    
}
