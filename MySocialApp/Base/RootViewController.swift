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

        let firstVC = RTContainerNavigationController(rootViewController: ViewController())
        let secondVC = RTContainerNavigationController(rootViewController: MainViewController())
        let thirdVC = RTContainerNavigationController(rootViewController: PhotoViewController())
        let fourthVC = RTContainerNavigationController(rootViewController: MessageViewController())
        let fifthVC = RTContainerNavigationController(rootViewController: MineController())
        
        firstVC.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "Home", image:R.image.home(), selectedImage: R.image.home_1())
        secondVC.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "Find", image: R.image.find(), selectedImage: R.image.find_1())
        thirdVC.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "Photo", image: R.image.message(), selectedImage: R.image.message_1())
        fourthVC.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "Favor", image:R.image.favor(), selectedImage: R.image.favor_1())
        fifthVC.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView(), title: "Me", image:R.image.me(), selectedImage:R.image.me_1())
        
        self.viewControllers = [firstVC,secondVC,thirdVC,fourthVC,fifthVC]
        self.tabBar.backgroundColor = .white
    }

   
}
