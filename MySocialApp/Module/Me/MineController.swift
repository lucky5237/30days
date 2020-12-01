//
//  MineController.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/26.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class MineController: BaseViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let logOutBtn = UIButton(type: .system).then {
            $0.setTitle("退出登录", for: .normal)
            $0.addClickCallback({ button in
                self.logOut()
            })
        }
        self.view.addSubview(logOutBtn)
        logOutBtn.snp.makeConstraints{
            $0.center.equalTo(self.view)
        }
    }
    
    override func initData() {
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        request(.userInfo(userId: kUserId), responseType: UserModel.self, successCallback: { user in
            user.saveToLocal()
        })
    }
    
    func logOut(){
        self.showAlert(title:"", message: "确认退出吗", buttonTitles: ["取消","确认"], highlightedButtonIndex: 1) { index in
            if index == 1{
                JMSGUser.logout { result,error in
                    if let error = error{
                        showErrorText("退出登录失败：" + error.localizedDescription)
                        return
                    }
                    Defaults.removeAll()
                    kAppdelegate.enterLoginVC()
                }
            }
        }
        
    }
}
