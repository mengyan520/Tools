//
//  UILable+label.swift
//  SwiftDemo
//
//  Created by ma on 2018/11/12.
//  Copyright © 2018年 ma. All rights reserved.
//

import UIKit
extension UILabel {
    convenience init(textColor:UIColor,fontSize:CGFloat) {
        self.init()
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    convenience init(textColor:UIColor,fontSize:CGFloat,numberOfLines:Int) {
        self.init()
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.numberOfLines = numberOfLines
    }
}
