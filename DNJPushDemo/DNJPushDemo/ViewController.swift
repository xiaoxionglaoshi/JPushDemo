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

    @IBOutlet weak var countLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DNJPushManager.shared.myDelegate = self
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        DNJPushManager.shared.setTags(tags: ["10001"], alias: "dn", object: self) { (res, tags, alias) in
            print(res, tags, alias)
        }
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

