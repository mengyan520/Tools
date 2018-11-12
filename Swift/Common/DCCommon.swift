//
//  SwiftCommin.swift
//  分类
//
//  Created by Carden on 2018/2/7.
//  Copyright © 2018年 Carden. All rights reserved.
//

import UIKit
// MARK: - 颜色
func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    if #available(iOS 10.0, *) {
        return  UIColor.init(displayP3Red: r/255.0, green:  g/255.0, blue: b/255.0, alpha: a)
    }
    
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func RGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    if #available(iOS 10.0, *) {
        return  UIColor.init(displayP3Red: r/255.0, green:  g/255.0, blue: b/255.0, alpha: 1)
    }
    
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}
func UIColorFromHexValue(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
func UIColorFromHexValue(rgbValue: UInt,alpha:CGFloat) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}
// MARK: - Size
let SCREEN_WIDTH  =  UIScreen.main.bounds.size.width
let SCREEN_HEIGHT =  UIScreen.main.bounds.size.height
let kDevice_Is_iPhoneX = UIApplication.shared.statusBarFrame.size.height>44 ? true : false
let iPhoneX_HomeIndicator:CGFloat   = kDevice_Is_iPhoneX ? 34:0
let StatusBarAndNavigationBarHeight:CGFloat =  (kDevice_Is_iPhoneX ? 88 : 64)
func kScaleW(x:CGFloat)->CGFloat {
    return (x*UIScreen.main.bounds.size.width)/375.00
}
func kScaleH(x:CGFloat)->CGFloat {
    return (x*UIScreen.main.bounds.size.height)/667.00
}
// MARK: - Font
func Font(fontSize: CGFloat) -> UIFont {
    
    return UIFont.systemFont(ofSize: fontSize)
}
//粗体
func BFont(fontSize: CGFloat) -> UIFont {
    
    return UIFont.boldSystemFont(ofSize: fontSize)
    
}
func UIFontFromPixel(pixel:CFloat)->UIFont {
    return UIFont.systemFont(ofSize: CGFloat(pixel * 3 / 4))
}
// MARK: - 常用宏
let Key_Window = UIApplication.shared.keyWindow
// MARK: - 通知
//通知名称
func POSTNOTIFICATION(name: String, data: [AnyHashable : Any]?) {
    
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: nil, userInfo: data )
}
func REMOVENOTIFICATION(sender: AnyObject) {
    NotificationCenter.default.removeObserver(sender)
}
