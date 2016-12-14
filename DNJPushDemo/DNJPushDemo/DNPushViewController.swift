//
//  DNPushViewController.swift
//  DNJPushDemo
//
//  Created by mainone on 16/12/14.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNPushViewController: UIViewController {

    var message: Dictionary<String, Any>?  {
        didSet {
            print("pushVC: \(message)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DNJPushManager.shared.myDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DNPushViewController: DNJPushDelegate {
    func receiveMessage(_ userInfo: Dictionary<String, Any>) {
        message = userInfo
    }
}
