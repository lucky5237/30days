//
//  SocialUserDefaults.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/17.
//  Copyright © 2019 lujian. All rights reserved.
//

import SwiftyUserDefaults

var kToken: String{
    get{
        return Defaults[\.token]
    }
    
    set{
        Defaults[\.token] = newValue
    }
}

var kUserId: Int{
    
    get{
        return Defaults[\.userId]
    }
    
    set{
        Defaults[\.userId] = newValue
    }
}

var kPhone: String{
    get{
        return Defaults[\.phone]
    }
    
    set{
        Defaults[\.phone] = newValue
    }
}

var kCurrentUser: UserModel?{
    get{
        return UserModel.deserialize(from: Defaults[\.user])
    }
    
    set{
        Defaults[\.user] = newValue?.toJSONString() ?? ""
    }
}

var kIsLogin: Bool{
   return kToken.count > 0
}

//userdefaults
extension DefaultsKeys{
    var user : DefaultsKey<String>{.init("user",defaultValue:"")}
    var userId : DefaultsKey<Int>{.init("userId",defaultValue:-1)}
    var phone : DefaultsKey<String>{.init("phone",defaultValue:"")}
    var token : DefaultsKey<String>{.init("token",defaultValue:"")}
    var latitude : DefaultsKey<Double>{.init("latitude",defaultValue: 0.00)}
    var longitude : DefaultsKey<Double>{.init("longitude",defaultValue: 0.00)}
    var city : DefaultsKey<String>{.init("city",defaultValue: "")}
    var district : DefaultsKey<String>{.init("district",defaultValue: "")}
}




