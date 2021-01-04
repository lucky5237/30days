//
//  UserModel.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/8.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import HandyJSON

enum Gender:Int {
    case unknown = 0
    case male
    case female
}

class UserModel: HandyJSON{
    var token:String!
    var profilePhotos:[String]!{
        get{
            return self.photos?.components(separatedBy: ",") ?? []
        }
    }
    var userStatus:Int?
    var photos:String!
    var phone:String!
    var userName: String?
    var userId: Int!
    var userAvatar :String?
    var locationCity:String?
    var locationDistrict:String?
    var gender:Gender?
    var age:Int?
    var height: Int?
    var weight: Int?
    var constellation:String?
    var introduction:String?
    var genderStr:String{
        get{
            return self.gender == .male ? "男" : (self.gender == .female ? "女" : "未知")
        }
    }
    required init() {
    
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.userId <-- "id"
        mapper <<<
            self.userName <-- "userInfo.userName"
        mapper <<<
            self.photos <-- "userInfo.photos"
        mapper <<<
            self.userAvatar <-- "userInfo.userAvatar"
        mapper <<<
            self.locationCity <-- "userInfo.locationCity"
        mapper <<<
            self.locationDistrict <-- "userInfo.locationDistrict"
        mapper <<<
            self.gender <-- "userInfo.gender"
        mapper <<<
            self.age <-- "userInfo.age"
        mapper <<<
            self.constellation <-- "userInfo.constellation"
        mapper <<<
            self.introduction <-- "userInfo.introduction"
        mapper <<<
            self.height <-- "userInfo.height"
        mapper <<<
            self.weight <-- "userInfo.weight"
    }
    
    func saveToLocal(){
        kToken = self.token
        kUserId = self.userId
        kPhone = self.phone
        kCurrentUser = self
    }
}
