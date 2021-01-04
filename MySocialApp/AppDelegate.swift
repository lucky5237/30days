//
//  AppDelegate.swift
//  MySocialApp
//
//  Created by lukey on 2019/6/6.
//  Copyright © 2019 lujian. All rights reserved.
//

import UIKit
import RTRootNavigationController
import AliyunOSSiOS
import SwiftyUserDefaults
import UserNotifications


public protocol SelfAware: class {
    static func awake()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    var provider:OSSPlainTextAKSKPairCredentialProvider!
    var client:OSSClient!
    lazy var locationManager = BMKLocationManager()
    lazy var mapManager = BMKMapManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        #if DEBUG
        //        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        //        #endif
        initConfig()
        setupServerConfig()
        setupUmengConfig()
        setupOSSConfig()
        setupLocationConfig()
        setupBaiduMapConfig()
        setupIMConfig(launchOptions)
        setupRootVC()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

extension AppDelegate:JMessageDelegate,BMKLocationAuthDelegate,BMKLocationManagerDelegate{
    
    
    //初始化app一般设置
    func initConfig(){
        if #available(iOS 11.0, *) {
            UITableView.appearance().estimatedRowHeight = 0
            UITableView.appearance().estimatedSectionFooterHeight = 0
            UITableView.appearance().estimatedSectionHeaderHeight = 0
        }
        
    }
    
    //初始化服务端设置
    func setupServerConfig(){
//        // 放在 SDK 初始化语句 LCApplication.default.set 前面，只需要调用一次即可
//        LCApplication.logLevel = .all
//
//        do {
//            try LCApplication.default.set(
//                id: LEANCLOUD_APP_ID,
//                key: LEANCLOUD_APP_KEY
//            )
//        } catch {
//            fatalError("\(error)")
//        }
        //注册bmob
//        Bmob.register(withAppKey: BMOB_APP_KEY)
    }
    
    //初始化阿里云
    func setupOSSConfig(){
        provider = OSSPlainTextAKSKPairCredentialProvider(plainTextAccessKey: OSS_ACCESSKEY_ID, secretKey: OSS_SECRETKEY_ID)
        //        let provider = OSSAuthCredentialProvider(authServerUrl: OSS_STSTOKEN_URL)
        client = OSSClient(endpoint: OSS_ENDPOINT,  credentialProvider: provider)
    }
    
    //初始化im
    func setupIMConfig(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        JMessage.setupJMessage(launchOptions, appKey: IM_APP_KEY, channel: nil, apsForProduction: kApsForProduction, category: nil, messageRoaming: true)
        
        JMessage.add(self, with: nil)
        
        if PRODUCTION {
            JMessage.setLogOFF()
        }else{
            JMessage.setDebugMode()
        }
        
        JMessage.register(forRemoteNotificationTypes: UNAuthorizationOptions.badge.rawValue |
            UNAuthorizationOptions.sound.rawValue |
            UNAuthorizationOptions.alert.rawValue, categories: nil)
    }
    
    //初始化定位
    func setupLocationConfig(){
        BMKLocationAuth.sharedInstance()?.checkPermision(withKey: BDMAP_KEY, authDelegate: self)
        //设置delegate
        locationManager.delegate = self;
        //设置返回位置的坐标系类型
        locationManager.coordinateType = .BMK09LL;
        //设置距离过滤参数
        locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置预期精度参数
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置应用位置类型
        locationManager.activityType = .automotiveNavigation;
        //设置是否自动停止位置更新
        locationManager.pausesLocationUpdatesAutomatically = false;
        //设置是否允许后台定位
        //_locationManager.allowsBackgroundLocationUpdates = YES;
        //设置位置获取超时时间
        locationManager.locationTimeout = 10;
        //设置获取地址信息超时时间
        locationManager.reGeocodeTimeout = 10;
        //        AMapServices.shared().apiKey = AMAP_KEY
        //        locationManager.delegate = self
        //        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //        locationManager.locationTimeout = 2
        //        locationManager.reGeocodeTimeout = 2
    }
    
    //初始化地图
    func setupBaiduMapConfig(){
        mapManager.start(BDMAP_KEY, generalDelegate: nil)
    }
    
    //初始化友盟
    func setupUmengConfig(){
        UMConfigure.initWithAppkey(UMENG_APP_KEY, channel: "App Store")
        UMConfigure.setLogEnabled(PRODUCTION)
    }
    
    //设置根视图控制器
    func setupRootVC(){
        if kIsLogin{
            enterMainVC()
        }else{
//            enterLoginVC()
            enterMainVC()
        }
    }
    
    //进入主页
    func enterMainVC(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RTRootNavigationController.init(rootViewControllerNoWrapping:RootViewController())
        window?.makeKeyAndVisible()
    }
    
    //进入登录页
    func enterLoginVC(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController.init(rootViewController:LoginSelectGenderController())
        window?.makeKeyAndVisible()
    }
    
    //重置气泡
    private func resetBadge(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        JMessage.resetBadge()
    }
    
    //开始定位
    func startRequestLocation(){
        locationManager.requestLocation(withReGeocode: true, withNetworkState: true) { (location, state, error) in
            if let error = error{
                print("定位错误: \(error.localizedDescription)")
                return
            }
            if let location = location?.location {
                print("location:%@", location)
                Defaults[\.latitude] = location.coordinate.latitude
                Defaults[\.longitude] = location.coordinate.longitude
            }
            
            if let reGeocode = location?.rgcData {
                Defaults[\.city] = reGeocode.city
                Defaults[\.district] = reGeocode.district
            }
            
        };
    }
    //        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
    //
    //            if let error = error {
    //                let error = error as NSError
    //
    //                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
    //                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
    //                    print("定位错误:{\(error.code) - \(error.localizedDescription)};")
    //                    return
    //                }
    //                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
    //                    || error.code == AMapLocationErrorCode.timeOut.rawValue
    //                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
    //                    || error.code == AMapLocationErrorCode.badURL.rawValue
    //                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
    //                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
    //                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
    //                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
    //                }
    //                else {
    //                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
    //                }
    //            }
    //
    //            if let location = location {
    //                print("location:%@", location)
    //                Defaults[.latitude] = location.coordinate.latitude
    //                Defaults[.longitude] = location.coordinate.longitude
    //            }
    //
    //            if let reGeocode = reGeocode {
    //                print("reGeocode:%@", reGeocode)
    //                Defaults[.city] = reGeocode.city
    //                Defaults[.district] = reGeocode.district
    //            }
    //
    //
    //        })
    //}
    
    func onCheckPermissionState(_ iError: BMKLocationAuthErrorCode) {
        switch iError {
        case .success:
            print("百度地图授权成功")
        default:
            print("百度地图授权失败")
        }
    }
    
    //    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
    //        locationManager.requestAlwaysAuthorization()
    //    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JMessage.registerDeviceToken(deviceToken)
    }
    
    //im接受登录状态改变
    func onReceive(_ event: JMSGUserLoginStatusChangeEvent!) {
        switch event.eventType.rawValue {
        case JMSGLoginStatusChangeEventType.eventNotificationLoginKicked.rawValue,
             JMSGLoginStatusChangeEventType.eventNotificationServerAlterPassword.rawValue,
             JMSGLoginStatusChangeEventType.eventNotificationUserLoginStatusUnexpected.rawValue:
            IMTool.handleWhenBeingKicked()
        default:
            break
        }
    }
}

