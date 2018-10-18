//
//  BaseViewController.m
//  FYJ
//
//  Created by ma on 2018/7/20.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [self backgroundColor];
    if([self leftItemViews]){
        [self addItemForLeft:YES withItem:[self leftItemViews] spaceWidth:0];
    }else{
        if([self shouldShowBackItem]){
            [self showBackItem];
        }else{
            self.navigationItem.hidesBackButton = YES;
        }
    }
    if([self rightItemViews]){
        [self addItemForLeft:NO withItem:[self rightItemViews] spaceWidth:0];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:[self shouldHideNavigationBar] animated:YES];
    if ([self navigationBarImage]) {
        [self.navigationController.navigationBar setBackgroundImage:[self navigationBarImage] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
    if ([self navigationBarTitleTextAttributes]) {
        self.navigationController.navigationBar.titleTextAttributes = [self navigationBarTitleTextAttributes];
    }
}
#pragma mark - navView
- (id)leftItemViews {
    return nil;
}
- (id)rightItemViews {
    return nil;
}
- (BOOL)shouldHideNavigationBar {
    return NO;
}
- (BOOL)shouldShowBackItem {
    return YES;
}
- (UIImage *)navigationBarImage {
    return nil;
}
- (NSDictionary<NSAttributedStringKey, id> *)navigationBarTitleTextAttributes {
    return nil;
}
- (void)showBackItem {
    UIButton* btn = [UIButton buttonWithImage:[UIImage imageNamed:@"fh_02_icon"] title:@" 返回" target:self action:@selector(backItemAction:)];
    btn.adjustsImageWhenHighlighted = NO;
    [self addItemForLeft:YES withItem:btn spaceWidth:0];
}
- (void)backItemAction:(UIButton*)button {
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
#pragma mark - backgroundColor
- (UIColor *)backgroundColor {
    return [UIColor whiteColor];
}
- (void)addItemForLeft:(BOOL)left withItem:(id)item spaceWidth:(CGFloat)width {
    if(item == nil){
        return;
    }
    if([item isKindOfClass:[UIView class]]){
        UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil action:nil];
        space.width = width - 10;
        
        if (left) {
            self.navigationItem.leftBarButtonItems = @[space,buttonItem];
        } else {
            self.navigationItem.rightBarButtonItems = @[space,buttonItem];
        }
    }else if ([item isKindOfClass:[NSArray class]]){
        NSArray *buttons = (NSArray *)item;
        
        NSMutableArray *array = [NSMutableArray array];
        [buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[UIView class]]){
                UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:obj];
                UIBarButtonItem *space = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                          target:nil action:nil];
                space.width = width - 10;
                [array addObject:space];
                [array addObject:buttonItem];
            }
        }];
        if (left) {
            self.navigationItem.leftBarButtonItems = array;
        } else {
            self.navigationItem.rightBarButtonItems = array;
        }
    }
}
#pragma mark - 断网状态
- (void)showNetFailureView {
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.tag = 1001010;
    backView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2.0, 150, 100, 100)];
    imageView.image = [UIImage imageNamed:@"net_fail.png"];
    [backView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom+52, SCREEN_WIDTH, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"亲，现在网络不好...";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = RGBA(40, 40, 40,1);
    [backView addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((SCREEN_WIDTH-75)/2.0, label.bottom+20, 75, 22);
    button.layer.cornerRadius = 11;
    button.clipsToBounds = YES;
    button.layer.borderColor = RGBA(40, 40, 40,1).CGColor;
    button.layer.borderWidth = 1;
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    [button setTitleColor:RGBA(40, 40, 40,1) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(fresh:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:button];
    
    [self.view addSubview:backView];
}


- (void)hideNetFailureView {
    UIView *temp = [self.view viewWithTag:1001010];
    [temp removeAllSubViews];
    [temp removeFromSuperview];
}

- (void)fresh:(id)sender
{
    
}
#pragma mark - IOS7
- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}

- (BOOL)automaticallyAdjustsScrollViewInsets
{
    return NO;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@被销毁了", self);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
