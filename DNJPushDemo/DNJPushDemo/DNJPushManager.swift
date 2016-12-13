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
    }
    
    // MARK: 设置标签
    func setTags(tags: Set<AnyHashable>!, alias: String!, object: Any!, callBack: @escaping TagBlock) {
        JPUSHService.setTags(tags, alias: alias, callbackSelector: #selector(self.tagsAliasCallback(_:tags:alias:)), object: object)
        onTagBlock = callBack
    }
    
    func tagsAliasCallback(_ iResCode: Int, tags: Set<AnyHashable>!, alias: String!) {
        print(iResCode, tags, alias)
        guard onTagBlock == nil else {
            return
        }
        
        let res = iResCode == 0 ? true : false
        self.onTagBlock!(res, tags, alias)
    }
    
}
