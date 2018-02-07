//
//  DCUtils.swift
//  分类
//
//  Created by Carden on 2018/2/7.
//  Copyright © 2018年 Carden. All rights reserved.
//

import UIKit
class DCUtils: NSObject {
    
    //判断版本号
    class  func isNewVersion() -> Bool {
        //  var flag = false
        //已经存储的
        let currentVersion = dc_bundleVersion()
        let version = Double(currentVersion)!
        //比较两个版本
        
        let sandboxVersionKey = "sandboxVersionKey"
        let sandboxVersion = UserDefaults.standard.double(forKey: sandboxVersionKey)
        
        UserDefaults.standard.set(version, forKey: sandboxVersionKey)
        
        return version > sandboxVersion
    }
    //获取版本号
    class  func dc_bundleVersion() -> String {
        
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    //跳转AppStore
    class func dc_jumpToAppleStore() {
        let string = "itms-apps://itunes.apple.com/cn/app/id1043010693?mt=8"
        if #available(iOS 10.0, *) {
        UIApplication.shared.open(URL.init(string: string)!, options: [UIApplicationOpenURLOptionUniversalLinksOnly : true], completionHandler: nil)
         }else {
            UIApplication.shared.openURL(URL.init(string: string)!)
        }
    }
    //callPhone
    class func dc_callNumber(phone:String) {
        let telUrl = "telprompt:\(phone)"
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: telUrl)!, options: [UIApplicationOpenURLOptionUniversalLinksOnly : true], completionHandler: nil)
        }else {
            UIApplication.shared.openURL(URL.init(string: telUrl)!)
        }
        
    }
    //MARK:- UserDefault
    //保存 字典
    class func dc_saveData(data:[String:AnyObject]) {
        for (key,value) in data {
            dc_setObject(data: value, key: key)
        }
    }
    class  func dc_setObject(data:Any,key:String) {
       
       
        UserDefaults.standard.set(data, forKey: key)
        
    }
    class   func dc_getObjectForKey(key:String)->Any? {
        
        return  UserDefaults.standard.object(forKey: key)
    }
    class   func dc_deleteObject(key:String){
        return  UserDefaults.standard.removeObject(forKey: key)
    }
    // MARK: - cookies
    class func dc_saveCookies() {
        
        let cookiesData = NSKeyedArchiver.archivedData(withRootObject: HTTPCookieStorage.shared.cookies as Any)
        for cookie in HTTPCookieStorage.shared.cookies! {
            self.dc_setObject(data: cookie.value, key: cookie.name)
            
        }
        self.dc_setObject(data: cookiesData, key: "DCCookies")
    }
    class func dc_loadCookies() {
        if (dc_getObjectForKey(key: "DCCookies") == nil) {
            return
        }
        
        let cookies = NSKeyedUnarchiver.unarchiveObject(with: self.dc_getObjectForKey(key: "DCCookies") as! Data) as! [HTTPCookie]
        let cookieStorage = HTTPCookieStorage.shared
        for cookie in cookies {
            
            cookieStorage.setCookie(cookie)
        }
        
    }
    class func dc_deleteCookies() {
        let cookieStorage = HTTPCookieStorage.shared
        for cookie in  HTTPCookieStorage.shared.cookies! {
            cookieStorage.deleteCookie(cookie)
        }
        
    }

}
