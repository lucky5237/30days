//
//  TimTools.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/28.
//  Copyright © 2019 lujian. All rights reserved.
//

import Foundation

class IMTool {
    static func loginTim(identifier:String,userSig:String,succCallback:@escaping ()->Void,failCallback:((Int32,String?)->Void)?){
        
//        let login_params = TIMLoginParam()
//        login_params.identifier = identifier
//        login_params.userSig = userSig
//        TIMManager.sharedInstance()?.login(login_params, succ: {
//            succCallback()
//        }, fail: { code,error in
//
//            if(code == ERR_IMSDK_KICKED_BY_OTHERS){
//                //用户被挤掉
//                handleWhenForceOffLine()
//            }else if (code == Int32(ERR_USER_SIG_EXPIRED.rawValue)){
//                //userSig过期
//                handleWhenSigExpired()
//            }else{
//                print ("TIM login failed -- code = %d，error = %@",code,error ?? "")
//                showErrorText("腾讯云登录失败：\(error ??  "")")
//            }
//
//            if let fail = failCallback{
//                fail(code,error)
//            }
//
//        })
    }
    
    
    static func handleWhenBeingKicked(){
        print("your account logined in other device")
        showInfoText("您的账号已在其他设备登录，请重新登录")
        kAppdelegate.enterLoginVC()
    }
    
}


