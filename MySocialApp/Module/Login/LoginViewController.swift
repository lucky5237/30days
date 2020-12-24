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

class LoginViewController: UIViewController {
    
    var logoImgView :UIImageView!
    var backgroundImgView :UIImageView!
    var loginBtn:UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initSubView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func initSubView() {
        logoImgView = UIImageView.init(image: kImage("logo"))
        
        backgroundImgView = UIImageView().then{
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = kThemeColor
        }
    
        loginBtn = UIButton().then{
            $0.setTitle("开始", for: .normal)
            $0.layer.cornerRadius = 11
            $0.layer.masksToBounds = true
            $0.backgroundColor = .white
            $0.setTitleColor(kMainTextColor, for: .normal)
            $0.titleLabel?.font = kMediumFontSize(14)
            $0.addClickCallback({[weak self] button in
                self?.login()
            })
        }
        
        
        self.view.addSubviews([backgroundImgView,logoImgView,loginBtn])
        
        backgroundImgView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
        
        logoImgView.snp.makeConstraints {
            $0.top.equalTo(kTopHeight + 23)
            $0.width.equalTo(90)
            $0.height.equalTo(29)
            $0.centerX.equalTo(self.view)
        }
        
        loginBtn.snp.makeConstraints {
            $0.bottom.equalTo(-(kBottomSafeHeight + 11))
            $0.height.equalTo(52)
            $0.width.equalTo(kScreenWidth - 54)
            $0.centerX.equalTo(self.view)
        }
        
    }
    
    func login(){
        self.navigationController?.pushViewController(LoginInputPhoneController())
        
    }


}
