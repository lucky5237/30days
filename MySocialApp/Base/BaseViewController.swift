//
//  BaseViewController.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/7.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import RTRootNavigationController

protocol BaseViewControllerProtocol {
    func initSubView()//初始化视图
    func initData()//初始化数据
}

class BaseViewController: UIViewController,BaseViewControllerProtocol {

    var titleLabel:UILabel!
    var backBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgroundColor
        initNavView()
        initSubView()
        initData()
    }
    
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        return UIBarButtonItem.init(title: "back", style: .plain, target: self, action: #selector(backBtnTapped))
    }

    // MARK: 子类实现
    
    //初始化视图
    func initSubView() {
        
    }
    
    //初始化数据
    func initData() {
        
    }
    
    //
    func initNavView(){
        self.titleLabel = UILabel()
        self.titleLabel.font = kFontSize(18)
        self.titleLabel.textColor = k222Color
        self.titleLabel.textAlignment = .center
        self.view.addSubview(self.titleLabel)
        
        
        self.backBtn = UIButton.init();
        self.backBtn.setImage(R.image.back(), for: .normal)
        self.backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        self.view.addSubview(self.backBtn)
        
        self.backBtn.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.height.width.equalTo(20)
            $0.top.equalTo(12+kStatusBarHeight)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.left.equalTo(self.backBtn.snp_rightMargin).offset(16)
            $0.centerY.equalTo(self.backBtn)
            $0.right.equalTo(-52)
        }
    
    }
    
    //点击导航栏返回按钮
    @objc func backBtnTapped(){
        self.navigationController?.popViewController(animated: true)
    }
   

}



