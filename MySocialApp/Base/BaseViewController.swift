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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgroundColor
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
    
    //点击导航栏返回按钮
    @objc func backBtnTapped(){
        self.navigationController?.popViewController(animated: true)
    }
   

}



