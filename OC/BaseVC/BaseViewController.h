//
//  BaseViewController.h
//  FYJ
//
//  Created by ma on 2018/7/20.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 *  为navigationBar添加leftBarButtonItems，要么返回UIView类型的对象，要么返回NSArray类型的对象
 *
 *  @return 基类中实现了此方法默认返回nil
 */
- (id)leftItemViews;
/**
 *  为navigationBar添加rightBarButtonItems，要么返回UIView类型的对象，要么返回NSArray类型的对象
 *
 *  @return 基类中实现了此方法默认返回nil
 */
- (id)rightItemViews;
/**
 *  是否要隐藏navigationBar
 *
 *  @return 基类中实现了此方法默认返回NO
 */
- (BOOL)shouldHideNavigationBar;
/**
 *  导航栏背景图片
 *
 *  @return 基类中实现了此方法默认返回nil
 */
- (UIImage *)navigationBarImage;
/**
 *  设置导航栏标题属性
 *
 *  @return 基类中实现了此方法默认返回nil
 */
- (NSDictionary<NSAttributedStringKey, id> *)navigationBarTitleTextAttributes;
/**
 *  决定是否显示返回按钮
 *
 *  @return 基类中实现了此方法默认返回YES
 */
- (BOOL)shouldShowBackItem;
/**
 *  已经默认实现了此方法，只有需要获取返回事件的时候才重写此方法，但必须调用父类的方法
 *
 *  @param button 点击返回的按钮
 */
- (void)backItemAction:(UIButton*)button;
/**
 设置背景颜色
 */
- (UIColor *)backgroundColor;
//network
- (void)showNetFailureView;
- (void)hideNetFailureView;
- (void)fresh:(id)sender;
@end
