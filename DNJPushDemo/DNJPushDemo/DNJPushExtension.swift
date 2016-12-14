//
//  DNJPushExtension.swift
//  DNJPushDemo
//
//  Created by mainone on 16/12/13.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

// 推送参数配置
let JPushAppKey = "2c8a39f03e76c83807c22634"
let JPushChannel = "AppStore"
let JPushIsProduction = false

extension AppDelegate: JPUSHRegisterDelegate {
    
    func RegisterJPush(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        let entity = JPUSHRegisterEntity()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue) | Int(JPAuthorizationOptions.badge.rawValue) | Int(JPAuthorizationOptions.sound.rawValue)
        if Double(UIDevice.current.systemVersion)! >= 8.0 {
            // 可以添加自定义categories
            
        }
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        JPUSHService.setup(withOption: launchOptions, appKey: JPushAppKey, channel: JPushChannel, apsForProduction: JPushIsProduction)
        
        // 添加推送监听
        let defaultCenter = NotificationCenter.default
        defaultCenter.addObserver(self, selector: #selector(self.networkDidSetup(_:)), name: .jpfNetworkDidSetup, object: nil)
        defaultCenter.addObserver(self, selector: #selector(self.networkDidClose(_:)), name: .jpfNetworkDidClose, object: nil)
        defaultCenter.addObserver(self, selector: #selector(self.networkDidRegister(_:)), name: .jpfNetworkDidRegister, object: nil)
        defaultCenter.addObserver(self, selector: #selector(self.networkFailedRegister(_:)), name: .jpfNetworkFailedRegister, object: nil)
        defaultCenter.addObserver(self, selector: #selector(self.networkDidLogin(_:)), name: .jpfNetworkDidLogin, object: nil)
        defaultCenter.addObserver(self, selector: #selector(self.networkDidReceiveMessage(_:)), name: .jpfNetworkDidReceiveMessage, object: nil)
    }
    
    // MARK: 推送
    // 注册APNs成功并上报DeviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    // 实现注册APNs失败接口
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("did Fail To Register For Remote Notifications With Error: \(error)")
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger is UNPushNotificationTrigger)  {
            JPUSHService.handleRemoteNotification(userInfo)
        }
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
    }
    
    // iOS 7
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(.newData)
        DNJPushManager.shared.didReceiveMessage(userInfo as! Dictionary<String, Any>)
    }
    
    // iOS 6
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
        DNJPushManager.shared.didReceiveMessage(userInfo as! Dictionary<String, Any>)
    }
    
    
    // 推送监听
    func networkDidSetup(_ notification: Notification) {
        print("建立连接")
    }
    
    func networkDidClose(_ notification: Notification) {
        print("关闭连接")
    }
    
    func networkDidRegister(_ notification: Notification) {
        print("注册成功")
    }
    
    func networkFailedRegister(_ notification: Notification) {
        print("注册失败")
    }
    
    func networkDidLogin(_ notification: Notification) {
        print("登录成功")
    }
    
    func networkDidReceiveMessage(_ notification: Notification) {
        let userInfo = notification.userInfo
        DNJPushManager.shared.didReceiveMessage(userInfo as! Dictionary<String, Any>)
    }
 
}

