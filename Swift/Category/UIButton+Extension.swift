//
//  UIButton+Extension.swift
//  分类
//
//  Created by Carden on 2018/2/7.
//  Copyright © 2018年 Carden. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(imageName: String, selectImageName: String?,target: AnyObject?, actionName: Selector?) {
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        
        if let selectImageName = selectImageName {
            setBackgroundImage(UIImage(named: selectImageName), for: .selected)
        }
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    
    convenience init(title: String, normalcolor: UIColor?,selectedlColor: UIColor?, fontSize: CGFloat?, target: AnyObject?, actionName: Selector?) {
        self.init()
        
        setTitle(title, for: .normal)
        if let normalcolor = normalcolor {
            setTitleColor(normalcolor, for: .normal)
        }
        if let selectedlColor = selectedlColor {
            setTitleColor(selectedlColor, for: .selected)
        }
        if let fontSize = fontSize {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    
    convenience init(title: String,color: UIColor?,fontSize: CGFloat?,target: AnyObject?, actionName: Selector?) {
        self.init()
        
        setTitle(title, for: .normal)
        if let color = color {
            setTitleColor(color, for: .normal)
        }
        if let fontSize = fontSize {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    convenience init(backImageName: String, target: AnyObject?, actionName: Selector?) {
        self.init()
        
        setBackgroundImage(UIImage(named: backImageName), for: .normal)
        
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    convenience init(imageName: String, target: AnyObject?, actionName: Selector?) {
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    //图片在右,文字在左
    convenience init(title: String, color: UIColor, imageName: String?, fontSize: CGFloat, target: AnyObject?, actionName: Selector?) {
        self.init()
        if let imageName = imageName {
            setImage(UIImage(named: imageName), for: .normal)
        }
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0)
        contentHorizontalAlignment = .left
        let  imageSize = self.imageView!.image!.size
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0,-imageSize.width, 0, imageSize.width)
        
        sizeToFit()
    }
    convenience init(title: String, color: UIColor, SelectedColor: UIColor?, imageName: String?, SelectedImageName: String?, fontSize: CGFloat, target: AnyObject?, actionName: Selector?) {
        self.init()
        if let imageName = imageName {
            setImage(UIImage(named: imageName), for: .normal)
        }
        if let SelectedImageName = SelectedImageName {
            
            setImage(UIImage(named: SelectedImageName), for: .selected)
        }
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        if let color = SelectedColor {
            setTitleColor(color, for: .selected)
        }
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        
        sizeToFit()
    }
    //图片在上,文字在下
    convenience init(title: String, color: UIColor, imageName: String?, SelectedImageName: String?, fontSize: CGFloat, target: AnyObject?, actionName: Selector?) {
        self.init()
        if let imageName = imageName {
            setImage(UIImage(named: imageName), for: .normal)
        }
        if let SelectedImageName = SelectedImageName {
            
            setImage(UIImage(named: SelectedImageName), for: .selected)
        }
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        
        let  spacing: CGFloat = 7.0
        let  imageSize = self.imageView!.image!.size
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0)
        let titleSize = ((self.titleLabel?.text)! as NSString).size(withAttributes: [NSAttributedStringKey.font: self.titleLabel!.font])
        self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
        sizeToFit()
    }
    
}
