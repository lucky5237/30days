//
//  RootViewController.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/10.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import RTRootNavigationController

class RootViewController: ESTabBarController{
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configViewControllers()
    }
    
    func configViewControllers(){

        let mainVC = RTContainerNavigationController(rootViewController: MainViewController())
        let msgVC = RTContainerNavigationController(rootViewController: MessageViewController())
        let myVC = RTContainerNavigationController(rootViewController: MineController())
        
        mainVC.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "匹配", image:R.image.home(), selectedImage: R.image.home_1())
        msgVC.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "消息", image: R.image.message(), selectedImage: R.image.message_1())
        myVC.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "我的", image: R.image.me(), selectedImage: R.image.me_1())
        
        
        self.viewControllers = [mainVC,msgVC,myVC]
        self.tabBar.backgroundColor = .white
    }

   
}
