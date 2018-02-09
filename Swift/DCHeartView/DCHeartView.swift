//
//  DCHeartView.swift
//  分类
//
//  Created by Carden on 2018/2/8.
//  Copyright © 2018年 Carden. All rights reserved.
//

import UIKit

class DCHeartView: UIView {
        //MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapClick))
        addGestureRecognizer(tap)
        addSubview(backImageView)
        addSubview(fillView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- action
    @objc private func tapClick() {
      
        self.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.35, animations: {
                self.fillView.transform = self.fillView.transform.isIdentity ? CGAffineTransform.init(scaleX: CGFloat(Float.leastNormalMagnitude), y: CGFloat(Float.leastNormalMagnitude)):CGAffineTransform.identity
            }) { (success) in
                self.isUserInteractionEnabled = true
            }
        
    }
    //MARK:- lazy
    //遮罩图片
    var maskImage:UIImage? {
        didSet {
            let maskLayer = CALayer()
            maskLayer.frame = self.bounds
            self.layer.mask = maskLayer
            maskLayer.contents = maskImage?.cgImage
        }
    }
    //背景图片
    var backImage:UIImage? {
        didSet {
            backImageView.image = backImage
        }
    }
    //填充颜色
    var fillColor:UIColor? {
        didSet {
           fillView.backgroundColor = fillColor
           fillView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
    //背景视图
    lazy var backImageView:UIImageView = {
        let backImageView = UIImageView.init(frame: self.bounds)
        backImageView.isUserInteractionEnabled = true
        return backImageView
    }()
    //填充视图
    private lazy var fillView:UIView = {
        let fillView = UIView.init(frame: self.bounds)
        fillView.layer.cornerRadius = self.bounds.size.height / 2.0
        fillView.layer.masksToBounds = true
        return fillView
    }()
}
