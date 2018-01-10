//
//  UIButton+Category.h
//  DCModel
//
//  Created by Carden on 2018/1/10.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)
+ (UIButton *)setImageName:(NSString *)imageName  selectImageName:(NSString *)selectImageName action:(SEL)action target:(id)target;
+ (UIButton *)setTitle:(NSString *)title normalcolor:(UIColor *)normalColor selectedlColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize action:(SEL)action target:(id)target;
+ (UIButton *)setTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize action:(SEL)action target:(id)target;
+ (UIButton*)setBackImageName:(NSString *)backImageName imageName:(NSString *)imageName action:(SEL)action target:(id)target;
//设置按钮图片在上，文字在下
+ (UIButton *)setTopImgName:(NSString *)imageName bottomTitle:(NSString *)bottomTitle color:(UIColor *)color fontSize:(CGFloat)fontSize  action:(SEL)action target:(id)target;
@end
