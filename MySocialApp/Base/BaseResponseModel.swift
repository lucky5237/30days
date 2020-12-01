//
//  BaseResponseModel.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/7.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import HandyJSON

class BaseResponseModel<T> : HandyJSON{
    var message: String?
    var data: T?
    var code: String?
    
    required init() {
        
    }
    
    func isAck() -> Bool {
        guard let code = self.code else{
            return false
        }
        return code == "ACK"
    }
    
}
