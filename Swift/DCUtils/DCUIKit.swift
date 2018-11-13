//
//  DCUIKit.swift
//  SwiftDemo
//
//  Created by ma on 2018/11/12.
//  Copyright © 2018年 ma. All rights reserved.
//

import UIKit
class DCUIKit: NSObject {
    
    /// 设置圆形遮罩
    ///
    /// - Parameter rect: 目标bounds
    /// - Returns: CAShapeLayer对象
    class func dc_maskWithRect(rect:CGRect) -> CAShapeLayer {
        let maskPath = UIBezierPath.init(roundedRect: rect, cornerRadius: rect.size.width/2.0)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    /// 设置圆形遮罩
    ///
    /// - Parameter radiiSize: 圆角大小
    /// - Returns: CAShapeLayer对象
    class func dc_maskWithRect(rect:CGRect,radiiSize:CGSize) -> CAShapeLayer {
        let maskPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: radiiSize.width, height: radiiSize.height))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    /// 设置圆形遮罩
    /// - Parameter rectCorners: 圆角范围
    /// - Parameter radiiSize: 圆角大小
    /// - Returns: CAShapeLayer对象
    class func dc_maskWithRect(rect:CGRect,rectCorners:UIRectCorner,radiiSize:CGSize) -> CAShapeLayer {
        let maskPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: rectCorners, cornerRadii: CGSize.init(width: radiiSize.width, height: radiiSize.height))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    
    /// 设置圆角外环
    ///
    /// - Parameters:
    ///   - borderColor: 外环颜色
    ///   - borderWidth: 外环宽度
    /// - Returns: CAShapeLayer对象
    class func dc_maskWithRect(rect:CGRect,borderColor:UIColor,borderWidth:CGFloat) -> CAShapeLayer {
        let maskPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: 5, height: 5))
        let borderLayer = CAShapeLayer.init()
        borderLayer.path = maskPath.cgPath
        borderLayer.fillColor  = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth;
        return borderLayer
    }
    /// 根据View生成图片
    class func dc_makeImage(view:UIView,size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    /// 根据Size缩放图片
    class func dc_scaleToSize(image:UIImage?,size:CGSize) -> UIImage? {
        if image == nil {
            assertionFailure("图片为空")
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image!.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    /// 两张图片合成一张图片,左右合成
    class func dc_synthesisImage(firstImage:UIImage?,otherImage:UIImage?) -> UIImage? {
        if firstImage == nil || otherImage == nil {
            assertionFailure("图片为空")
            return nil
        }
        let newImageW = firstImage!.size.width + otherImage!.size.width;
        let newImageH = firstImage!.size.height > otherImage!.size.height ?firstImage!.size.height:otherImage!.size.height
         UIGraphicsBeginImageContextWithOptions(CGSize.init(width: newImageW, height: newImageH), false, 0)
        firstImage!.draw(in: CGRect.init(x: 0, y: 0, width: firstImage!.size.width, height: firstImage!.size.height))
        otherImage!.draw(in: CGRect.init(x: firstImage!.size.width - 2, y: firstImage!.size.height - otherImage!.size.height, width: otherImage!.size.width, height: otherImage!.size.height))
        let contactImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return contactImage;
    }
    /// 两张图片合成一张图片,上下合成
    class func dc_synthesisImage(topImage:UIImage?,bottomImage:UIImage?) -> UIImage? {
        if topImage == nil || bottomImage == nil {
            assertionFailure("图片为空")
            return nil
        }
        let newImageW =  topImage!.size.width > bottomImage!.size.width ?topImage!.size.width:bottomImage!.size.width
        let newImageH = topImage!.size.height + bottomImage!.size.height
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: newImageW, height: newImageH), false, 0)
        topImage!.draw(in: CGRect.init(x: 0, y: 0, width: topImage!.size.width, height: topImage!.size.height))
        bottomImage!.draw(in: CGRect.init(x: (newImageW-bottomImage!.size.width)/2.0, y: topImage!.size.height, width: bottomImage!.size.width, height: bottomImage!.size.height))
        let contactImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return contactImage;
    }
    
}
