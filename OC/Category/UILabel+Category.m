//
//  UILabel+Category.m
//  DCModel
//
//  Created by Carden on 2018/1/18.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)
- (UILabel *)initWithTitle:(NSString *)title textColor:(UIColor *)textColor labelFont:(CGFloat)labelFont screenInset:(CGFloat)screeenInset {
    if (self = [super init]) {
        self.text = title;
        self.textColor = textColor;
        self.font = [UIFont systemFontOfSize:labelFont];
        if (screeenInset == 0) {
            self.textAlignment = NSTextAlignmentCenter;
        }else {
            self.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2*screeenInset;
            self.textAlignment = NSTextAlignmentLeft;
        }
    }
    return self;
}
@end
