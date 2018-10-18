//
//  AppNavigationController.m
//  FYJ
//
//  Created by issuser on 2018/7/18.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import "AppNavigationController.h"
#import "LiveAnchorViewController.h"
#import "LivePlayerViewController.h"
#import "ScriptureViewController.h"
#import "PracticeShareViewController.h"
@interface AppNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation AppNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 在这里统一设置UINavigationBar的风格，背景、字体、大小等等
    UIImage *navigationBarImage = [UIImage buildImageWithColor:UIColorFromRGB(0xC02A16)];
    [self.navigationBar setBackgroundImage:navigationBarImage forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL selecter = NSSelectorFromString(@"handleNavigationTransition:");
    _fullscreenPopGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selecter];
    _fullscreenPopGesture.delegate = self;
    [self.view addGestureRecognizer:_fullscreenPopGesture];
    self.interactivePopGestureRecognizer.enabled = NO;
    self.delegate = self;
}
// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 判断条件有两个：1是子控制器数超过一个，2是判断滑动的方向
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc isKindOfClass:[LiveAnchorViewController class]] || [vc isKindOfClass:[LivePlayerViewController class]] || [vc isKindOfClass:[ScriptureViewController class]] || [vc isKindOfClass:[PracticeShareViewController class]]) {
            return NO;
        }
    }
    CGPoint translate = [gestureRecognizer translationInView:self.view];
    BOOL possible = translate.x > 0 && translate.y == 0;
    return possible;
}

// 重写自定义的UINavigationController中的push方法
// 处理tabbar的显示隐藏
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
