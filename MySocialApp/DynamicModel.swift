//
//  DynamicModel.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/11.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import HandyJSON

class DynamicModel: HandyJSON {
    
    var dynamicId:Int!
    var content:String?
    var userId:Int!
    var user:UserModel?
    var praiseNum:Int!
    var praised:Bool?
    var createTime:String?
    var photo:String!
    var photos:[String]!{
        get{
            return self.photo.components(separatedBy: ",")
        }
    }
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.photo <-- "photos"
        mapper <<<
            self.dynamicId <-- "id"
    }

}
