//
//  DCTableViewController.m
//  FYJ
//
//  Created by ma on 2018/8/20.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import "DCTableViewController.h"

@interface DCTableViewController ()
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation DCTableViewController
#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:[self tableViewStyle]];
        _tableView.backgroundColor = [self backgroundColor];
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = 200;
        _tableView.separatorColor = UIColorFromRGB(0xF2F2F2);
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //拖动退出键盘
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTouchInSide)];
        tableViewGesture.numberOfTapsRequired = 1;
        tableViewGesture.cancelsTouchesInView = NO;
        [_tableView addGestureRecognizer:tableViewGesture];
        _dataArrays = [NSMutableArray array];
        if (@available(iOS 11.0, *)) {
           _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_tableView];
    UIView *topView = [self topView];
    if(topView){
        [self.view addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top);
            make.left.mas_equalTo(self.view.mas_left);
            make.width.mas_equalTo(self.view.frame.size.width);
            make.height.mas_equalTo(topView.bounds.size.height);
        }];
    }
    UIView *bottomView = [self bottomView];
    if(bottomView){
         [self.view addSubview:bottomView];
    }
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (topView) {
             make.top.mas_equalTo(topView.mas_bottom).offset([self tableViewEdgeInsets].top);
        }else {
            make.top.mas_equalTo(self.view.mas_top).offset([self tableViewEdgeInsets].top);
        }
        make.left.mas_equalTo(self.view.mas_left).offset([self tableViewEdgeInsets].left);
        make.width.mas_equalTo(self.view.frame.size.width-[self tableViewEdgeInsets].left * 2);
        if (bottomView) {
            make.bottom.mas_equalTo(bottomView.mas_top).offset(-[self tableViewEdgeInsets].bottom);
        }else {
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-[self tableViewEdgeInsets].bottom);
        }
    }];
     [self configRefreshUI];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
#pragma mark - 隐藏Cell最后一条分割线
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
#pragma mark - TableViewStyle
- (UITableViewStyle)tableViewStyle {
    return UITableViewStylePlain;
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
#pragma mark - 定制头部视图
- (UIView *)topView {
    return nil;
}
#pragma mark - 定制底部视图
- (UIView *)bottomView {
    return nil;
}
#pragma mark - 取消键盘
- (void)tableViewTouchInSide{
    [_tableView endEditing:YES];
}
#pragma mark - backgroundColor
- (UIColor *)backgroundColor {
    return RGBA(245, 245, 245, 1);
}
#pragma mark - tableView缩进
- (UIEdgeInsets)tableViewEdgeInsets {
    return UIEdgeInsetsZero;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
