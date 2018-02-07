//
//  UIImageView+Extension.swift
//  分类
//
//  Created by Carden on 2018/2/7.
//  Copyright © 2018年 Carden. All rights reserved.
//

import UIKit
extension UIImageView {
    convenience init(imageName:String,target: AnyObject?, actionName: Selector?) {
        self.init()
        image = UIImage.init(named: imageName)
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: target, action: actionName)
        addGestureRecognizer(tap)
    }
    func dc_circleImageWithRadiu(radius:CGFloat) {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        UIBezierPath.init(roundedRect: bounds, cornerRadius: radius).addClip()
        image?.draw(in: bounds)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        self.image = img
    }
}
