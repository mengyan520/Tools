//
//  UIView+Frame.swift
//  分类
//
//  Created by Carden on 2018/1/9.
//  Copyright © 2018年 Carden. All rights reserved.
//

import UIKit
extension UIView {
    var top: CGFloat {
        get{
            return frame.origin.y
        }
        set(top) {
            frame.origin.y = top
        }
    }
    var left: CGFloat {
        get{
            return frame.origin.x
        }
        set(top) {
            frame.origin.x = left
        }
    }
    var bottom: CGFloat {
        get{
            return frame.origin.y + frame.size.height
        }
        set(top) {
            frame.origin.y = bottom - frame.size.height
        }
    }
    var right: CGFloat {
        get{
            return frame.origin.x + frame.size.width
        }
        set(top) {
            frame.origin.x = right - bounds.size.width
        }
    }
    var width: CGFloat {
        get{
            return frame.size.width
        }
        set(width) {
            frame.size.width = width
        }
    }
    var height: CGFloat {
        get{
            return frame.size.height
        }
        set(width) {
            frame.size.height = height
        }
    }
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(centerX) {
            center.x  = centerX
        }
    }
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(centerY) {
            center.y  = centerY
        }
    }
    var size: CGSize {
        get{
            return frame.size
        }
        set(size) {
            frame.size = size
        }
    }
    var origin: CGPoint {
        get{
            return frame.origin
        }
        set(origin) {
            frame.origin = origin
        }
    }
}
