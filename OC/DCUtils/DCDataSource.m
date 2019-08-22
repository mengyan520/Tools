//
//  DCDataSource.m
//
//  Created by Carden on 2018/1/8.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import "DCDataSource.h"
@interface DCDataSource ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic,   copy) CellConfigBlock configBlock;
@property (nonatomic, strong) NSString *cellName;
@end
@implementation DCDataSource
#pragma mark - init
- (id)initWithCellIdentifier:(NSString *)cellIdentifier cellName:(NSString *)cellName configCellBlock:(CellConfigBlock)configCellBlock {
    if (self = [super init]) {
        _cellIdentifier = cellIdentifier;
        _cellName = cellName;
        _configBlock = configCellBlock;
        _dataArray = [NSMutableArray array];
    }
    return self;
}
#pragma mark - 模型
- (void)addDataArray:(NSArray *)dataArray {
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:dataArray];
}
- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    
    return _dataArray[indexPath.row];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (!cell) {
        
        cell = [[NSClassFromString(_cellName) alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
    }
    _configBlock(cell,[self itemAtIndexPath:indexPath], indexPath);
    return cell;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
     return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    _configBlock(cell,[self itemAtIndexPath:indexPath],indexPath);
    return cell;
}
@end
