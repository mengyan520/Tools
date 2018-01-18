//
//  UIImage+Category.m
//  DCModel
//
//  Created by Carden on 2018/1/10.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
- (NSData *)dc_compressImage{
    float factor = 1.0f;
    NSData *data = UIImageJPEGRepresentation(self, factor);
    while (data.length/1024/1024  >= 2.00f) { //图片超过2M 压缩
        factor -= 0.1f;
        if (factor <= 0.0f) {
            break;
        }
        data = UIImageJPEGRepresentation(self, factor);
    }
    return data;
}
- (UIImage *)dc_displayImageWithWidth:(CGFloat)width {
        CGFloat heigth = self.size.height * width / self.size.width;
        CGRect rect = CGRectMake(0, 0, width, heigth);
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
        [self drawInRect:rect];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
}
+ (UIImage *)dc_synthesisImageWithImage:(UIImage *)firstImage otherImage:(UIImage *)otherImage {
    CGFloat newImageW = firstImage.size.width + otherImage.size.width;
    CGFloat newImageH = firstImage.size.height > otherImage.size.height?firstImage.size.height:otherImage.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(newImageW, newImageH));
    [firstImage drawInRect:CGRectMake(0, 0, firstImage.size.width, firstImage.size.height)];
    [otherImage drawInRect:CGRectMake(firstImage.size.width - 2, firstImage.size.height - otherImage.size.height, otherImage.size.width, otherImage.size.height)];
    UIImage *contactImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return contactImage;
}
- (UIImage *)dc_imageWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size {
    /* 当前UIImage的可见绘制区域 */
    CGRect rect = (CGRect){0.f,0.f,size};
    /* 创建基于位图的上下文 */
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    /* 在当前位图上下文添加圆角绘制路径 */
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    /* 当前绘制路径和原绘制路径相交得到最终裁剪绘制路径 */
    CGContextClip(UIGraphicsGetCurrentContext());
    /* 绘制 */
    [self drawInRect:rect];
    /* 取得裁剪后的image */
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    /* 关闭当前位图上下文 */
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)dc_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}
@end
