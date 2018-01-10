//
//  UIButton+Category.m
//  DCModel
//
//  Created by Carden on 2018/1/10.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)
+ (UIButton *)setImageName:(NSString *)imageName  selectImageName:(NSString *)selectImageName action:(SEL)action target:(id)target {
    UIButton *btn = [[self alloc]init];
    
    if (imageName != nil && ![imageName isEqualToString:@""]) {
        [btn  setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (selectImageName != nil && ![selectImageName isEqualToString:@""]) {
        [btn  setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    }
    if (action) {
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [btn sizeToFit];
    return  btn;
}
+ (UIButton *)setTitle:(NSString *)title normalcolor:(UIColor *)normalColor selectedlColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize action:(SEL)action target:(id)target {
    UIButton *btn = [[self alloc]init];
    if (title != nil && ![title isEqualToString:@""]) {
        
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (fontSize) {
        
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    if (normalColor) {
        
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (selectedColor) {
        
        [btn setTitleColor:selectedColor forState:UIControlStateNormal];
    }
    if (action) {
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [btn sizeToFit];
    return  btn;
}
+ (UIButton *)setTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize action:(SEL)action target:(id)target {
    UIButton *btn = [[self alloc]init];
    if (title != nil && ![title isEqualToString:@""]) {
        
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (fontSize) {
        
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    if (color) {
        
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (action) {
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [btn sizeToFit];
    return  btn;
}
+ (UIButton*)setBackImageName:(NSString *)backImageName imageName:(NSString *)imageName action:(SEL)action target:(id)target {
    UIButton *btn = [[self alloc]init];
    if (backImageName != nil && ![backImageName isEqualToString:@""]) {
        
        [btn  setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
        
    }
    if (imageName != nil && ![imageName isEqualToString:@""]) {
        [btn  setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (action) {
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [btn sizeToFit];
    return  btn;
}
+ (UIButton *)setTopImgName:(NSString *)imageName bottomTitle:(NSString *)bottomTitle color:(UIColor *)color fontSize:(CGFloat)fontSize  action:(SEL)action target:(id)target {
    UIButton *btn = [[self alloc]init];
    if (bottomTitle != nil && ![bottomTitle isEqualToString:@""]) {
        
        [btn setTitle:bottomTitle forState:UIControlStateNormal];
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (imageName != nil && ![imageName isEqualToString:@""]) {
        [btn  setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (fontSize) {
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn setAdjustsImageWhenHighlighted:NO];
    CGFloat spacing = 7.0;
    CGSize imageSize = btn.imageView.image.size;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    CGSize titleSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: btn.titleLabel.font}];
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return  btn;
}
@end
