//
//  NSString+Category.m
//  DCModel
//
//  Created by Carden on 2018/1/18.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
- (NSString *)dc_removeSpacesAndLineBreaks
{
    return [[self stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}
#pragma mark - size
- (CGFloat)dc_heightWithFont:(UIFont *)font lineWidth:(CGFloat)width {
   
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        return rect.size.height;
}
- (CGFloat)dc_widthWithFont:(UIFont *)font lineWidth:(CGFloat)width {
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}
- (CGSize)dc_sizeWithFont:(UIFont *)font {
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}
#pragma mark - attributedString
- (NSMutableAttributedString *)dc_focusSubstring:(NSString *)subString color:(UIColor *)fontColor font:(UIFont *)font
{
    NSAssert(nil != fontColor, @"nil color!");
    NSAssert(nil != font, @"nil font");
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:subString];
    if (range.location != NSNotFound) {
        [attributeString setAttributes:@{NSForegroundColorAttributeName:fontColor,NSFontAttributeName:font} range:range];
        
    }else{
        NSLog(@"Could not find the specified substring！");
    }
    return attributeString;
    
}
#pragma mark - email
- (BOOL)dc_checkEmail {

    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
#pragma mark - PhoneNumber
- (BOOL)dc_checkPhoneNumber
{
    NSString *phoneRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
    
}

@end
