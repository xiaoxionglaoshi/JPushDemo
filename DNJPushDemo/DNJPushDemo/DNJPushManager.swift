//
//  DNJPushManager.swift
//  DNJPushDemo
//
//  Created by mainone on 16/12/13.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

public typealias TagBlock = ((_ res: Bool, _ tags:Set<AnyHashable>, _ alias: String) -> Void)


protocol DNJPushDelegate {
    func receiveMessage(_ userInfo: Dictionary<String, Any>)
}

private let dnJPushManagerShareInstance = DNJPushManager()

class DNJPushManager: NSObject {
    // 创建一个单例
    open class var shared: DNJPushManager {
        return dnJPushManagerShareInstance
    }
    
    var myDelegate: DNJPushDelegate?
    
    private var onTagBlock: TagBlock?
    
    // 监听接收到的消息
    func didReceiveMessage(_ userInfo: Dictionary<String, Any>) {
        self.myDelegate?.receiveMessage(userInfo)
        let badge = (userInfo["aps"] as? Dictionary<String, Any>)?["badge"]
        if let badgeNum = badge as? Int {
            // 同步badge
            setBadge(value: badgeNum)
        }
        
    }
    
    // MARK: 设置标签
    func setTags(tags: Set<AnyHashable>!, alias: String!, object: Any!, callBack: @escaping TagBlock) {
        JPUSHService.setTags(tags, alias: alias) { (iResCode, tags, alias) in
            let res = iResCode == 0 ? true : false
            self.onTagBlock!(res, tags!, alias!)
        }
        onTagBlock = callBack
    }
    
    // MARK: 设置Badge值,存储在JPush服务器上
    func setBadge(value: Int) {
        JPUSHService.setBadge(value)
    }
    
    // MARK: 重置Badge值
    func resetBadge() {
        JPUSHService.setBadge(0)
    }

}
