//
//  DCUtils.m
//  DCModel
//
//  Created by Carden on 2018/1/18.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import "DCUtils.h"

@implementation DCUtils
#pragma mark - bundleVersion
+ (NSString *)dc_bundleVersion {

    return [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
}
#pragma mark - AppleStore
+ (void)dc_jumpToAppleStore {

    NSString *iTunesLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",@"1043010693"];
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:iTunesLink] options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:nil];
    } else {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }


}
#pragma mark - UserDefault
+ (void)dc_saveData:(NSDictionary *)data {

    [data enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if (obj && ![obj isEqual:[NSNull null]]) {
            [self dc_setObject:[NSString stringWithFormat:@"%@",obj] key:key];
        }
    }];
}
+ (void)dc_setObject:(id)data key:(NSString *)key {

    if (data) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (id)dc_getObjectForKey:(NSString *)key {

    return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+ (void)dc_setBool:(BOOL)data key:(NSString *)key {

    if (data) {
    [[NSUserDefaults standardUserDefaults]setBool:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (BOOL)dc_getBoolForKey:(NSString *)key {

    return  [[NSUserDefaults standardUserDefaults] boolForKey:key];
}
+ (void)dc_deleteObject:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - Cookies
+ (void)dc_saveCookies {
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    [self dc_setObject:cookiesData key:@"DCCookies"];
}


+ (void)dc_loadCookies {

    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [self dc_getObjectForKey:@"DCCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
}
#pragma mark - callPhone
+ (void)dc_callNumber:(NSString *)phone {

    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:telUrl] options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
    }

}
@end
