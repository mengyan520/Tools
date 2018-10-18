//
//  DCTableViewController.h
//  FYJ
//
//  Created by ma on 2018/8/20.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import "BaseViewController.h"

@interface DCTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArrays;//数据源
/**
 默认返回UITableViewStylePlain
 */
- (UITableViewStyle)tableViewStyle;
/**
 *  如果不想要下拉刷新，子类需要重写这个方法并返回NO
 *
 *  @return 默认为NO
 */
- (BOOL)shouldShowRefresh;
/**
 *  如果不想要上拉加载更多，子类需要重写这个方法并返回NO
 *
 *  @return 默认为NO
 */
- (BOOL)shouldShowGetMore;
/**
 *  子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
 */
- (void)requestRefresh;
/**
 *  子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
 */
- (void)requestGetMore;
/**
 *  配置列表header和footer刷新数据的UI，已经有默认配置
 */
- (void)configRefreshUI;
/**
 触发刷新刷新动作
 */
- (void)toTriggerRequestRefresh;

/**
 触发上拉加载动作
 */
- (void)toTriggerRequestGetMore;
/**
 请求完成，不管成功或者失败必须手动调用此方法结束刷新动画
 */
- (void)finishRequest;
/**
 *  如果想定制顶部固定的view，子类需要重写此方法
 *
 *  @return 默认为nil
 */
- (UIView *)topView;
/**
 *  如果想定制底部固定的view，子类需要重写此方法
 *
 *  @return 默认为nil
 */
- (UIView *)bottomView;
/**
 *  如果想定制UITableView相对于四边的缩进，子类需要重写此方法
 *
 *  @return 默认返回UIEdgeInsetsZero
 */
- (UIEdgeInsets)tableViewEdgeInsets;
@end
