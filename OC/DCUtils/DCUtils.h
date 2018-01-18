//
//  DCUtils.h
//  DCModel
//
//  Created by Carden on 2018/1/18.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DCUtils : NSObject
//获取版本号
+ (NSString *)dc_bundleVersion;
//跳转App Store
+ (void)dc_jumpToAppleStore;
//保存数据
+ (void)dc_saveData:(NSDictionary *)data;
+ (void)dc_setObject:(id)data key:(NSString *)key;
+ (void)dc_setBool:(BOOL)data key:(NSString *)key;
//获取数据
+ (id)dc_getObjectForKey:(NSString *)key;
+ (BOOL)dc_getBoolForKey:(NSString *)key;
//删除数据
+ (void)dc_deleteObject:(NSString *)key;
//拨打电话
+ (void)dc_callNumber:(NSString *)phone;
//保存Cookies
+ (void)dc_saveCookies;
//加载Cookies
+ (void)dc_loadCookies;
@end
