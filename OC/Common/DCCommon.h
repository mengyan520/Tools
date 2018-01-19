//
//  DCCommon.h
//  DCModel
//
//  Created by Carden on 2018/1/18.
//  Copyright © 2018年 Carden. All rights reserved.
//

#ifndef DCCommon_h
#define DCCommon_h
#pragma mark - Color

#define BLACK_COLOR         [UIColor blackColor]
#define DARKGRAY_COLOR      [UIColor darkGrayColor]
#define LIGHTGRAY_COLOR     [UIColor lightGrayColor]
#define WHITE_COLOR         [UIColor whiteColor]
#define GRAY_COLOR          [UIColor grayColor]
#define RED_COLOR           [UIColor redColor]
#define GREEN_COLOR         [UIColor greenColor]
#define BLUE_COLOR          [UIColor blueColor]
#define CYAN_COLOR          [UIColor cyanColor]
#define YELLOW_COLOR        [UIColor yellowColor]
#define MAGENTA_COLOR       [UIColor magentaColor]
#define ORANGE_COLOR        [UIColor orangeColor]
#define PURPLE_COLOR        [UIColor purpleColor]
#define BROWN_COLOR         [UIColor brownColor]
#define CLEAR_COLOR         [UIColor clearColor]
#define RGB_COLOR(R,G,B)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define RGBA_COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0  alpha:A]
#define UIColorFromHexValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromHexValueAlpha(rgbValue,myAlpha) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:myAlpha]
#pragma mark - font
#define FONT(A)   [UIFont systemFontOfSize:A]
#define BFONT(A)  [UIFont boldSystemFontOfSize:A]


#pragma mark - Size

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IS_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define iPhoneX_HomeIndicator 34
#define StatusBarAndNavigationBarHeight  (IS_iPhoneX ? 88.f : 64.f)
#define iPhoneX_NavigationExtraHeight 24
#pragma mark - Device

#define iPad    ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)?YES:NO
#define iPhone  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)?YES:NO


#pragma mark - SDK Version

#define SystemVersion [[UIDevice currentDevice] systemVersion]

#pragma mark - IOS7
#define IOS7Later ([SystemVersion floatValue] >=7.0)

#define IOS8Later ([SystemVersion floatValue] >=8.0)
#endif /* DCCommon_h */
