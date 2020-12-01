//
//  Api.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/7.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import Moya
import SwiftyUserDefaults
import AliyunOSSiOS

//let kBaseUrl = "https://wwww.lukeyichy.tk"
let kBaseUrl = "http://10.0.0.16:5000"

enum API{
    case login(phone:String,password:String)
    case dynamicList(page:Int,size:Int)
    case register(phone:String,password:String)
    case userInfo(userId:Int)
    case userSig(phone:String)
//    case updateUser()
}

extension API: TargetType{
    var baseURL: URL {
        return URL(string: kBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .login(_,_):
            return "/login"
        case .register(_,_):
            return "/user"
        case .userInfo(let userId):
            return "/user/\(userId)"
        case .dynamicList(_,_):
            return "/dynamic"
        case .userSig(let phone):
            return "/userSig/\(phone)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login,.register:
            return .post
            
        case .dynamicList,.userInfo(_),.userSig:
            return .get
 
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .login(let phone, let password):
            return .requestParameters(parameters: ["phone":phone,"password":password], encoding: JSONEncoding.default)
        case .dynamicList(let page,let size):
            return .requestParameters(parameters: ["page":page,"size":size], encoding: URLEncoding.default)
        case .register(let phone,let password):
            return .requestParameters(parameters: ["phone":phone,"password":password], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var header = ["Content-type": "application/json"]
        let token = kToken
        if token.count > 0{
            header["Authorization"] = "token \(token)"
        }else{
            header["Authorization"] = ""
        }
        let timestamp = "\(Int(Date().timeIntervalSince1970))"
        let version = kAppVersion
        let channel = "iOS"
        let signature =  OSSUtil.dataMD5String(String.init(format: "%@%@%@%@%@", header["Authorization"] ?? "",timestamp,version,channel,API_SALT).data(using: .utf8))
        print("signature is " + signature!)
        header["timestamp"] = timestamp
        header["version"] = version
        header["channel"] = channel
        header["signature"] = signature
        return header
    }
    
}





