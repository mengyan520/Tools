//
//  BaseTableViewController.m
//  FYJ
//
//  Created by issuser on 2018/7/18.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()
@end

@implementation BaseTableViewController
- (instancetype)init {
    if (self = [super initWithStyle:[self tableViewStyle]]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [self backgroundColor];
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.separatorColor = UIColorFromRGB(0xF2F2F2);
    self.tableView.tableFooterView = [[UIView alloc]init];
//    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    //拖动退出键盘
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self configRefreshUI];
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tableViewGesture];
}
//取消键盘
- (void)tableViewTouchInSide{
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:[self shouldHideNavigationBar] animated:YES];
}
#pragma mark - 隐藏Cell最后一条分割线
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
#pragma mark - 设置刷新属性
- (void)configRefreshUI {
    if ([self shouldShowRefresh]) {
        MJRefreshNormalHeader *refreshheader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestRefresh)];
        refreshheader.lastUpdatedTimeLabel.hidden = YES;
        self.tableView.mj_header = refreshheader;
    }
    if ([self shouldShowGetMore]) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestGetMore)];
        self.tableView.mj_footer = footer;
    }
}
- (void)requestRefresh {
}
- (void)requestGetMore {
}
- (void)toTriggerRequestRefresh {
    [self.tableView.mj_header beginRefreshing];
}

- (void)toTriggerRequestGetMore {
    [self.tableView.mj_footer beginRefreshing];
}
- (void)finishRequest {
    if([self.tableView.mj_header isRefreshing]){
        [self.tableView.mj_header endRefreshing];
         self.tableView.mj_footer.hidden = NO;
    }
    if([self.tableView.mj_footer isRefreshing]){
        [self.tableView.mj_footer endRefreshing];
    }
}

- (BOOL)shouldShowRefresh {
    return NO;
}
- (BOOL)shouldShowGetMore {
    return NO;
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
#pragma mark - DZNEmptyDataSetSource/DZNEmptyDataSetSourceDelegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = [self titleForEmptyData];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSString *)titleForEmptyData {
    return @"";
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
#pragma mark - tableViewStyle
- (UITableViewStyle)tableViewStyle {
    return UITableViewStylePlain;
}
#pragma mark - backgroundColor
- (UIColor *)backgroundColor {
    return RGBA(245, 245, 245, 1);
}
#pragma mark - 断网状态
- (void)showNetFailureView {
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.tag = 1001010;
    //backView.backgroundColor = [UIColor whiteColor];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2.0, 150 , 100, 100)];
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
@end
