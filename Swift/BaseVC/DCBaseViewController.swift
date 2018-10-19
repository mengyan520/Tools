//
//  DCBaseViewController.swift
//  SwiftDemo
//
//  Created by ma on 2018/10/18.
//  Copyright © 2018年 ma. All rights reserved.
//

import UIKit

class DCBaseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.backgroundColor()
        if (self.leftItemViews() != nil) {
            self.addItem(left: true, item: self.leftItemViews() ?? nil, spaceWidth: 0)
        }else {
            if self.shouldShowBackItem() {
                self.showBackItem()
            }else {
                self.navigationItem.hidesBackButton = true
            }
        }
        if (self.rightItemViews() != nil) {
            self.addItem(left: false, item: self.rightItemViews() ?? nil, spaceWidth: 0)
        }
    }
    //点击屏幕退出编辑
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(self.shouldHideNavigationBar(), animated: true)
        if (self.navigationBarImage() != nil) {
            self.navigationController?.navigationBar.setBackgroundImage(self.navigationBarImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage.init()
        }
        if (self.navigationBarTitleTextAttributes() != nil) {
            self.navigationController?.navigationBar.titleTextAttributes = self.navigationBarTitleTextAttributes()
        }
    }
// MARK: - Private Action
    /// 设置导航栏左右按钮
    private func addItem(left:Bool,item:AnyObject?,spaceWidth:CGFloat) {
        if (item == nil) {
            return
        }
        if item!.isKind(of: UIView.self) {
            let buttonItem = UIBarButtonItem.init(customView: item as! UIView)
            let space = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
             space.width = spaceWidth - 10
            if (left) {
                self.navigationItem.leftBarButtonItems = [space,buttonItem];
            } else {
                self.navigationItem.rightBarButtonItems = [space,buttonItem];
            }
        }else if item!.isKind(of: NSArray.self) {
            let buttons = item as! NSArray
            let array = NSMutableArray.init()
            buttons.enumerateObjects { (obj, idx, stop) in
                if (obj as AnyObject).isKind(of: UIView.self) {
                    let buttonItem = UIBarButtonItem.init(customView: obj as! UIView)
                    let space = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
                    space.width = spaceWidth - 10
                    array.add(buttonItem)
                    array.add(space)
                }
            }
            if array.count > 0 {
                if (left) {
                    self.navigationItem.leftBarButtonItems = array as? [UIBarButtonItem];
                } else {
                    self.navigationItem.rightBarButtonItems = array as? [UIBarButtonItem];
                }
            }
        }
    }
//    设置默认返回按钮
    private func showBackItem() {
        let btn = UIButton.init()
        btn.setTitle("返回", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: ""), for: UIControl.State.normal)
        btn.sizeToFit()
        btn.adjustsImageWhenHighlighted = false
        btn.addTarget(self, action: #selector(self.backItemAction(button:)), for: UIControl.Event.touchUpInside)
        self.addItem(left: true, item: btn, spaceWidth: 0)
    }
// MARK: - 公共属性和方法
    /// 设置背景颜色
    /// - Returns: UIColor
    func backgroundColor() -> UIColor {
        return UIColor.white
    }
    /// 为navigationBar添加leftBarButtonItems
    /// - Returns: 要么返回UIView类型的对象，要么返回NSArray类型的对象
    func leftItemViews() -> AnyObject? {
        return nil
    }
    /// 为navigationBar添加rightBarButtonItems
    /// - Returns: 要么返回UIView类型的对象，要么返回NSArray类型的对象
    func rightItemViews() -> AnyObject? {
        return nil
    }
    /// 是否要隐藏navigationBar
    /// - Returns: 基类中实现了此方法默认返回NO
    func shouldHideNavigationBar() -> Bool {
        return false
    }
    /// 导航栏背景图片
    /// - Returns: 基类中实现了此方法默认返回nil
    func navigationBarImage() -> UIImage? {
        return nil
    }
    
    /// 设置导航栏标题属性
    /// - Returns:  基类中实现了此方法默认返回nil
    func navigationBarTitleTextAttributes() -> [NSAttributedString.Key:Any]? {
        return nil
    }
    /// 决定是否显示返回按钮
    /// - Returns: 基类中实现了此方法默认返回YES
    func shouldShowBackItem() -> Bool {
        if (self.navigationController != nil) {
            if self.navigationController?.viewControllers.count ?? 0 > 1 {
                return true
            }else {
                return false
            }
        }else {
            return false;
        }
    }
    ///默认实现了此方法，只有需要获取返回事件的时候才重写此方法，但必须调用父类的方法
    @objc func backItemAction(button:UIButton) {
        if (self.navigationController != nil) {
            if self.navigationController?.viewControllers.count ?? 0 > 1 {
                self.navigationController?.popViewController(animated: true)
            }else {
                self.dismiss(animated: true, completion: nil);
            }
        }else {
            self.dismiss(animated: true, completion: nil);
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
       print(self)
       print("被销毁了")
    }
}
