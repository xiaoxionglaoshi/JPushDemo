# JPushDemo
极光推送使用集成JPush三方库,将需要配置的文件以extension形式分离出项目中,在配置时只需一句话注册,在调用的时候也只需调用代理方法即可接受消息
##使用
### AppDelegate中设置
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         // 推送注册
         RegisterJPush(launchOptions: launchOptions)
         return true
     }
     
### 在需要监听推送来消息的ViewController里实现
    DNJPushManager.shared.myDelegate = self
    extension ViewController: DNJPushDelegate {
      func receiveMessage(_ userInfo: Dictionary<String, Any>) {
          print("vc \(userInfo)")
      }
    }

### 特定人推送
    DNJPushManager.shared.setTags(tags: ["10001"], alias: "dn", object: self) { (res, tags, alias) in
       print(res, tags, alias)
    }
