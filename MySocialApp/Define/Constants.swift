//
//  Constants.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/7.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import SwifterSwift
import SwiftyUserDefaults

let kApsForProduction = false

let kPlaceHolderImage = R.image.icon()
//let kIMManager = TIMManager.sharedInstance()

//常用缩写
let kApplication = UIApplication.shared
let kKeyWindow = UIApplication.shared.delegate!.window!!
let kAppdelegate = kApplication.delegate as! AppDelegate
let kAliyunOssClient = kAppdelegate.client!
let kAppNotificationCenter = NotificationCenter.default
let kAppRootViewController = kAppdelegate.window?.rootViewController as! RootViewController

//分页相关
let kPageParamKey = "page"
let kPageSizeParamKey = "size"
let kPageSize = 10
let kFirstPageNum = 1

//常用尺寸
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
let kTabbarHeight:CGFloat = kIsIPhoneXSeries() ? 83.0 : 49.0
let kBottomSafeHeight:CGFloat = kIsIPhoneXSeries() ? 34 : 0
let kTopHeight:CGFloat = kIsIPhoneXSeries() ? 88 : 64
let kSafeAreaHeight:CGFloat = kScreenHeight - kTabbarHeight - kTopHeight
func kScale(_ originSize:CGFloat) -> CGFloat {
    return originSize * kScreenWidth / 375.0
}

//设备信息
let kAppVersion:String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String//APP版本号
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue//当前系统版本号
let kIsIphone = UIDevice.current.userInterfaceIdiom == .phone
func kIsIPhoneXSeries() -> Bool{
    if #available(iOS 11.0, *){
        return kIsIphone && kKeyWindow.safeAreaInsets.bottom > 0
    }
    return false
}

//字体相关
func kLightFontSize (_ size: CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size, weight: .light)
}

func kFontSize (_ size: CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}

func kMediumFontSize (_ size: CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size, weight: .medium)
}

func kBoldFontSize (_ size: CGFloat) -> UIFont{
    return UIFont.boldSystemFont(ofSize:size)
}

func kImage (_ name: String) -> UIImage{
    return UIImage.init(named: name)!
}

//颜色相关
let kThemeColor = kHexColor(hex:"#FF3E00")!
let kBackgroundColor = kHexColor(hex:"#F6F5F0")!
let kDividerColor = kHexColor(hex:"#F5F5F5")!
let kMainTextColor = kHexColor(hex:"#292925")!
let kSubTextColor = kHexColor(hex:"#626260")!
let k222Color = kHexColor(hex:"#222222")!
let k666Color = kHexColor(hex:"#666666")!
let k999Color = kHexColor(hex:"#999999")!

//按钮相关

let kNormalButtonTitleColor = UIColor.white
let kNormalButtonBgColor = kThemeColor


func kHexColor(hex:String) -> UIColor?{
    return UIColor.init(hexString: hex)
}








