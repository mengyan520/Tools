//
//  NSString+Category.h
//  DCModel
//
//  Created by Carden on 2018/1/18.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Category)
//移除空格和换行
- (NSString *)dc_removeSpacesAndLineBreaks;
//获取字符串高度
- (CGFloat)dc_heightWithFont:(UIFont *)font lineWidth:(CGFloat)width;
//获取字符串宽度(最大宽度限制下)
- (CGFloat)dc_widthWithFont:(UIFont *)font lineWidth:(CGFloat)width;
//获取字符串宽高
- (CGSize)dc_sizeWithFont:(UIFont *)font;
//设置富文本
- (NSMutableAttributedString *)dc_focusSubstring:(NSString *)subString color:(UIColor *)fontColor font:(UIFont *)font;
//检查邮件
- (BOOL)dc_checkEmail;
//检查手机号
- (BOOL)dc_checkPhoneNumber;
@end
