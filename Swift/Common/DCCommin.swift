//
//  SwiftCommin.swift
//  分类
//
//  Created by Carden on 2018/2/7.
//  Copyright © 2018年 Carden. All rights reserved.
//

import UIKit
// MARK: - 颜色
let BLACK_COLOR      = UIColor.black
let DARKGRAY_COLOR   = UIColor.darkGray
let LIGHTGRAY_COLOR  = UIColor.lightGray
let WHITE_COLOR      = UIColor.white
let CLEAR_COLOR      = UIColor.clear
let RED_COLOR        = UIColor.red
let GRAY_COLOR       = UIColor.gray
let YELLOW_COLOR     = UIColor.yellow
let BLUE_COLOR       = UIColor.blue
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
// MARK: - Size
let SCREEN_WIDTH  =  UIScreen.main.bounds.size.width
let SCREEN_HEIGHT =  UIScreen.main.bounds.size.height
let IS_iPhoneX    =  (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812 ? true : false)
let iPhoneX_HomeIndicator   = 34
let StatusBarAndNavigationBarHeight =  (IS_iPhoneX ? 88 : 64)
let iPhoneX_NavigationExtraHeight =  24
// MARK: - Font
func Font(fontSize: CGFloat) -> UIFont {
    
    return UIFont.systemFont(ofSize: fontSize)
}
//粗体
func BFont(fontSize: CGFloat) -> UIFont {
    
    return UIFont.boldSystemFont(ofSize: fontSize)
    
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
