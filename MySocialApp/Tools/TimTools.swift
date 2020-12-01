//
//  TimTools.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/28.
//  Copyright © 2019 lujian. All rights reserved.
//

import Foundation

class TimTool {
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
    
    
//    static func handleWhenForceOffLine(){
//        print("your account logined in other device")
//    }
//    
//    static func handleWhenSigExpired(){
//        print("userSig had expired! you should apply a new one from sever side")
//    }
}


