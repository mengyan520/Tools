//
//  DCCollectionViewViewController.m
//  FYJ
//
//  Created by ma on 2018/8/21.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import "DCCollectionViewViewController.h"

@interface DCCollectionViewViewController ()
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation DCCollectionViewViewController
#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataArrays = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _layout =  [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.backgroundColor = [self backgroundColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _layout.itemSize = [self itemSize];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"dcCollectionViewCell"];
    [self.view addSubview:_collectionView];
    UIView *topView = [self topView];
    if(topView){
        [self.view addSubview:topView];
    }
    UIView *bottomView = [self bottomView];
    if(bottomView){
        [self.view addSubview:bottomView];
    }
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (topView) {
            make.top.mas_equalTo(topView.mas_bottom);
        }else {
            make.top.mas_equalTo(self.view.mas_top);
        }
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(self.view.frame.size.width);
        if (bottomView) {
             make.bottom.mas_equalTo(bottomView.mas_top);
        }else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
    [self configRefreshUI];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - itemSize
- (CGSize)itemSize {
    return CGSizeMake(33, 33);
}
#pragma mark - 设置刷新属性
- (void)configRefreshUI {
    if ([self shouldShowRefresh]) {
        MJRefreshNormalHeader *refreshheader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestRefresh)];
        refreshheader.lastUpdatedTimeLabel.hidden = YES;
        self.collectionView.mj_header = refreshheader;
    }
    if ([self shouldShowGetMore]) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestGetMore)];
        self.collectionView.mj_footer = footer;
        self.collectionView.mj_footer.hidden = YES;
    }
}
- (void)requestRefresh {
}
- (void)requestGetMore {
}
- (void)toTriggerRequestRefresh {
    [self.collectionView.mj_header beginRefreshing];
}

- (void)toTriggerRequestGetMore {
    [self.collectionView.mj_footer beginRefreshing];
}
- (void)finishRequest {
    if([self.collectionView.mj_header isRefreshing]){
        [self.collectionView.mj_header endRefreshing];
    }
    if([self.collectionView.mj_footer isRefreshing]){
        [self.collectionView.mj_footer endRefreshing];
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
#pragma mark - backgroundColor
- (UIColor *)backgroundColor {
    return RGBA(245, 245, 245, 1);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
