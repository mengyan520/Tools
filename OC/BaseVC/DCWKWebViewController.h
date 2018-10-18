//
//  DCWKWebViewController.h
//  FYJ
//
//  Created by ma on 2018/8/31.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import "BaseViewController.h"
extern NSString *const huizhi;
extern NSString *const aboutUs;//关于我们
extern NSString *const buyMoney;//购币说明
@interface DCWKWebViewController : BaseViewController
/**
 网页地址
 */
@property(nonatomic, strong) NSString *urlString;
/**
 网页自定义标题
 */
@property(nonatomic, strong) NSString *wkTitle;
@end
