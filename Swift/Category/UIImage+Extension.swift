//
//  UIImage+Extension.swift
//  分类
//
//  Created by Carden on 2018/2/7.
//  Copyright © 2018年 Carden. All rights reserved.
//

import UIKit
extension UIImage {
    //压缩图片,转化为二进制文件
    func dc_compressImage() -> NSData {
        var factor:CGFloat = 1
        var data = UIImageJPEGRepresentation(self, factor)! as NSData
        while data.length/1024/1024  >= 2 {//图片超过2M 压缩
            factor = factor - 0.1;
            if (factor <= 0) {
                break;
            }
            data = UIImageJPEGRepresentation(self, factor)! as NSData
        }
        return data
    }
    //给定宽度，返回图片
    func dc_displayImageWithWidth(width:CGFloat) -> UIImage {
        let height =  self.size.height * width / self.size.width
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
    
        self.draw(in: rect)
       
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
       
        return img!
    }
    //两张图片合成一张图片
   class func dc_synthesisImageWithImage(firstImage:UIImage,otherImage:UIImage) -> UIImage {
        let newImageW = firstImage.size.width + otherImage.size.width;
        let newImageH = firstImage.size.height > otherImage.size.height ?firstImage.size.height:otherImage.size.height;
        UIGraphicsBeginImageContext(CGSize.init(width: newImageW, height: newImageH));
        firstImage.draw(in: CGRect.init(x: 0, y: 0, width: firstImage.size.width, height: firstImage.size.height))
        otherImage.draw(in: CGRect.init(x: firstImage.size.width - 2, y: firstImage.size.height - otherImage.size.height, width: otherImage.size.width, height: otherImage.size.height))
        let contactImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return contactImage!
    }
    //圆角图片
    func dc_imageWithCornerRadius(radius:CGFloat,size:CGSize) -> UIImage {

        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIBezierPath.init(roundedRect: rect, cornerRadius: radius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    //返回指定颜色的图片
   class func dc_imageWithColor(color:UIColor) -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
