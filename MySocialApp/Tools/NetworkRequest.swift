//
//  NetworkRequest.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/7.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import HandyJSON
import SVProgressHUD

enum ResponseError: Error{
    case parseJsonError
    case otherError
}

//是否打印日志
private let networkLoggerPlugin = NetworkLoggerPlugin()

//监听网络请求发送
private let networkActivityPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
    
    DispatchQueue.main.async {
        switch changeType{
        case .began:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            kKeyWindow.showLoading()
        case .ended:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            kKeyWindow.hideLoading()
        }
    }
    
}

let api = MoyaProvider<API>(plugins: [networkLoggerPlugin,networkActivityPlugin])

let SUCCESS_STATUS_CODE = 200

let bag = DisposeBag()

func request<T>(_ target:API,responseType type:T.Type,successCallback: @escaping (T) -> Void,failureCallback:((Error) -> Void)? = nil){
    api.rx.request(target).filterSuccessfulStatusCodes().mapJSON(failsOnEmptyData: true).subscribe(onSuccess: { response in
        guard let resp = BaseResponseModel<T>.deserialize(from: response as? [String:Any]) else{
            print("json解析错误")
            return
        }
        if resp.isAck(){
            successCallback(resp.data!)
        }else{
            if let msg = resp.message{
               showInfoText(msg)
            }
        }
    }, onError: { error in
       handleError(error: error, failureCallback: failureCallback)
    }).disposed(by: bag)
}

func createObservable<T:Decodable> (_ target:API,type:T) -> Single<T>{
    let response = api.rx.request(target).filterSuccessfulStatusCodes().map(T.self, atKeyPath: "data", using: JSONDecoder(), failsOnEmptyData: true)
    return response
}

////对象：HandyJSON映射
//func netWorkRequest<T:HandyJSON>(_ target:API,responseObjectType type:T.Type,successCallback: @escaping (T) -> Void,failureCallback:((Error) -> Void)? = nil){
//    api.rx.request(target).filterSuccessfulStatusCodes().mapJSON().asObservable().mapObject(type: T.self).subscribe(onNext: {
//        successCallback($0)
//    }, onError:{
//        handleError(error: $0, failureCallback: failureCallback)
//    } ).disposed(by: bag)
//}
//
////数组（item：HandyJSON）映射
//func netWorkRequest<T:HandyJSON>(_ target:API,responseArrayType type:T.Type,successCallback: @escaping ([T]) -> Void,failureCallback:((Error) -> Void)? = nil){
//    api.rx.request(target).filterSuccessfulStatusCodes().mapString().asObservable().mapArray(type: T.self).subscribe(onNext: {
//        successCallback($0)
//    }, onError:{
//        handleError(error: $0, failureCallback: failureCallback)
//    } ).disposed(by: bag)
//}
//
////基本类型的映射 like String、Int
//func netWorkRequest<T>(_ target:API,responseBasicObject type:T.Type,successCallback: @escaping (T) -> Void,failureCallback:((Error) -> Void)? = nil){
//    api.rx.request(target).filterSuccessfulStatusCodes().mapString() .asObservable().mapBasicObject(type: T.self).subscribe(onNext: {
//        successCallback($0)
//    }, onError:{
//        handleError(error: $0, failureCallback: failureCallback)
//    } ).disposed(by: bag)
//}

//处理错误，需要处理400..<500的情况
fileprivate func handleError(error:Error,failureCallback:((Error) -> Void)?){
    //    print(error.localizedDescription)
    if let error = error as? Moya.MoyaError{
        switch error{
        case .statusCode(let code) where code.statusCode == 500:
            showErrorText("服务器异常")
        case .statusCode(let code) where code.statusCode == 400:
            showErrorText("参数传递错误")
        case .statusCode(let code) where code.statusCode == 401:
            if kToken.count > 0{
                showErrorText("你的账号已在其他设备登录，请重新登录")
            }else{
                showErrorText("请先登录")
            }
            kAppdelegate.enterLoginVC()
    
        default:
            if error.errorCode == 6{
                showErrorText("服务器连接失败")
            }else{
                print("error occured with statusCode \(error.errorCode)")
                showErrorText( error.errorDescription ?? "未知错误")
            }
            break
        }
    }
    
    if let error = error as? ResponseError{
        switch error{
        case .parseJsonError:
            showErrorText("参数解析错误")
            print("Can't parse to json")
        default:
            break
        }
    }
    
    if let failCallback = failureCallback{
        failCallback(error)
    }
}

//func netWorkRequest<T>(_ target:API,responseType type:T.Type,successCallback: @escaping ([T]) -> Void,failureCallback:((Error) -> Void)?,isConvertToArray:Bool = false){
//    api.rx.request(target).filterSuccessfulStatusCodes().mapJSON().subscribe(onSuccess: {
//        if isConvertToArray{
//            guard let responseModel = BaseResponseModel<[T]>.deserialize(from: $0 as? [String : Any]),let responseData = responseModel.data else{
//                return
//            }
//            print(responseData)
//            successCallback(responseData)
//        }else{
//            guard let responseModel = BaseResponseModel<T>.deserialize(from: $0 as? [String : Any]),let responseData = responseModel.data else{
//                return
//            }
//            print(responseData)
//            successCallback([responseData])
//        }
//    }, onError:{
//        handleError(error: $0, failureCallback: failureCallback)
//    }).disposed(by: bag)
//}

extension Observable{
    func mapObject<T:HandyJSON>(type:T.Type) -> Observable<T> {
        return self.map{
            response in
            
            guard let responseDict = response as? [String:Any], let responseObject = JSONDeserializer<T>.deserializeFrom(dict: responseDict,designatedPath: "data") else{
                throw ResponseError.parseJsonError
            }
            return responseObject
        }
    }
    
    func mapArray<T:HandyJSON>(type:T.Type) -> Observable<[T]> {
        return self.map{
            response in
            
            guard let jsonString = response as? String,let responseArray = JSONDeserializer<T>.deserializeModelArrayFrom(json: jsonString, designatedPath: "data") else{
                throw ResponseError.parseJsonError
            }
            return responseArray as! [T]
        }
    }
    
    func mapBasicObject<T>(type:T.Type) -> Observable<T> {
        return self.map{
            response in
            

            guard let responseDict = response as? [String:Any] else{
                throw ResponseError.parseJsonError
            }
            guard let responseObject = responseDict["data"] else{
                throw ResponseError.parseJsonError
            }
            
            guard let responseResult = responseObject as? T else{
                throw ResponseError.parseJsonError
            }
            
            return responseResult
        
        }
    }
}

