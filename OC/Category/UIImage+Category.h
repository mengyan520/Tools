//
//  UIImage+Category.h
//  DCModel
//
//  Created by Carden on 2018/1/10.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
//压缩图片,转化为二进制文件
- (NSData *)compressImage;
//给定宽度，返回图片
- (UIImage *)displayImageWithWidth:(CGFloat)width;
//两张图片合成一张图片
+ (UIImage *)synthesisImageWithImage:(UIImage *)firstImage otherImage:(UIImage *)otherImage;
@end
