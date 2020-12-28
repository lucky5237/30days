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
import Pastel

class LoginViewController: UIViewController {
    
    var logoImgView :UIImageView!
    var backgroundView :PastelView!
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
        
        backgroundView = PastelView(frame: view.bounds)
        
        // Custom Direction
        backgroundView.startPastelPoint = .bottomLeft
        backgroundView.endPastelPoint = .topRight
        
        // Custom Duration
        backgroundView.animationDuration = 3.0
        
        // Custom Color
        backgroundView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        backgroundView.startAnimation()
        view.insertSubview(backgroundView, at: 0)
        
        
        self.view.addSubviews([logoImgView,loginBtn])
        
        
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
