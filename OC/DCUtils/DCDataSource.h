//
//  DCDataSource
//
//  Created by Carden on 2018/1/8.
//  Copyright © 2018年 Carden. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CellConfigBlock)(id cell,id data, NSIndexPath *indexPath);
@interface DCDataSource : NSObject <UITableViewDataSource,UICollectionViewDataSource>

/**
 init
 @param cellIdentifier 标识符
 @param cellName UITableView或者UICollectionView类
 @param configCellBlock 回调
 */
-(id)initWithCellIdentifier:(NSString *)cellIdentifier
           cellName:(NSString *)cellName
     configCellBlock:(CellConfigBlock)configCellBlock;

- (void)addDataArray:(NSArray *)dataArray;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
