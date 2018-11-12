//
//  DCUIKit.h
//  FYJ
//
//  Created by ma on 2018/7/21.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCUIKit : NSObject
/**
 设置圆形遮罩
 @param rect 目标bounds
 @return CAShapeLayer对象
 */
+ (CAShapeLayer *)dc_maskWithRect:(CGRect)rect;

/**
  设置圆角遮罩

 @param radiiSize 圆角大小
 @return CAShapeLayer对象
 */
+ (CAShapeLayer *)dc_maskWithRect:(CGRect)rect radiiSize:(CGSize)radiiSize;
/**
 自定义部分圆角
 @param rectCorners 圆角范围
 @param radiiSize 圆角大小
 @return CAShapeLayer对象
 */
+ (CAShapeLayer *)dc_maskWithRect:(CGRect)rect rectCorners:(UIRectCorner)rectCorners radiiSize:(CGSize)radiiSize;
/**
 设置圆角外环
 @param borderColor 外环颜色
 @param borderWidth 外环宽度
 */
+ (CAShapeLayer *)dc_maskWithRect:(CGRect)rect borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
/**
 压缩图片倍数
 */
+ (CGFloat)compressImage:(UIImage *)sourceImage;

/**
 根据View生成图片
 */
+ (UIImage *)dc_makeImageWithView:(UIView *)view withSize:(CGSize)size;
/**
根据Size缩放图片
 */
+ (UIImage *)dc_scaleToSize:(UIImage *)img size:(CGSize)size;

/**
 两张图片合成一张图片,左右合成
 */
+ (UIImage *)dc_synthesisImageWithImage:(UIImage *)firstImage otherImage:(UIImage *)otherImage;
/**
 两张图片合成一张图片,上下合成
 */
+ (UIImage *)dc_synthesisImageWithImage:(UIImage *)topImage bottomImage:(UIImage *)bottomImage;
/**
 登录界面
 */
+ (void)gotoLogin;
@end
