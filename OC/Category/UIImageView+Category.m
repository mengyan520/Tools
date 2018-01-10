//
//  UIImageView+Category.m
//  DCModel
//
//  Created by Carden on 2018/1/10.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)
- (UIImageView *)initWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
    if (self = [super init]) {
    self.image = [UIImage imageNamed:imageName];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    }
    return self;
        
}
@end
