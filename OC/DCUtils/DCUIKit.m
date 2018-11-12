//
//  DCUIKit.m
//  FYJ
//
//  Created by ma on 2018/7/21.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import "DCUIKit.h"
#import "LoginViewController.h"
#import "AppNavigationController.h"
@implementation DCUIKit
+ (CAShapeLayer *)dc_maskWithRect:(CGRect)rect {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect      byRoundingCorners:UIRectCornerAllCorners   cornerRadii:CGSizeMake(rect.size.width/2.0,rect.size.width/2.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}
+ (CAShapeLayer *)dc_maskWithRect:(CGRect)rect radiiSize:(CGSize)radiiSize{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect      byRoundingCorners:UIRectCornerAllCorners   cornerRadii:radiiSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}
+ (CAShapeLayer *)dc_maskWithRect:(CGRect)rect rectCorners:(UIRectCorner)rectCorners radiiSize:(CGSize)radiiSize {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect      byRoundingCorners:rectCorners cornerRadii:radiiSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}
+ (CAShapeLayer *)dc_maskWithRect:(CGRect)rect borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
     UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect      byRoundingCorners:UIRectCornerAllCorners   cornerRadii:CGSizeMake(5,5)];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path    =   maskPath.CGPath;
    borderLayer.fillColor  = [UIColor clearColor].CGColor;
    borderLayer.strokeColor    = borderColor.CGColor;
    borderLayer.lineWidth      = borderWidth;
    return borderLayer;
}
+ (CGFloat)compressImage:(UIImage *)sourceImage {
    CGFloat f = UIImageJPEGRepresentation(sourceImage, 1).length/1024.0;
    NSLog(@">>>>>>>%.2f",(CGFloat)(f/1024));
    float factor = 1.0f;
    NSData *data = UIImageJPEGRepresentation(sourceImage, factor);
    while (data.length/1024/1024  >= 1.00f) { //图片超过1M 压缩
        factor -= 0.1f;
        if (factor <= 0.0f) {
            break;
        }
        data = UIImageJPEGRepresentation(sourceImage, factor);
    }
    return factor;
}
+ (UIImage *)dc_makeImageWithView:(UIView *)view withSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO,0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)dc_scaleToSize:(UIImage *)img size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
+ (UIImage *)dc_synthesisImageWithImage:(UIImage *)firstImage otherImage:(UIImage *)otherImage {
    CGFloat newImageW = firstImage.size.width + otherImage.size.width;
    CGFloat newImageH = firstImage.size.height > otherImage.size.height?firstImage.size.height:otherImage.size.height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImageW, newImageH), NO, 0.0);
    [firstImage drawInRect:CGRectMake(0, 0, firstImage.size.width, firstImage.size.height)];
    [otherImage drawInRect:CGRectMake(firstImage.size.width - 2, firstImage.size.height - otherImage.size.height, otherImage.size.width, otherImage.size.height)];
    UIImage *contactImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return contactImage;
}
+ (UIImage *)dc_synthesisImageWithImage:(UIImage *)topImage bottomImage:(UIImage *)bottomImage {
    CGFloat newImageW = topImage.size.width > bottomImage.size.width?topImage.size.width:bottomImage.size.width;
    CGFloat newImageH = topImage.size.height + bottomImage.size.height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImageW, newImageH), NO, 0.0);
    [topImage drawInRect:CGRectMake(0, 0, topImage.size.width, topImage.size.height)];
    [bottomImage drawInRect:CGRectMake((newImageW-bottomImage.size.width)/2.0, topImage.size.height, bottomImage.size.width, bottomImage.size.height)];
    UIImage *contactImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return contactImage;
}
+ (void)gotoLogin {
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *controller = keyWindow.rootViewController;
    LoginViewController *vc = [[LoginViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    AppNavigationController *logingNav = [[AppNavigationController alloc]initWithRootViewController:vc];
    [controller presentViewController:logingNav animated:YES completion:nil];
}
@end
