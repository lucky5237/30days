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
        self.view.backgroundColor = .white
        initSubView()
        initData()
        
    }

    
    func initData() {
        
    }
    
    func initSubView() {
        
        hintLabel = UILabel().then{
            $0.textColor = kSubTextColor
            $0.font = kFontSize(18)
            $0.numberOfLines = 0
            $0.text = "请选择您的性别"
        }
        
        maleBtn = UIButton().then{
            $0.setTitle("男生", for:.normal)
            $0.setTitleColor(kMainTextColor, for:.normal)
            $0.contentHorizontalAlignment = .left
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
            $0.titleEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
            $0.titleLabel?.font = kMediumFontSize(18)
            $0.setImage(kImage("选中"), for: .selected)
            $0.setImage(kImage("选中"), for: [.selected, .highlighted])
            $0.setImage(kImage("未选中"), for: .normal)
            $0.addClickCallback { sender in
                if !sender.isSelected{
                    sender.isSelected = true
                    sender.setTitleColor(kMainTextColor, for: .normal)
                    self.femaleBtn.isSelected = false
                    self.femaleBtn.setTitleColor(.lightGray, for: .normal)
                    self.loginBtn.isEnabled = true
                }
            }
        }
        
        femaleBtn = UIButton().then{
            $0.setTitle("女生", for:.normal)
            $0.setTitleColor(kMainTextColor, for:.normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
            $0.titleLabel?.font = kMediumFontSize(18)
            $0.setImage(kImage("选中"), for: .selected)
            $0.setImage(kImage("选中"), for: [.selected, .highlighted])
            $0.setImage(kImage("未选中"), for: .normal)
            $0.addClickCallback { sender in
                if !sender.isSelected{
                    sender.isSelected = true
                    sender.setTitleColor(kMainTextColor, for: .normal)
                    self.maleBtn.isSelected = false
                    self.maleBtn.setTitleColor(.lightGray, for: .normal)
                    self.loginBtn.isEnabled = true
                }
            }
        }
       
        
        stepView = StepView(stepNum: 3)
        
        loginBtn = BaseButton(title: "下一步").then{
            $0.isEnabled = false
            $0.addClickCallback { sender in
                let vc = LoginUserInfoController()
                self.navigationController?.pushViewController(vc)
            }
        }
        
        self.view.addSubviews([hintLabel,maleBtn,femaleBtn,stepView,loginBtn])
        
        hintLabel.snp.makeConstraints{
            $0.top.equalTo(kTopHeight + 90)
            $0.left.equalTo(27)
            $0.right.equalTo(-27)
        }
        
        maleBtn.snp.makeConstraints {
            $0.top.equalTo(hintLabel.snp_bottomMargin).offset(54)
            $0.left.equalTo(27)
            $0.width.equalTo(100)
        }
        
        femaleBtn.snp.makeConstraints {
            $0.top.equalTo(maleBtn.snp_bottomMargin).offset(26)
            $0.left.equalTo(27)
            $0.width.equalTo(100)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
