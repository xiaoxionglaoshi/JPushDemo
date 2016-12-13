//
//  ViewController.swift
//  DNJPushDemo
//
//  Created by mainone on 16/12/13.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var message: Dictionary<String, Any>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DNJPushManager.shared.myDelegate = self
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            DNJPushManager.shared.setTags(tags: ["10001"], alias: "dn", object: self) { (res, tags, alias) in
                print(res, tags, alias)
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("主动接受的消息: \(message)")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: DNJPushDelegate {
    func receiveMessage(_ userInfo: Dictionary<String, Any>) {
        print("vc \(userInfo)")
        message = userInfo
    }
}

