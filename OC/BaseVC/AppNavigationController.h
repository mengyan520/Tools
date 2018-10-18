//
//  AppNavigationController.h
//  FYJ
//
//  Created by issuser on 2018/7/18.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppNavigationController : UINavigationController
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fullscreenPopGesture;
@end
