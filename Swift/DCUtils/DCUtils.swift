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
    class  func dc_isNeedUpdate(ver:String) -> Bool {
        let preVer = dc_bundleVersion()
        let curVer = ver
        //比较两个版本
        let preArr = preVer.split(separator: ".")
        let curArr = curVer.split(separator: ".")
        let pV:Int = Int(preArr.joined(separator: "")) ?? 0
        let cV:Int = Int(curArr.joined(separator: "")) ?? 0
        return cV > pV
    }
    //获取版本号
    class  func dc_bundleVersion() -> String {
        
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    //跳转AppStore
    class func dc_jumpToAppleStore() {
        let string = "itms-apps://itunes.apple.com/cn/app/id1043010693?mt=8"
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: string)!, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly : true], completionHandler: nil)
         }else {
            UIApplication.shared.openURL(URL.init(string: string)!)
        }
    }
    ///打电话
    class func dc_callNumber(phone:String) {
        let telUrl = "telprompt:\(phone)"
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: telUrl)!, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly : true], completionHandler: nil)
        }else {
            UIApplication.shared.openURL(URL.init(string: telUrl)!)
        }
        
    }
    /// 验证手机号
    class func dc_verifyPhoneNumber(phoneNumber:String) -> Bool {
        let  MOBILE = "^1[0-9]{10}$";
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",MOBILE)
        return  regextestmobile.evaluate(with: phoneNumber)
    }
    /// 验证密码
    class func dc_verifyPassword(password:String) -> Bool {
        let  pwd = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{8,16}"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",pwd)
        return  regextestmobile.evaluate(with: password)
    }
    /// 验证验证码
    class func dc_verifyVerCode(code:String) -> Bool {
        let pwd  = "^[0-9]{6}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",pwd)
        return  regextestmobile.evaluate(with: code)
    }
    /// 验证身份证号
    class func dc_verifyID(ID:String) -> Bool {
        let pwd = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",pwd)
        return  regextestmobile.evaluate(with: ID)
    }
    ///返回密文手机号
    class func dc_hidePhone(phoneNumber:String) -> String {
        if self.dc_verifyPhoneNumber(phoneNumber: phoneNumber) {
            let phone = NSString.init(string: phoneNumber)
            return phone.replacingCharacters(in: NSMakeRange(3, 5), with:"*****")
        }
        return "*****";
    }
    ///返回对应周几
    class func dc_weekDay(index:Int) -> String {
        var week = "未知";
        switch (index) {
        case 0:
            week = "周日";
            break;
        case 1:
            week =  "周一";
            break;
        case 2:
            week =  "周二";
            break;
        case 3:
            week =  "周三";
            break;
        case 4:
            week =  "周四";
            break;
        case 5:
            week =  "周五";
            break;
        case 6:
            week =  "周六";
            break;
        default:
            break;
        }
        return week
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
        var cookiesData:Data;
        if #available(iOS 12.0, *) {
            cookiesData = try! NSKeyedArchiver.archivedData(withRootObject: HTTPCookieStorage.shared.cookies as Any, requiringSecureCoding: false)
        }else {
            cookiesData = NSKeyedArchiver.archivedData(withRootObject: HTTPCookieStorage.shared.cookies as Any)
            
        }
        self.dc_setObject(data: cookiesData, key: "DCCookies")
    }
    class func dc_loadCookies() {
        if (dc_getObjectForKey(key: "DCCookies") == nil) {
            return
        }
        let  cookies = NSKeyedUnarchiver.unarchiveObject(with: self.dc_getObjectForKey(key: "DCCookies") as! Data) as! [HTTPCookie]
        let cookieStorage = HTTPCookieStorage.shared
        for cookie in cookies {
            cookieStorage.setCookie(cookie)
        }
        
    }
    class func dc_deleteCookies() {
        if (dc_getObjectForKey(key: "DCCookies") == nil) {
            return
        }
        let cookieStorage = HTTPCookieStorage.shared
        for cookie in  HTTPCookieStorage.shared.cookies! {
            cookieStorage.deleteCookie(cookie)
        }
        self.dc_deleteObject(key: "DCCookies")
    }
}
