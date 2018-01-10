//
//  UIImage+Category.m
//  DCModel
//
//  Created by Carden on 2018/1/10.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
- (NSData *)compressImage{
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
- (UIImage *)displayImageWithWidth:(CGFloat)width {
        CGFloat heigth = self.size.height * width / self.size.width;
        CGRect rect = CGRectMake(0, 0, width, heigth);
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
        [self drawInRect:rect];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
}
+ (UIImage *)synthesisImageWithImage:(UIImage *)firstImage otherImage:(UIImage *)otherImage {
    CGFloat newImageW = firstImage.size.width + otherImage.size.width;
    CGFloat newImageH = firstImage.size.height > otherImage.size.height?firstImage.size.height:otherImage.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(newImageW, newImageH));
    [firstImage drawInRect:CGRectMake(0, 0, firstImage.size.width, firstImage.size.height)];
    [otherImage drawInRect:CGRectMake(firstImage.size.width - 2, firstImage.size.height - otherImage.size.height, otherImage.size.width, otherImage.size.height)];
    UIImage *contactImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return contactImage;
}
@end
